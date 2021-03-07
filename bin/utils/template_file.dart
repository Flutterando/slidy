import 'dart:io';

import 'package:slidy/slidy.dart';
import 'package:slidy/src/core/interfaces/pubspec_service.dart';
import 'package:slidy/src/core/models/pubspec.dart';

class TemplateFile {
  late final File file;
  late final File fileTest;
  late final String fileName;
  late final fileNameWithUppeCase;
  final String packageName;
  late final import;

  TemplateFile._(String path, this.packageName) {
    file = File('lib/app/${path}_store.dart');
    fileTest = File('test/app/${path}_store_test.dart');
    fileName = Uri.parse(path).pathSegments.last;
    fileNameWithUppeCase = fileName[0].toUpperCase() + fileName.substring(1);
    import = 'import \'package:$packageName/app/${path}_store.dart\';';
  }

  static Future<TemplateFile> getInstance(String path) async {
    final pubspec = Slidy.instance.get<PubspecService>();
    return TemplateFile._(path, (await pubspec.getLine('name')).value);
  }

  Future<bool> checkDependencyIsExist(String dependency, [bool isDev = false]) async {
    try {
      final dependenciesLine = isDev ? 'dev_dependencies' : 'dependencies';
      final pubspec = Slidy.instance.get<PubspecService>();
      final map = (await pubspec.getLine(dependenciesLine)).value as LineMap;
      return map.containsKey(dependency);
    } catch (e) {
      return false;
    }
  }
}
