import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/modules/run.dart';

class RunCommand extends CommandBase {
  @override
  final name = 'run';
  @override
  final description = 'run scripts in pubspec.yaml';
  @override
  final invocationSuffix = '<project name>';
  @override
  void run() {
    if (argResults.rest.isEmpty) {
      throw UsageException('script name not passed for a run command', usage);
    } else {
      runCommand(argResults.rest);
    }
  }
}
