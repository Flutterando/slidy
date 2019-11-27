import 'package:slidy/slidy.dart';
import 'package:slidy/src/command/sub_command/generate_bloc.dart';
import 'package:slidy/src/command/sub_command/generate_controller.dart';
import 'package:slidy/src/command/sub_command/generate_model_sub_command.dart';
import 'package:slidy/src/command/sub_command/generate_service_sub_command.dart';
import 'package:slidy/src/command/sub_command/generate_test_sub_command.dart';

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
    addSubcommand(GenerateBlocSubCommand());
    addSubcommand(GenerateBlocAbbrSubCommand());
    addSubcommand(GenerateControllerSubCommand());
    addSubcommand(GenerateControllerAbbrSubCommand());
    addSubcommand(GenerateRepositorySubCommand());
    addSubcommand(GenerateRepositoryAbbrSubCommand());
    addSubcommand(GenerateServiceSubCommand());
    addSubcommand(GenerateServiceAbbrSubCommand());
    addSubcommand(GenerateTestSubCommand());
    addSubcommand(GenerateTestAbbrSubCommand());
    addSubcommand(GenerateModelSubCommand());
    addSubcommand(GenerateModelAbbrSubCommand());
  }
}

class GenerateCommandAbbr extends GenerateCommand {
  final name = "g";
}
