import 'dart:io';

import 'package:pubspec/pubspec.dart';
import 'package:yaml/yaml.dart';

String formatName(String name) {
  name = name
      .replaceAll("_", " ")
      .split(" ")
      .map((t) => t[0].toUpperCase() + t.substring(1))
      .join();
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
  File file = File(File.fromUri(Platform.script).parent.parent.path + "/pubspec.lock") ;
  var doc = loadYaml(file.readAsStringSync());
  return doc['packages']['slidy']['version'].toString();
}

Future<PubSpec> getPubSpec({String path = ""}) async {
  var pubSpec = await PubSpec.load(Directory(path));
  return pubSpec;
}

bool checkParam(List<String> args, String param){
  return args.contains(param);
}

String libPath(String path) => "lib/src/$path";