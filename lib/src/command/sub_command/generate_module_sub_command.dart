import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class GenerateModuleSubCommand extends CommandBase {
  @override
  final String name = 'module';
  @override
  final String description = 'Creates a module';

  GenerateModuleSubCommand() {
    argParser.addFlag('complete',
        abbr: 'c',
        negatable: false,
        help: 'Creates a module with Page and Controller/Bloc files');
    argParser.addFlag('noroute',
        abbr: 'n',
        negatable: false,
        help: 'Creates a module withless named route');

    argParser.addFlag('withrepository',
        abbr: 'r', negatable: false, help: 'Creates a module with repository');

    argParser.addFlag('withInterface',
        abbr: 'i',
        negatable: false,
        help: 'create file with interface for repository');
  }

  @override
  void run() {
    if (argResults.rest.isEmpty) {
      throw UsageException('value not passed for a module command', usage);
    } else {
      Generate.module(
        path: argResults.rest.first,
        createCompleteModule: argResults['complete'],
        noroute: argResults['noroute'],
        withRepository: argResults['withrepository'],
        withInterface: argResults['withInterface'],
      );
    }
  }
}

class GenerateModuleAbbrSubCommand extends GenerateModuleSubCommand {
  @override
  String get name => 'm';
}
