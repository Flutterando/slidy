import 'command_base.dart';
import 'sub_command/generate_module_sub_command.dart';
import 'sub_command/generate_triple_sub_command.dart';

class GenerateCommand extends CommandBase {
  @override
  final name = 'generate';
  @override
  final description = 'Creates a module, page, widget or repository according to the option.';
  final abbr = 'g';

  GenerateCommand() {
    addSubcommand(GenerateModuleSubCommand());
    addSubcommand(GenerateModuleAbbrSubCommand());
    addSubcommand(GenerateTripleSubCommand());
    addSubcommand(GenerateTripleAbbrSubCommand());
    // addSubcommand(GeneratePageSubCommand());
    // addSubcommand(GeneratePageAbbrSubCommand());
    // addSubcommand(GenerateWidgetSubCommand());
    // addSubcommand(GenerateWidgetAbbrSubCommand());
    // addSubcommand(GenerateBlocSubCommand());
    // addSubcommand(GenerateBlocAbbrSubCommand());
    // addSubcommand(GenerateStoreSubCommand());
    // addSubcommand(GenerateControllerSubCommand());
    // addSubcommand(GenerateControllerAbbrSubCommand());
    // addSubcommand(GenerateStoreAbbrSubCommand());
    // addSubcommand(GenerateRepositorySubCommand());
    // addSubcommand(GenerateRepositoryAbbrSubCommand());
    // addSubcommand(GenerateServiceSubCommand());
    // addSubcommand(GenerateServiceAbbrSubCommand());
    // addSubcommand(GenerateTestSubCommand());
    // addSubcommand(GenerateTestAbbrSubCommand());
    // addSubcommand(GenerateModelSubCommand());
    // addSubcommand(GenerateModelAbbrSubCommand());
  }

  @override
  String? get invocationSuffix => null;
}

class GenerateCommandAbbr extends GenerateCommand {
  @override
  final name = 'g';
}
