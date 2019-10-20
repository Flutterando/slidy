import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class GenerateTestSubCommand extends CommandBase {
  final name = "test";
  final description = "Creates a Test file";

  void run() {
    if (argResults.rest.isEmpty) {
      throw UsageException("value not passed for a module command", usage);
    } else {
      Generate.test(argResults.rest.first);
    }
  }
}

class GenerateTestAbbrSubCommand extends GenerateTestSubCommand {
  final name = "t";
}
