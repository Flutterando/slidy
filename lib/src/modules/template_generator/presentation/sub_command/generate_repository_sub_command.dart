import 'dart:async';
import 'dart:io';

import 'package:slidy/slidy.dart';

import '../../../../core/command/command_base.dart';
import '../../domain/models/template_info.dart';
import '../../domain/usecases/create.dart';
import '../templates/repository.dart';
import '../utils/template_file.dart';
import '../utils/utils.dart' as utils;

class GenerateRepositorySubCommand extends CommandBase {
  @override
  final name = 'repository';
  @override
  final description = 'Creates a Repository';

  GenerateRepositorySubCommand() {
    argParser.addFlag('notest', abbr: 'n', negatable: false, help: 'Don`t create file test');
    argParser.addFlag('interface', abbr: 'i', negatable: false, help: 'Create Repository Inteface');
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
    final templateFile = await TemplateFile.getInstance(argResults?.rest.single ?? '', 'repository');
    var result = await Modular.get<Create>().call(
      TemplateInfo(
        yaml: repositoryFile,
        destiny: templateFile.file,
        key: argResults!['interface'] ? 'impl_repository' : 'repository',
      ),
    );
    execute(result);
    if (result.isRight()) {
      await utils.injectParentModule(argResults!['bind'], '${templateFile.fileNameWithUppeCase}Repository()', templateFile.import, templateFile.file.parent);
    }

    if (argResults!['interface']) {
      print('${templateFile.file.parent.path}/${templateFile.fileName}_interface.dart');
      result = await Modular.get<Create>().call(TemplateInfo(
          yaml: repositoryFile,
          destiny: File('${templateFile.file.parent.path}/${templateFile.fileName}_repository_interface.dart'),
          key: 'i_repository',
          args: [templateFile.fileNameWithUppeCase + 'Repository', templateFile.import]));
      execute(result);
    }

    if (!argResults!['notest']) {
      result = await Modular.get<Create>()
          .call(TemplateInfo(yaml: repositoryFile, destiny: templateFile.fileTest, key: 'test_repository', args: [templateFile.fileNameWithUppeCase + 'Repository', templateFile.import]));
      execute(result);
    }
  }

  @override
  String? get invocationSuffix => null;
}

class GenerateRepositoryAbbrSubCommand extends GenerateRepositorySubCommand {
  @override
  final name = 'r';
}
