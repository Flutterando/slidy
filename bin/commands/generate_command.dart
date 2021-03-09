import 'command_base.dart';
import 'sub_command/clean_dart/generate_data_source_sub_command.dart';
import 'sub_command/clean_dart/generate_use_case_sub_command.dart';
import 'sub_command/generate_mobx_sub_command.dart';
import 'sub_command/generate_bloc_sub_command.dart';
import 'sub_command/generate_cubit_sub_command.dart';
import 'sub_command/generate_module_sub_command.dart';
import 'sub_command/generate_rx_notifier_sub_command.dart';
import 'sub_command/generate_repository_sub_command.dart';
import 'sub_command/generate_page_sub_command.dart';
import 'sub_command/generate_service_sub_command.dart';
import 'sub_command/generate_triple_sub_command.dart';
import 'sub_command/generate_widget_sub_command.dart';

class GenerateCommand extends CommandBase {
  @override
  final name = 'generate';
  @override
  final description = 'Creates a module, page, widget or repository according to the option.';

  GenerateCommand() {
    addSubcommand(GenerateModuleSubCommand());
    addSubcommand(GenerateModuleAbbrSubCommand());
    addSubcommand(GenerateTripleSubCommand());
    addSubcommand(GenerateTripleAbbrSubCommand());
    addSubcommand(GenerateMobxSubCommand());
    addSubcommand(GenerateMobxAbbrSubCommand());
    addSubcommand(GenerateBlocSubCommand());
    addSubcommand(GenerateBlocAbbrSubCommand());
    addSubcommand(GenerateRxNotifierSubCommand());
    addSubcommand(GenerateRxNotifierAbbrSubCommand());
    addSubcommand(GenerateRepositorySubCommand());
    addSubcommand(GenerateRepositoryAbbrSubCommand());
    addSubcommand(GenerateServiceSubCommand());
    addSubcommand(GenerateServiceAbbrSubCommand());
    addSubcommand(GenerateCubitSubCommand());
    addSubcommand(GenerateCubitAbbrSubCommand());
    addSubcommand(GeneratePageSubCommand());
    addSubcommand(GeneratePageAbbrSubCommand());
    addSubcommand(GenerateWidgetSubCommand());
    addSubcommand(GenerateWidgetAbbrSubCommand());
    addSubcommand(GenerateUseCaseAbbrSubCommand());
    addSubcommand(GenerateDataSourceAbbrSubCommand());
  }

  @override
  String? get invocationSuffix => null;
}

class GenerateCommandAbbr extends GenerateCommand {
  @override
  final name = 'g';
}
