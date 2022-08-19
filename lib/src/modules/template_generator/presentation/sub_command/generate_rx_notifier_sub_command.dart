import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

import '../../../../core/command/command_base.dart';
import '../../domain/models/template_info.dart';
import '../../domain/usecases/create.dart';
import '../templates/rx_notifier.dart';
import '../utils/template_file.dart';
import '../utils/utils.dart' as utils;

class GenerateRxNotifierSubCommand extends CommandBase {
  @override
  final name = 'rx_notifier';
  @override
  final description = 'Creates a RxNotifier Controller';

  GenerateRxNotifierSubCommand() {
    argParser.addFlag('notest', abbr: 'n', negatable: false, help: 'Don`t create file test');
    argParser.addFlag('page', abbr: 'p', negatable: true, help: 'Create a Page file');
    argParser.addOption('bind',
        abbr: 'b',
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

    var result = await Modular.get<Create>().call(TemplateInfo(yaml: rxnotifierFile, destiny: templateFile.file, key: 'rx_notifier'));
    execute(result);
    if (result.isRight()) {
      if (argResults!['page'] == true) {
        await utils.addedInjectionInPage(templateFile: templateFile, pathCommand: argResults!.rest.single, noTest: !argResults!['notest'], type: 'Controller');
      }
      await utils.injectParentModule(argResults!['bind'], '${templateFile.fileNameWithUppeCase}Controller()', templateFile.import, templateFile.file.parent);
    }

    if (!argResults!['notest']) {
      result = await Modular.get<Create>()
          .call(TemplateInfo(yaml: rxnotifierFile, destiny: templateFile.fileTest, key: 'rx_notifier_test', args: [templateFile.fileNameWithUppeCase + 'Controller', templateFile.import]));
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
