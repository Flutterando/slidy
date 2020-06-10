import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class GenerateTestSubCommand extends CommandBase {
  @override
  String get name => 'test';
  @override
  String get description => 'Creates a Test file';
  @override
  void run() {
    if (argResults.rest.isEmpty) {
      throw UsageException('value not passed for a module command', usage);
    } else {
      Generate.test(argResults.rest.first);
    }
  }
}

class GenerateTestAbbrSubCommand extends GenerateTestSubCommand {
  @override
  String get name => 't';
}
