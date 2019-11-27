import 'dart:io';

import 'package:yaml/yaml.dart';

class PubSpec {
  final String name;
  final Map dependencies;
  final Map devDependencies;

  PubSpec({this.devDependencies, this.dependencies, this.name});

  static Future<PubSpec> load(Directory dir) async {
    final file = dir
        .listSync()
        .firstWhere((i) => i.path.contains("pubspec.yaml")) as File;
    YamlMap doc = loadYaml(file.readAsStringSync());

    return PubSpec(
        name: doc['name'],
        dependencies: Map.from(doc['dependencies']),
        devDependencies: Map.from(doc['dev_dependencies']));
  }

  PubSpec copy({Map devDependencies, Map dependencies, String name}) {
    return PubSpec(
      devDependencies: devDependencies ?? this.devDependencies,
      dependencies: dependencies ?? this.dependencies,
      name: name ?? this.name,
    );
  }

  //save(Directory dir) async {}
}
