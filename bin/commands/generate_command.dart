import 'command_base.dart';
import 'sub_command/generate_mobx_sub_command.dart';
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
    addSubcommand(GenerateMobxSubCommand());
    addSubcommand(GenerateMobxAbbrSubCommand());
  }

  @override
  String? get invocationSuffix => null;
}

class GenerateCommandAbbr extends GenerateCommand {
  @override
  final name = 'g';
}
