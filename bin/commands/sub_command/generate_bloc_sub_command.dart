import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

import '../../prints/prints.dart';
import '../../templates/bloc.dart';
import '../../templates/triple.dart';
import '../../utils/template_file.dart';
import '../../utils/utils.dart' as utils;
import '../command_base.dart';
import '../install_command.dart';

class GenerateBlocSubCommand extends CommandBase {
  @override
  final name = 'bloc';
  @override
  final description = 'Creates a BLoC file';

  GenerateBlocSubCommand() {
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
    final templateFile = await TemplateFile.getInstance(argResults?.rest.single ?? '', 'bloc');

    if (!await templateFile.checkDependencyIsExist('bloc')) {
      var command = CommandRunner('slidy', 'CLI')..addCommand(InstallCommand());
      await command.run(['install', 'bloc', 'flutter_bloc']);
      await command.run(['install', 'bloc_test']);
    }

    var result = await Slidy.instance.template.createFile(info: TemplateInfo(yaml: blocFile, destiny: templateFile.file, key: 'bloc'));
    execute(result);
    if (result.isRight) {
      await utils.injectParentModule(argResults!['injection'], '${templateFile.fileNameWithUppeCase}Bloc()', templateFile.import, templateFile.file.parent);
    }

    // if (!argResults!['notest']) {
    //   result = await Slidy.instance.template
    //       .createFile(info: TemplateInfo(yaml: tripleFile, destiny: templateFile.fileTest, key: 'triple_test', args: [templateFile.fileNameWithUppeCase + 'Store', templateFile.import]));
    //   execute(result);
    // }
  }

  @override
  String? get invocationSuffix => null;
}

class GenerateBlocAbbrSubCommand extends GenerateBlocSubCommand {
  @override
  final name = 'b';
}
