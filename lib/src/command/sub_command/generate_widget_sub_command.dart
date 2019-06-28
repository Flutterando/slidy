import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class GenerateWidgetSubCommand extends Command {
  final name = "widget";
  final description = "Creates a widget";

  GenerateWidgetSubCommand() {
    argParser.addFlag('bloc',
        abbr: 'b',
        negatable: false,
        help: "Creates a widget without Bloc file");
    argParser.addFlag('sufix',
        abbr: 's',
        negatable: false,
        help: "Creates a widget without a \"Widget\" sufix.");
  }

  void run() {
    if (argResults.rest.isEmpty) {
      throw new UsageException("value not passed for a module command", usage);
    } else {
      Generate.widget(
          argResults.rest.first, argResults["bloc"], argResults["sufix"]);
    }
  }
}

class GenerateWidgetAbbrSubCommand extends GenerateWidgetSubCommand {
  final name = "w";
}