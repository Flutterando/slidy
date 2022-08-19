import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/core/services/yaml_service.dart';

import '../../../../core/command/command_base.dart';
import '../../domain/models/template_info.dart';
import '../../domain/usecases/create.dart';
import '../templates/module.dart';
import '../utils/template_file.dart';
import '../utils/utils.dart' as utils;

class GenerateModuleSubCommand extends CommandBase {
  @override
  final name = 'module';

  @override
  final description = 'Creates a module';

  GenerateModuleSubCommand() {
    argParser.addFlag('notest', abbr: 'n', negatable: false, help: 'Don`t create file test');
    argParser.addFlag('complete', abbr: 'c', negatable: true, help: 'Creates a module with Page and Controller/Store files (Triple, MobX, BLoC, Cubit...)');
  }

  @override
  FutureOr run() async {
    if (argResults?.rest.isNotEmpty == false) {
      throw UsageException('value not passed for a module command', usage);
    }

    var templateFile = await TemplateFile.getInstance(argResults?.rest.single ?? '', 'module');
    templateFile = await TemplateFile.getInstance('${argResults!.rest.first}/${templateFile.fileName}', 'module');

    var result = await Modular.get<Create>().call(TemplateInfo(key: 'module', destiny: templateFile.file, yaml: generateFile));
    execute(result);

    if (!argResults!['notest']) {
      result = await Modular.get<Create>()
          .call(TemplateInfo(yaml: generateFile, destiny: templateFile.fileTest, key: 'module_test', args: [templateFile.fileNameWithUppeCase + 'Module', templateFile.import]));
      execute(result);
    }

    if (argResults!['complete'] != true) return;

    var command = CommandRunner('slidy', 'CLI')..addCommand(GenerateCommand());
    final yamlService = Modular.get<YamlService>();
    final node = yamlService.getValue(['dependencies']);
    final smList = ['flutter_triple', 'triple', 'flutter_bloc', 'bloc', 'flutter_mobx', 'bloc', 'rx_notifier'];
    final selected = node?.value.keys.firstWhere((element) => smList.contains(element)) as String;

    await command.run(['generate', selected.replaceFirst('flutter_', ''), '${argResults!.rest.first}/${templateFile.fileName}', '--page']);
    templateFile = await TemplateFile.getInstance('${argResults!.rest.first}/${templateFile.fileName}', 'page');

    await utils.injectParentModuleRouting('/', '${templateFile.fileNameWithUppeCase}Page()', templateFile.import, templateFile.file.parent);
  }

  @override
  String? get invocationSuffix => null;
}

class GenerateModuleAbbrSubCommand extends GenerateModuleSubCommand {
  @override
  final name = 'm';
}
