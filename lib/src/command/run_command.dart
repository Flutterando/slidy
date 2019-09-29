import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/modules/run.dart';

class RunCommand extends CommandBase {
  final name = "run";
  final description = "run scripts in pubspec.yaml";
  final invocationSufix = "<project name>";

  void run() {
    if (argResults.rest.isEmpty) {
      throw UsageException("script name not passed for a run command", usage);
    } else {
      runCommand(argResults.rest);
    }
  }
}
