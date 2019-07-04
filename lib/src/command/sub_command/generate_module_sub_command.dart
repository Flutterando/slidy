import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class GenerateModuleSubCommand extends CommandBase {
  final name = "module";
  final description = "Creates a module";

  GenerateModuleSubCommand() {
    argParser.addFlag('complete',
        abbr: 'c',
        negatable: false,
        help: "Creates a module with Page and Bloc files");
  }

  void run() {
    if (argResults.rest.isEmpty) {
      throw UsageException("value not passed for a module command", usage);
    } else {
      Generate.module(argResults.rest.first, argResults["complete"]);
    }
  }
}

class GenerateModuleAbbrSubCommand extends GenerateModuleSubCommand {
  final name = "m";
}
