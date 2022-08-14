import 'dart:async';
import 'dart:io';

import 'package:slidy/slidy.dart';
import 'package:slidy/src/core/prints/prints.dart' as output;
import 'package:slidy/src/modules/run/domain/usecase/execute_script.dart';
import 'package:slidy/src/modules/run/domain/usecase/load_slidy_pipeline.dart';
import 'package:slidy/src/modules/run/domain/usecase/resolve_script.dart';

import 'command_base.dart';

class RunCommand extends CommandBase {
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
    final loader = Slidy.instance.get<LoadSlidyPipeline>();
    final resolver = Slidy.instance.get<ResolveScript>();
    final executor = Slidy.instance.get<ExecuteScript>();

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
    var fileSchema = File(schema);

    final result = await loader(fileSchema) //
        .flatMap((pipeline) => resolver.call(command, pipeline).toTaskEither())
        .flatMap((r) => executor.call(r))
        .map((r) => 'Success!')
        .mapLeft((l) => l.message)
        .run();

    result.fold(output.error, output.success);
  }
}
