import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:slidy/src/utils/output_utils.dart' as output;

class PubSpec {
  final String name;
  final Map dependencies;
  final Map devDependencies;

  PubSpec({this.devDependencies, this.dependencies, this.name});

  static Future<PubSpec> load(Directory dir) async {
    try {
      final file = dir
          .listSync()
          .firstWhere((i) => i.path.contains('pubspec.yaml')) as File;

      YamlMap doc = loadYaml(await file.readAsString());

      return PubSpec(
          name: doc['name'],
          dependencies: Map.from(doc['dependencies']),
          devDependencies: Map.from(doc['dev_dependencies']));
    } catch (e) {
      output.error(e);
      output.error('No valid project found in this folder.');
      output.title('If you haven\'t created your project yet create with:');

      print('');
      print('slidy create myproject');
      print('');

      output.title('Or enter your project folder with to use slidy: ');

      print('');
      print('cd myproject && slidy start');
      print('');

      exit(1);
    }
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
