import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class GenerateRepositorySubCommand extends CommandBase {
  @override
  final name = 'repository';
  @override
  final description = 'Creates a repository';

  GenerateRepositorySubCommand() {
    argParser.addFlag('notest',
        abbr: 'n', negatable: false, help: 'no create file test'
        //Add in future configured the release android sign
        );

    argParser.addFlag(
      'interface',
      abbr: 'i',
      negatable: false,
      help: 'create file with interface',
    );

    argParser.addFlag(
      'hasura',
      abbr: 'u',
      negatable: false,
      help: 'create file with hasura',
    );
  }

  @override
  void run() {
    if (argResults.rest.isEmpty) {
      throw UsageException('value not passed for a module command', usage);
    } else {
      Generate.repository(argResults.rest.first, !argResults['notest'],
          argResults['interface'], argResults['hasura']);
    }
  }
}

class GenerateRepositoryAbbrSubCommand extends GenerateRepositorySubCommand {
  @override
  final name = 'r';
}
