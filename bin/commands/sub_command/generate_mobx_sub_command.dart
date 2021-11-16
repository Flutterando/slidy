import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

import 'package:slidy/src/core/prints/prints.dart';
import '../../templates/mobx.dart';
import '../../utils/template_file.dart';
import '../../utils/utils.dart' as utils;
import '../command_base.dart';
import '../install_command.dart';

class GenerateMobxSubCommand extends CommandBase {
  @override
  final name = 'mobx';
  @override
  final description = 'Creates a Mobx Store';

  GenerateMobxSubCommand() {
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
    final templateFile = await TemplateFile.getInstance(argResults?.rest.single ?? '', 'store');

    if (!await templateFile.checkDependencyIsExist('mobx')) {
      var command = CommandRunner('slidy', 'CLI')..addCommand(InstallCommand());
      await command.run(['install', 'flutter_mobx@2.0.0-nullsafety.0', 'mobx@2.0.0-nullsafety.2']);
      await command.run(['install', 'mobx_codegen', 'build_runner', '--dev']);
    }

    var result = await Slidy.instance.template.createFile(info: TemplateInfo(yaml: mobxFile, destiny: templateFile.file, key: 'mobx'));
    execute(result);
    if (result.isRight()) {
      if (argResults!['page'] == true) {
        await utils.addedInjectionInPage(
            templateFile: templateFile, pathCommand: argResults!.rest.single, noTest: !argResults!['notest'], type: 'Store');
      }
      await utils.injectParentModule(
          argResults!['bind'], '${templateFile.fileNameWithUppeCase}Store()', templateFile.import, templateFile.file.parent);
    }

    if (!argResults!['notest']) {
      result = await Slidy.instance.template.createFile(
          info: TemplateInfo(
              yaml: mobxFile,
              destiny: templateFile.fileTest,
              key: 'mobx_test',
              args: [templateFile.fileNameWithUppeCase + 'Store', templateFile.import]));
      execute(result);
    }
  }

  @override
  String? get invocationSuffix => null;
}

class GenerateMobxAbbrSubCommand extends GenerateMobxSubCommand {
  @override
  final name = 'mbx';
}
