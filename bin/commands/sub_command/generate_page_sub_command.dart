import 'dart:async';

import 'package:slidy/slidy.dart';

import 'package:slidy/src/core/prints/prints.dart';
import '../../templates/widgets.dart';
import '../../utils/template_file.dart';
import '../command_base.dart';
import '../../utils/utils.dart' as utils;

class GeneratePageSubCommand extends CommandBase {
  @override
  final name = 'page';
  @override
  final description = 'Creates a Page file';

  GeneratePageSubCommand() {
    argParser.addFlag('notest', abbr: 'n', negatable: false, help: 'Don`t create file test');
    argParser.addOption('routing', abbr: 'r', help: 'Define routing path in parent module');
  }

  @override
  FutureOr run() async {
    final templateFile = await TemplateFile.getInstance(argResults?.rest.single ?? '', 'page');

    var result = await Slidy.instance.template.createFile(info: TemplateInfo(yaml: widgetsFile, destiny: templateFile.file, key: 'page'));
    execute(result);

    if (argResults!['routing'] != null) {
      await utils.injectParentModuleRouting(
          argResults!['routing'], '${templateFile.fileNameWithUppeCase}Page()', templateFile.import, templateFile.file.parent);
    }

    if (!argResults!['notest']) {
      result = await Slidy.instance.template.createFile(
          info: TemplateInfo(
              yaml: widgetsFile,
              destiny: templateFile.fileTest,
              key: 'page_test',
              args: [templateFile.fileNameWithUppeCase + 'Page', templateFile.import]));
      execute(result);
    }
  }

  @override
  String? get invocationSuffix => null;
}

class GeneratePageAbbrSubCommand extends GeneratePageSubCommand {
  @override
  final name = 'p';
}
