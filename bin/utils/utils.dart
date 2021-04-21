import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/modules/template_creator/domain/models/line_params.dart';

import '../commands/generate_command.dart';
import '../prints/prints.dart';
import 'template_file.dart';

Future injectParentModule(String injectionType, String fileNameWithUppeCase, String import, Directory directory) async {
  final injection = _injectionTemplate(injectionType, fileNameWithUppeCase);

  final parentModule = await Slidy.instance.getParentModule(directory);

  var result = await Slidy.instance.template.addLine(
      params: LineParams(parentModule, replaceLine: (line) {
    if (line.contains('final List<Bind> binds = [')) {
      return line.replaceFirst('final List<Bind> binds = [', 'final List<Bind> binds = [$injection,');
    } else if (line.contains('List<Bind> get binds => [')) {
      return line.replaceFirst('List<Bind> get binds => [\n', 'List<Bind> get binds => [$injection,');
    }
    return line;
  }));

  execute(result);

  if (result.isRight) {
    result = await Slidy.instance.template.addLine(params: LineParams(parentModule, inserts: [import]));
    execute(result);
    if (result.isRight) {
      await formatFile(parentModule);
    }
  }
}

Future injectParentModuleRouting(String path, String fileNameWithUppeCase, String import, Directory directory) async {
  final injection = 'ChildRoute(\'$path\', child: (_, args) => $fileNameWithUppeCase)';

  final parentModule = await Slidy.instance.getParentModule(directory);

  var result = await Slidy.instance.template.addLine(
      params: LineParams(parentModule, replaceLine: (line) {
    if (line.contains('final List<ModularRoute> routes = [')) {
      return line.replaceFirst('final List<ModularRoute> routes = [', 'final List<ModularRoute> routes = [$injection,');
    } else if (line.contains('List<ModularRoute> get routes => [')) {
      return line.replaceFirst('List<ModularRoute> get routes => [\n', 'List<ModularRoute> get routes => [$injection,');
    }
    return line;
  }));

  execute(result);

  if (result.isRight) {
    result = await Slidy.instance.template.addLine(params: LineParams(parentModule, inserts: [import]));
    execute(result);
    if (result.isRight) {
      await formatFile(parentModule);
    }
  }
}

Future<void> addedInjectionInPage({required TemplateFile templateFile, required String pathCommand, required bool noTest, required String type}) async {
  var command = CommandRunner('slidy', 'CLI')..addCommand(GenerateCommand());
  await command.run(['generate', 'page', pathCommand, if (noTest) '--notest']);
  final insertLine = '  final ${templateFile.fileNameWithUppeCase}$type ${type.toLowerCase()} = Modular.get();';
  final pageFile = File(templateFile.file.parent.path + '/${templateFile.fileName}_page.dart');
  var result = await Slidy.instance.template.addLine(params: LineParams(pageFile, position: 9, inserts: [insertLine, '']));
  execute(result);
  result = await Slidy.instance.template.addLine(params: LineParams(pageFile, inserts: ['import \'package:flutter_modular/flutter_modular.dart\';', templateFile.import]));
  execute(result);
}

Future<void> formatFile(File file) async {
  await Process.run('flutter', ['format', file.absolute.path], runInShell: true);
}

String _injectionTemplate(String injectionType, String classInstance) {
  if (injectionType == 'lazy-singleton') {
    return 'Bind.lazySingleton((i) => $classInstance)';
  } else if (injectionType == 'singleton') {
    return 'Bind.singleton((i) => $classInstance)';
  } else {
    return 'Bind.factory((i) => $classInstance)';
  }
}
