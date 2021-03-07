import 'dart:io';

import 'package:slidy/slidy.dart';
import 'package:slidy/src/modules/template_creator/domain/models/line_params.dart';

import '../prints/prints.dart';

Future injectParentModule(String injectionType, String fileNameWithUppeCase, String import, Directory directory) async {
  final injection = _injectionTemplate(injectionType, fileNameWithUppeCase);

  final parentModule = await Slidy.instance.getParentModule(directory);

  var result = await Slidy.instance.template.addLine(
      params: LineParams(parentModule, replaceLine: (line) {
    if (line.contains('final List<Bind> binds = [')) {
      return line.replaceFirst('final List<Bind> binds = [', 'final List<Bind> binds = [$injection,');
    } else if (line.contains('List<Bind> get binds => [')) {
      return line.replaceFirst('List<Bind> get binds => [', 'List<Bind> get binds => [$injection,');
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
