import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class GenerateRepositorySubCommand extends CommandBase {
  @override
  String get name => 'repository';
  @override
  String get description => 'Creates a repository';

  GenerateRepositorySubCommand() {
    argParser.addFlag('notest',
        abbr: 'n', negatable: false, help: 'no create file test'
        //Add in future configured the release android sign
        );

    argParser.addFlag('interface',
        abbr: 'i', negatable: false, help: 'create file with interface');
  }

  @override
  void run() {
    if (argResults.rest.isEmpty) {
      throw UsageException('value not passed for a module command', usage);
    } else {
      Generate.repository(
        path: argResults.rest.first,
        isTest: !argResults['notest'],
        withInterface: argResults['interface'],
      );
    }
  }
}

class GenerateRepositoryAbbrSubCommand extends GenerateRepositorySubCommand {
  @override
  String get name => 'r';
}
