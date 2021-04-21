import 'dart:io';

import 'package:slidy/src/core/interfaces/yaml_service.dart';
import 'package:slidy/src/modules/yaml_edit/yaml_edit.dart';
import 'package:yaml/yaml.dart';

class YamlServiceImpl implements YamlService {
  final File yaml;
  late final YamlEditor yamlEditor;

  YamlServiceImpl({
    required this.yaml,
  }) {
    yamlEditor = YamlEditor(yaml.readAsStringSync());
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
}
