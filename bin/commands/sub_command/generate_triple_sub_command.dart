import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

import '../../prints/prints.dart';
import '../../templates/triple.dart';
import '../../utils/template_file.dart';
import '../../utils/utils.dart' as utils;
import '../command_base.dart';
import '../install_command.dart';

class GenerateTripleSubCommand extends CommandBase {
  @override
  final name = 'triple';
  @override
  final description = 'Creates a Triple Store';

  GenerateTripleSubCommand() {
    argParser.addFlag('notest', abbr: 'n', negatable: false, help: 'Don`t create file test');
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

    if (!await templateFile.checkDependencyIsExist('flutter_triple')) {
      var command = CommandRunner('slidy', 'CLI')..addCommand(InstallCommand());
      await command.run(['install', 'flutter_triple']);
    }

    var result = await Slidy.instance.template.createFile(info: TemplateInfo(yaml: tripleFile, destiny: templateFile.file, key: 'triple'));
    execute(result);
    if (result.isRight) {
      await utils.injectParentModule(argResults!['bind'], '${templateFile.fileNameWithUppeCase}Store()', templateFile.import, templateFile.file.parent);
    }

    if (!argResults!['notest']) {
      result = await Slidy.instance.template
          .createFile(info: TemplateInfo(yaml: tripleFile, destiny: templateFile.fileTest, key: 'triple_test', args: [templateFile.fileNameWithUppeCase + 'Store', templateFile.import]));
      execute(result);
    }
  }

  @override
  String? get invocationSuffix => null;
}

class GenerateTripleAbbrSubCommand extends GenerateTripleSubCommand {
  @override
  final name = 't';
}
