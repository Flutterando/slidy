import 'dart:io';

import 'package:yaml/yaml.dart';

import 'package:slidy/src/core/interfaces/yaml_service.dart';
import 'package:slidy/src/modules/yaml_edit/yaml_edit.dart';

class YamlServiceImpl implements YamlService {
  final File yaml;
  late final YamlEditor yamlEditor;
  late final File Function(File yaml, String path) getYamlFile;

  YamlServiceImpl({
    required this.yaml,
    YamlEditor? customyamlEditor,
    File Function(File yaml, String path)? getYamlFileParam,
  }) {
    if (customyamlEditor == null) {
      yamlEditor = YamlEditor(yaml.readAsStringSync());
    } else {
      yamlEditor = customyamlEditor;
    }

    getYamlFile = getYamlFileParam ??
        (File yaml, String path) {
          if (path.startsWith('/')) {
            return File(path);
          } else {
            return File(yaml.parent.path + '/$path');
          }
        };
  }

  @override
  bool remove(List<String> path) {
    try {
      yamlEditor.remove(path);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void update(List<String> path, String value) {
    yamlEditor.update(path, value);
  }

  @override
  YamlNode? getValue(List<String> path) {
    return yamlEditor.parseAt(path, orElse: () => null);
  }

  @override
  Future<bool> save() async {
    try {
      await yaml.writeAsString(yamlEditor.toString());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<YamlService> readAllIncludes() async {
    final node = getValue(['include']);
    if (node is YamlScalar) {
      final file = getYamlFile(yaml, node.value);
      final newYaml = yamlEditor.toString() + '\n' + (await file.readAsString());
      return YamlServiceImpl(yaml: File(''), customyamlEditor: YamlEditor(newYaml));
    } else if (node is YamlList) {
      var newYaml = yamlEditor.toString();
      for (var path in node.value) {
        final file = getYamlFile(yaml, path);
        newYaml += '\n' + (await file.readAsString());
      }
      return YamlServiceImpl(yaml: File(''), customyamlEditor: YamlEditor(newYaml));
    }

    return this;
  }
}
