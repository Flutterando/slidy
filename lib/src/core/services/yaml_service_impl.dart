import 'dart:io';

import 'package:slidy/src/core/interfaces/yaml_service.dart';
import 'package:slidy/src/core/models/pubspec.dart';
import 'package:slidy/src/core/services/pubspec_service_impl.dart';

class YamlServiceImpl extends PubspecServiceImpl implements YamlService {
  YamlServiceImpl(File yamlFile) : super(yaml: yamlFile);

  @override
  Future<List<Line>> getLines() {
    return loadYaml();
  }
}
