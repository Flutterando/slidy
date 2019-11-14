import 'dart:io';

import 'package:slidy/src/modules/uninstall.dart';
import 'package:slidy/src/utils/pubspec.dart';
import 'package:yaml/yaml.dart';

String formatName(String name) {
  name = name
      .replaceAll("_", " ")
      .split(" ")
      .map((t) => t[0].toUpperCase() + t.substring(1))
      .join()
      .replaceFirst(".dart", "");
  return name;
}

String resolveName(String name) {
  return name.replaceAll(RegExp(r"[^a-zA-Z0-9]"), "_");
}

Future<String> getNamePackage() async {
  PubSpec yaml = await getPubSpec();
  return yaml.name;
}

Future<bool> checkDependency(String dep) async {
  try {
    PubSpec yaml = await getPubSpec();
    return yaml.dependencies.containsKey(dep);
  } catch (e) {
    print(e);
    return false;
  }
}

Future<String> getVersion() async {
  //PubSpec yaml = await getPubSpec(path: File.fromUri(Platform.script).parent.parent.path);
  File file =
      File(File.fromUri(Platform.script).parent.parent.path + "/pubspec.lock");
  var doc = loadYaml(file.readAsStringSync());
  return doc['packages']['slidy']['version'].toString();
}

Future<PubSpec> getPubSpec({String path = ""}) async {
  return PubSpec.load(Directory(path));
}

Future removeAllPackages() async {
  var pubSpec = await getPubSpec();
  var dep = pubSpec.dependencies.keys
      .map((f) => f.toString())
      .where((t) => t != "flutter")
      .toList();
  print(dep);

  var devDep = pubSpec.devDependencies.keys
      .map((f) => f.toString())
      .where((t) => t != "flutter_test")
      .toList();

  print(devDep);

  uninstall(dep, false);
  uninstall(devDep, true);

  // pubSpec.dependencies.removeWhere((key, value) => key != "flutter");
  // pubSpec.devDependencies.removeWhere((key, value) => key != "flutter_test");
  // var newPubSpec = pubSpec.copy(
  //     dependencies: pubSpec.dependencies,
  //     devDependencies: pubSpec.devDependencies);
  // await newPubSpec.save(Directory(""));
}

bool checkParam(List<String> args, String param) {
  return args.contains(param);
}

String libPath(String path) {
  if (Directory("lib/app").existsSync()) {
    return "lib/app/$path";
  } else if (Directory("lib/src").existsSync()) {
    return "lib/src/$path";
  } else {
    return "lib/app/$path";
  }
}

bool validateUrl(String url) {
  var urlPattern =
      r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
  var match = RegExp(urlPattern, caseSensitive: false).firstMatch(url);
  return match != null ? true : false;
}
