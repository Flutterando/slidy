import 'package:slidy/slidy.dart';

class GenerateCommand extends CommandBase {
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
