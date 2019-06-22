import 'dart:convert';
import 'dart:io';

import 'package:pubspec/pubspec.dart';
import 'package:http/http.dart' as http;

String URL_API = "https://pub.dartlang.org/api/packages";

Future<String> consumeApi(String pack, String version) async {
  String url = URL_API + "/$pack";

  if (version.isNotEmpty) {
    url =  url + "/versions/" + version;
  }
  var response = await http.get(url);
  var json = jsonDecode(response.body);
  var map = version.isNotEmpty ? json['pubspec'] : json['latest']['pubspec'];
  return map['version']; 

}

savePub(Map spec){
   //File("pubspec.yaml").writeAsStringSync(yaml. );
}

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
  PubSpec yaml = await getPubSpec(path: File.fromUri(Platform.script).parent.parent.path);
  return yaml.version.toString();
}

Future<PubSpec> getPubSpec({String path = ""}) async {
  var pubSpec = await PubSpec.load(Directory(path));
  return pubSpec;
}

bool checkParam(List<String> args, String param){
  return args.contains(param);
}
