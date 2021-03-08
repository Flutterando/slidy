import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

import '../../prints/prints.dart';
import '../../templates/rx_notifier.dart';
import '../../utils/template_file.dart';
import '../../utils/utils.dart' as utils;
import '../command_base.dart';
import '../install_command.dart';

class GenerateRxNotifierSubCommand extends CommandBase {
  @override
  final name = 'rxnotifier';
  @override
  final description = 'Creates a RxNotifier Controller';

  GenerateRxNotifierSubCommand() {
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
    final templateFile = await TemplateFile.getInstance(argResults?.rest.single ?? '', 'controller');

    if (!await templateFile.checkDependencyIsExist('rx_notifier')) {
      var command = CommandRunner('slidy', 'CLI')..addCommand(InstallCommand());
      await command.run(['install', 'rx_notifier']);
    }

    var result = await Slidy.instance.template
        .createFile(info: TemplateInfo(yaml: rxnotifierFile, destiny: templateFile.file, key: 'rx_notifier'));
    execute(result);
    if (result.isRight) {
      await utils.injectParentModule(argResults!['injection'], '${templateFile.fileNameWithUppeCase}Controller()',
          templateFile.import, templateFile.file.parent);
    }

    if (!argResults!['notest']) {
      result = await Slidy.instance.template.createFile(
          info: TemplateInfo(
              yaml: rxnotifierFile,
              destiny: templateFile.fileTest,
              key: 'rx_notifier_test',
              args: [templateFile.fileNameWithUppeCase + 'Controller', templateFile.import]));
      execute(result);
    }
  }

  @override
  String? get invocationSuffix => null;
}

class GenerateRxNotifierAbbrSubCommand extends GenerateRxNotifierSubCommand {
  @override
  final name = 'rx';
}
