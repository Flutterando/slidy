import 'package:yaml/yaml.dart';

abstract class YamlService {
  void update(List<String> path, String value);
  bool remove(List<String> path);
  YamlNode? getValue(List<String> path);
  Future<YamlService> readAllIncludes();
  Future<bool> save();
}
