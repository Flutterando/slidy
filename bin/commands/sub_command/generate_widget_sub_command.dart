import 'dart:async';

import 'package:slidy/slidy.dart';

import '../../prints/prints.dart';
import '../../templates/widgets.dart';
import '../../utils/template_file.dart';
import '../command_base.dart';

class GenerateWidgetSubCommand extends CommandBase {
  @override
  final name = 'widget';

  @override
  final description = 'Creates a Widget file';

  GenerateWidgetSubCommand() {
    argParser.addFlag('notest', abbr: 'n', negatable: false, help: 'Don`t create file test');
    argParser.addOption('injection',
        abbr: 'i',
        allowed: [
          'singleton',
          'lazy-singleton',
          'factory',
        ],
        defaultsTo: 'lazy-singleton',
        allowedHelp: {
          'singleton': 'Object persist while module exists',
          'lazy-singleton': 'Object persist while module exists, but only after being called first for the fist time',
          'factory': 'A new object is created each time it is called.',
        },
        help: 'Define type injection in parent module');
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
