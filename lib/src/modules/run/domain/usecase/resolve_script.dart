import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:path/path.dart' as path;
import 'package:slidy/src/core/errors/errors.dart';

import '../entities/script.dart';
import '../entities/slidy_pipeline_v1.dart';

abstract class ResolveScript {
  Either<SlidyError, Script> call(String command, SlidyPipelineV1 pipeline);
}

class ResolveScriptImpl implements ResolveScript {
  ResolveScriptImpl();

  @override
  Either<SlidyError, Script> call(String command, SlidyPipelineV1 pipeline) {
    var script = pipeline.scripts[command];
    if (script == null) {
      return Left(SlidyError('Command not found'));
    }

    final resolvedScript = script.copyWith(
      name: resolveWithVariables(script.name, pipeline),
      description: resolveWithVariables(script.description, pipeline),
      workingDirectory: resolveWithVariables(script.workingDirectory, pipeline),
    );

    final steps = resolvedScript.steps.map((step) {
      final stepDir = resolveWithVariables(step.workingDirectory, pipeline);
      final workingDirectory = resolveWorkingDirectory(resolvedScript.workingDirectory, stepDir);
      final run = resolveWithVariables(step.run, pipeline);
      return step.copyWith(
        run: run,
        workingDirectory: workingDirectory,
        name: step.name != null ? resolveWithVariables(step.name!, pipeline) : '',
        description: resolveWithVariables(step.description, pipeline),
      );
    }).toList();

    return Right(resolvedScript.copyWith(steps: steps));
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

  String resolveWithVariables(String text, SlidyPipelineV1 pipeline) {
    text = resolveVariable(text, pipeline.localVariables, r'(?<var>\$\{Local\.(?<key>\w+)\})');
    text = resolveVariable(text, pipeline.systemVariables, r'(?<var>\$\{System\.env\.(?<key>\w+)\})');
    text = resolveSystemVariables(text);
    return text;
  }

  String resolveVariable(String text, Map<String, String> variables, String regexText) {
    final regex = RegExp(regexText);
    final matches = regex.allMatches(text);
    for (var match in matches) {
      final variable = match.namedGroup('var');
      final key = match.namedGroup('key');
      if (variable != null && variables.containsKey(key)) {
        text = text.replaceFirst(variable, variables[key]!);
      }
    }
    return text;
  }

  String resolveSystemVariables(String text) {
    return resolveVariable(
        text,
        {
          'operatingSystem': Platform.operatingSystem,
          'pathSeparator': Platform.pathSeparator,
          'operatingSystemVersion': Platform.operatingSystemVersion,
        },
        r'(?<var>\$\{System\.(?<key>\w+)\})');
  }
}
