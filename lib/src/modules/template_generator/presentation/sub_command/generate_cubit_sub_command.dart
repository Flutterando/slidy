import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

import '../../../../core/command/command_base.dart';
import '../../domain/models/template_info.dart';
import '../../domain/usecases/create.dart';
import '../templates/bloc.dart';
import '../utils/template_file.dart';
import '../utils/utils.dart' as utils;

class GenerateCubitSubCommand extends CommandBase {
  @override
  final name = 'cubit';
  @override
  final description = 'Creates a Cubit file';

  GenerateCubitSubCommand() {
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
    final templateFile = await TemplateFile.getInstance(argResults?.rest.single ?? '', 'cubit');

    if (!await templateFile.checkDependencyIsExist('bloc')) {
      var command = CommandRunner('slidy', 'CLI')..addCommand(InstallCommand());
      await command.run(['install', 'bloc@8.0.3', 'flutter_bloc@8.0.1']);
      await command.run(['install', 'bloc_test@9.0.3', '--dev']);
    }

    var result = await Modular.get<Create>().call(TemplateInfo(yaml: blocFile, destiny: templateFile.file, key: 'cubit'));
    execute(result);
    if (result.isRight()) {
      if (argResults!['page'] == true) {
        await utils.addedInjectionInPage(templateFile: templateFile, pathCommand: argResults!.rest.single, noTest: !argResults!['notest'], type: 'Cubit');
      }
      await utils.injectParentModule(argResults!['bind'], '${templateFile.fileNameWithUppeCase}Cubit()', templateFile.import, templateFile.file.parent);
    }

    if (!argResults!['notest']) {
      result =
          await Modular.get<Create>().call(TemplateInfo(yaml: blocFile, destiny: templateFile.fileTest, key: 'cubit_test', args: [templateFile.fileNameWithUppeCase + 'Cubit', templateFile.import]));
      execute(result);
    }
  }

  @override
  String? get invocationSuffix => null;
}

class GenerateCubitAbbrSubCommand extends GenerateCubitSubCommand {
  @override
  final name = 'c';
}
