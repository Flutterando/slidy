import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class GeneratePageSubCommand extends Command {
  final name = "page";
  final description = "Creates a page";

  GeneratePageSubCommand() {
    argParser.addFlag('bloc',
        abbr: 'b', negatable: false, help: "Creates a page without Bloc file");
  }

  void run() {
    if (argResults.rest.isEmpty) {
      throw new UsageException("value not passed for a module command", usage);
    } else {
      Generate.page(argResults.rest.first, argResults["bloc"]);
    }
  }
}

class GeneratePageAbbrSubCommand extends GeneratePageSubCommand {
  final name = "p";
}