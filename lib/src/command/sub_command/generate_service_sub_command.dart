import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class GenerateServiceSubCommand extends CommandBase {
  final name = "service";
  final description = "Creates a service";

  GenerateServiceSubCommand() {
    argParser.addFlag('notest',
        abbr: 'n',
        negatable: false,
        help:
            'no create file test'
        );
  }

  void run() {
    if (argResults.rest.isEmpty) {
      throw UsageException("value not passed for a module command", usage);
    } else {
      Generate.service(argResults.rest.first, !argResults["notest"]);
    }
  }
}

class GenerateServiceAbbrSubCommand extends GenerateServiceSubCommand {
  final name = "s";
}
