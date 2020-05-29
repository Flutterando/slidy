import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class GenerateServiceSubCommand extends CommandBase {
  @override
  final name = 'service';
  @override
  final description = 'Creates a service';

  GenerateServiceSubCommand() {
    argParser.addFlag('interface',
        abbr: 'i', negatable: false, help: 'Creates a service interface');
    argParser.addFlag('notest',
        abbr: 'n', negatable: false, help: 'no create file test');

    argParser.addFlag('interface',
        abbr: 'i', negatable: false, help: 'create file with interface');
  }
  @override
  void run() {
    if (argResults.rest.isEmpty) {
      throw UsageException('value not passed for a module command', usage);
    } else {
      Generate.service(argResults.rest.first, !argResults['notest'],
          argResults['interface']);
    }
  }
}

class GenerateServiceAbbrSubCommand extends GenerateServiceSubCommand {
  @override
  final name = 's';
}
