import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class GenerateUsecaseSubCommand extends CommandBase {
  @override
  final name = 'usecase';
  @override
  final description = 'Creates a usecase';

  GenerateUsecaseSubCommand() {
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
      Generate.usecase(argResults.rest.first, !argResults['notest'],
          argResults['interface']);
    }
  }
}

class GenerateUsecaseAbbrSubCommand extends GenerateUsecaseSubCommand {
  @override
  final name = 'uc';
}
