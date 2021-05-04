import 'dart:async';
import 'dart:io';

import 'package:slidy/slidy.dart';

import 'package:slidy/src/core/prints/prints.dart';
import '../../templates/service.dart';
import '../../utils/template_file.dart';
import '../../utils/utils.dart' as utils;
import '../command_base.dart';

class GenerateServiceSubCommand extends CommandBase {
  @override
  final name = 'service';
  @override
  final description = 'Creates a Service';

  GenerateServiceSubCommand() {
    argParser.addFlag('notest', abbr: 'n', negatable: false, help: 'Don`t create file test');
    argParser.addFlag('interface', abbr: 'i', negatable: false, help: 'Create Service Inteface');
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
    final templateFile = await TemplateFile.getInstance(argResults?.rest.single ?? '', 'service');
    var result = await Slidy.instance.template.createFile(
      info: TemplateInfo(
        yaml: serviceFile,
        destiny: templateFile.file,
        key: argResults!['interface'] ? 'impl_service' : 'service',
      ),
    );
    execute(result);
    if (result.isRight()) {
      await utils.injectParentModule(
        argResults!['bind'],
        '${templateFile.fileNameWithUppeCase}Service()',
        templateFile.import,
        templateFile.file.parent,
      );
    }

    if (argResults!['interface']) {
      print('${templateFile.file.parent.path}/${templateFile.fileName}_interface.dart');
      result = await Slidy.instance.template.createFile(
          info: TemplateInfo(
              yaml: serviceFile,
              destiny: File('${templateFile.file.parent.path}/${templateFile.fileName}_service_interface.dart'),
              key: 'i_service',
              args: [templateFile.fileNameWithUppeCase + 'Service', templateFile.import]));
      execute(result);
    }

    if (!argResults!['notest']) {
      result = await Slidy.instance.template
          .createFile(info: TemplateInfo(yaml: serviceFile, destiny: templateFile.fileTest, key: 'test_service', args: [templateFile.fileNameWithUppeCase + 'Service', templateFile.import]));
      execute(result);
    }
  }

  @override
  String? get invocationSuffix => null;
}

class GenerateServiceAbbrSubCommand extends GenerateServiceSubCommand {
  @override
  final name = 's';
}
