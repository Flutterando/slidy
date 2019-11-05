import 'dart:io';

import 'package:pubspec/pubspec.dart';
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

Future<String> getVersion() async {
  //PubSpec yaml = await getPubSpec(path: File.fromUri(Platform.script).parent.parent.path);
  File file =
      File(File.fromUri(Platform.script).parent.parent.path + "/pubspec.lock");
  var doc = loadYaml(file.readAsStringSync());
  return doc['packages']['slidy']['version'].toString();
}

Future<PubSpec> getPubSpec({String path = ""}) async {
  var pubSpec = await PubSpec.load(Directory(path));
  return pubSpec;
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
