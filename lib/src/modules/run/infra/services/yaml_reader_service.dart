import 'package:yaml/yaml.dart';

import '../../domain/services/yaml_reader_service.dart';

class YamlReaderServiceImpl implements YamlReaderService {
  @override
  Map<String, dynamic> readYaml(String yaml) {
    var doc = loadYaml(yaml) as YamlMap;
    return yamlMapToMap(doc);
  }

  Map<String, dynamic> yamlMapToMap(YamlMap yamlMap) {
    return yamlMap.map((key, value) {
      if (value is YamlMap) {
        final normalMap = yamlMapToMap(value);
        return MapEntry(key, normalMap);
      }
      return MapEntry(key, value);
    });
  }
}
