import 'dart:async';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:path/path.dart' as path;
import 'package:slidy/slidy.dart';
import 'package:slidy/src/core/prints/prints.dart' as output;
import 'package:slidy/src/modules/run/domain/entities/slidy_pipeline_v1.dart';
import 'package:slidy/src/modules/run/domain/usecase/execute_script.dart';
import 'package:slidy/src/modules/run/domain/usecase/load_slidy_pipeline.dart';
import 'package:slidy/src/modules/run/domain/usecase/resolve_variables.dart';

import 'command_base.dart';

class RunCommand extends CommandBase {
  final loader = Slidy.instance.get<LoadSlidyPipeline>();
  final resolveVariables = Slidy.instance.get<ResolveVariables>();
  final executor = Slidy.instance.get<ExecuteStep>();

  RunCommand() {
    argParser.addOption(
      'schema',
      abbr: 's',
      defaultsTo: 'slidy.yaml',
      help: 'Select a config YAML file.',
    );
  }

  @override
  final name = 'run';
  @override
  final description = 'run scripts in pipeline';
  @override
  final invocationSuffix = null;
  @override
  FutureOr run() async {
    final commands = argResults?.rest ?? [];

    if (commands.length > 1) {
      output.error('Many commands!');
      return;
    }

    if (commands.isEmpty) {
      output.error('Please, use \'slidy run --help\'');
      return;
    }
    final command = commands.first;

    final schema = argResults?['schema'] ?? 'slidy.yaml';
    final fileSchema = File(schema);

    final result = await loader(fileSchema) //
        .flatMap((pipeline) => executeScript(command, pipeline))
        .mapLeft((l) => l.message)
        .run();

    result.fold(output.error, output.success);
  }

  TaskEither<SlidyError, String> executeScript(String command, SlidyPipelineV1 pipeline) {
    return TaskEither(() async {
      var script = pipeline.scripts[command];
      if (script == null) {
        return Left(SlidyError('Command not found'));
      }

      var resolvedScript = script.copyWith(
        name: resolveVariables(script.name, pipeline).getOrElse((l) => script.name),
        description: resolveVariables(script.description, pipeline).getOrElse((l) => script.description),
        workingDirectory: resolveVariables(script.workingDirectory, pipeline).getOrElse((l) => script.workingDirectory),
      );

      final steps = resolvedScript.steps.map((step) {
        final stepDir = resolveVariables(step.workingDirectory, pipeline).getOrElse((l) => script.workingDirectory);
        final workingDirectory = resolveWorkingDirectory(resolvedScript.workingDirectory, stepDir);
        return step.copyWith(
          workingDirectory: workingDirectory,
          environment: {
            ...script.environment ?? {},
            ...step.environment ?? {},
          },
        );
      }).toList();

      resolvedScript = resolvedScript.copyWith(steps: steps);

      print('Script:  ${output.green(script.name)}');
      if (script.description.isNotEmpty) {
        print('Description:  ${output.green(script.description)}');
      }
      print('\n---------------- STEPS --------------\n');

      for (var step in resolvedScript.steps) {
        final pipelineVarUpdate = pipeline.copyWith(
          systemVariables: {
            ...Platform.environment,
            ...step.environment ?? {},
          },
        );
        step = step.copyWith(
          name: step.name == null ? null : resolveVariables(step.name!, pipelineVarUpdate).getOrElse((l) => step.name!),
          description: resolveVariables(step.description, pipelineVarUpdate).getOrElse((l) => step.description),
          run: resolveVariables(step.run, pipelineVarUpdate).getOrElse((l) => step.run),
        );

        if (step.name != null) {
          print('Step:  ${output.green(step.name!)}');
        }
        if (step.description.isNotEmpty) {
          print('Description:  ${output.green(step.description)}');
        }
        if (step.name != null || step.description.isNotEmpty) {
          print('\n');
        }
        final result = await executor(step);
        if (!result) {
          return Left(SlidyError('Step \'${step.name}\' failure.'));
        }
        print('\n----------- END STEP ----------\n');
      }
      return Right('Success!');
    });
  }

  String resolveWorkingDirectory(String scriptDirectory, String stepDirectory) {
    var workingDirectory = path.join(scriptDirectory, stepDirectory);
    workingDirectory = path.normalize(workingDirectory);

    if (Platform.isWindows) {
      workingDirectory = workingDirectory.replaceAll(r'/', r'\');
    } else {
      workingDirectory = workingDirectory.replaceAll(r'\', r'/');
    }

    workingDirectory = path.canonicalize(workingDirectory);

    return workingDirectory;
  }
}
