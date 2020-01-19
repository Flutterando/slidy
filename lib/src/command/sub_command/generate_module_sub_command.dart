import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class GenerateModuleSubCommand extends CommandBase {
  @override
  final name = 'module';
  @override
  final description = 'Creates a module';

  GenerateModuleSubCommand() {
    argParser.addFlag('complete',
        abbr: 'c',
        negatable: false,
        help: 'Creates a module with Page and Controller/Bloc files');
    argParser.addFlag('noroute',
        abbr: 'n',
        negatable: false,
        help: 'Creates a module withless named route');
  }

  @override
  void run() {
    if (argResults.rest.isEmpty) {
      throw UsageException('value not passed for a module command', usage);
    } else {
      Generate.module(
          argResults.rest.first, argResults['complete'], argResults['noroute']);
    }
  }
}

class GenerateModuleAbbrSubCommand extends GenerateModuleSubCommand {
  @override
  final name = 'm';
}
