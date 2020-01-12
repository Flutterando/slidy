import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class GenerateModelSubCommand extends CommandBase {
  final name = "model";
  final description = "Creates a model";

  GenerateModelSubCommand() {
    argParser.addFlag('notest',
        abbr: 'n', negatable: false, help: 'no create file test');

    argParser.addFlag('rx',
        abbr: 'r', negatable: false, help: 'create reactive model');
  }

  void run() {
    if (argResults.rest.isEmpty) {
      throw UsageException("value not passed for a module command", usage);
    } else {
      Generate.model(argResults.rest, !argResults["notest"], argResults["rx"]);
    }
  }
}

class GenerateModelAbbrSubCommand extends GenerateModelSubCommand {
  final name = "mm";
}
