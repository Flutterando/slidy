import 'dart:async';

import 'package:slidy/slidy.dart';

import 'package:slidy/src/core/prints/prints.dart';
import '../../templates/widgets.dart';
import '../../utils/template_file.dart';
import '../command_base.dart';

class GenerateWidgetSubCommand extends CommandBase {
  @override
  final name = 'widget';

  @override
  final description = 'Creates a Widget file';

  GenerateWidgetSubCommand() {
    argParser.addFlag('notest',
        abbr: 'n', negatable: false, help: 'Don`t create file test');
  }

  @override
  FutureOr run() async {
    final templateFile =
        await TemplateFile.getInstance(argResults?.rest.single ?? '', 'widget');

    var result = await Slidy.instance.template.createFile(
        info: TemplateInfo(
            yaml: widgetsFile, destiny: templateFile.file, key: 'widget'));
    execute(result);

    if (!argResults!['notest']) {
      result = await Slidy.instance.template.createFile(
          info: TemplateInfo(
              yaml: widgetsFile,
              destiny: templateFile.fileTest,
              key: 'page_test',
              args: [
            templateFile.fileNameWithUppeCase + 'Widget',
            templateFile.import
          ]));
      execute(result);
    }
  }

  @override
  String? get invocationSuffix => null;
}

class GenerateWidgetAbbrSubCommand extends GenerateWidgetSubCommand {
  @override
  final name = 'w';
}
