import 'package:args/command_runner.dart';
import 'package:slidy/src/command/sub_command/generate_page_sub_command.dart';
import 'package:slidy/src/command/sub_command/generate_repository_sub_command.dart';
import 'package:slidy/src/command/sub_command/generate_widget_sub_command.dart';

import 'sub_command/generate_module_sub_command.dart';

class GenerateCommand extends Command {
  final name = "generate";
  final description =
      "Creates a module, page, widget or repository according to the option.";
  final abbr = "g";

  GenerateCommand() {
    addSubcommand(GenerateModuleSubCommand());
    addSubcommand(GenerateModuleAbbrSubCommand());
    addSubcommand(GeneratePageSubCommand());
    addSubcommand(GeneratePageAbbrSubCommand());
    addSubcommand(GenerateWidgetSubCommand());
    addSubcommand(GenerateWidgetAbbrSubCommand());
    addSubcommand(GenerateRepositorySubCommand());
    addSubcommand(GenerateRepositoryAbbrSubCommand());
  }
}

class GenerateCommandAbbr extends GenerateCommand {
  final name = "g";
}
