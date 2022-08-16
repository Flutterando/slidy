import 'dart:async';

import 'package:slidy/slidy.dart';

import '../../../../core/command/command_base.dart';
import '../../domain/models/template_info.dart';
import '../templates/widgets.dart';
import '../utils/template_file.dart';

class GenerateWidgetSubCommand extends CommandBase {
  @override
  final name = 'widget';

  @override
  final description = 'Creates a Widget file';

  GenerateWidgetSubCommand() {
    argParser.addFlag('notest', abbr: 'n', negatable: false, help: 'Don`t create file test');
  }

  @override
  FutureOr run() async {
    final templateFile = await TemplateFile.getInstance(argResults?.rest.single ?? '', 'widget');

    var result = await Slidy.instance.template.createFile(info: TemplateInfo(yaml: widgetsFile, destiny: templateFile.file, key: 'widget'));
    execute(result);

    if (!argResults!['notest']) {
      result = await Slidy.instance.template
          .createFile(info: TemplateInfo(yaml: widgetsFile, destiny: templateFile.fileTest, key: 'page_test', args: [templateFile.fileNameWithUppeCase + 'Widget', templateFile.import]));
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
