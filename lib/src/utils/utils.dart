import 'dart:io';

import 'package:slidy/src/modules/uninstall.dart';
import 'package:slidy/src/utils/pubspec.dart';
import 'package:yaml/yaml.dart';

String mainDirectory = '';

String formatName(String name) {
  return name
      .replaceAll('_', ' ')
      .split(' ')
      .map((t) => t[0].toUpperCase() + t.substring(1))
      .join()
      .replaceFirst('.dart', '');
}

Future<String> getNamePackage([Directory dir]) async {
  final yaml = await getPubSpec(directory: Directory(mainDirectory));
  return yaml.name;
}

Future<bool> isModular() async {
  final dir = Directory(mainDirectory);
  final yaml = await getPubSpec(directory: dir);
  return yaml.dependencies.containsKey('flutter_modular');
}

Future<bool> isMobx() async {
  return checkDependency('flutter_mobx');
}

Future<bool> checkDependency(String dep) async {
  try {
    final yaml = await getPubSpec();
    return yaml.dependencies.containsKey(dep);
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> checkDevDependency(String dep) async {
  try {
    final yaml = await getPubSpec();
    return yaml.devDependencies.containsKey(dep);
  } catch (e) {
    print(e);
    return false;
  }
}

Future<String> getVersion() async {
  //PubSpec yaml = await getPubSpec(path: File.fromUri(Platform.script).parent.parent.path);
  final file =
      File('${File.fromUri(Platform.script).parent.parent.path}/pubspec.lock');
  final doc = loadYaml(await file.readAsString());
  return doc['packages']['slidy']['version'].toString();
}

Future<PubSpec> getPubSpec({Directory directory}) async {
  final pubSpec = await PubSpec.load(directory ?? Directory('$mainDirectory'));
  return pubSpec;
}

Future removeAllPackages([String directory]) async {
  final pubSpec = await getPubSpec(
      directory: directory == null ? null : Directory(directory));
  final dep = pubSpec.dependencies.keys
      .map((f) => f.toString())
      .where((t) => t != 'flutter')
      .toList();

  final devDep = pubSpec.devDependencies.keys
      .map((f) => f.toString())
      .where((t) => t != 'flutter_test')
      .toList();

  uninstall(
    packs: dep,
    isDev: false,
    showErrors: false,
    directory: directory,
  );
  uninstall(
    packs: devDep,
    isDev: true,
    showErrors: false,
    directory: directory,
  );

  // pubSpec.dependencies.removeWhere((key, value) => key != 'flutter');
  // pubSpec.devDependencies.removeWhere((key, value) => key != 'flutter_test');
  // var newPubSpec = pubSpec.copy(
  //     dependencies: pubSpec.dependencies,
  //     devDependencies: pubSpec.devDependencies);
  // await newPubSpec.save(Directory(''));
}

bool checkParam(List<String> args, String param) {
  return args.contains(param);
}

String libPath(String path) {
  if (Directory('${mainDirectory}lib/app').existsSync()) {
    return '${mainDirectory}lib/app/$path';
  } else if (Directory('lib/src').existsSync()) {
    return '${mainDirectory}lib/src/$path';
  } else {
    return '${mainDirectory}lib/app/$path';
  }
}

bool validateUrl(String url) {
  const urlPattern =
      r'(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?';
  final match = RegExp(urlPattern, caseSensitive: false).firstMatch(url);
  return match != null;
}

enum StateManagementEnum { rxDart, mobx, flutter_bloc }
