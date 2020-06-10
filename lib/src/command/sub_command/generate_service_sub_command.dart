import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class GenerateServiceSubCommand extends CommandBase {
  @override
  String get name => 'service';
  @override
  String get description => 'Creates a service';

  GenerateServiceSubCommand() {
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
      Generate.service(
        path: argResults.rest.first,
        isTest: !argResults['notest'],
        withInterface: argResults['interface'],
      );
    }
  }
}

class GenerateServiceAbbrSubCommand extends GenerateServiceSubCommand {
  @override
  String get name => 's';
}
