import 'dart:io';

import 'package:pubspec/pubspec.dart';
import 'package:slidy/src/services/pub_service.dart';
import 'package:slidy/src/utils/utils.dart';
import 'package:slidy/src/utils/output_utils.dart' as output;

void update(List<String> args) async {
  bool isDev = checkParam(args, "--dev");

  List<String> packs = List.from(args);
  packs.removeAt(0);
  packs.removeWhere((t) => t == "--dev");
  PubSpec spec = await getPubSpec();
  var dependencies = isDev ? spec.devDependencies : spec.dependencies;
  File yaml = File("pubspec.yaml");
  var node = yaml.readAsLinesSync();
  bool isAlter = false;

  for (String pack in packs) {
    if (pack.isEmpty) continue;
    if (!dependencies.containsKey(pack)) {
      output.error("Package is not installed");
      continue;
    }

    isAlter = true;

    String version = await PubService().getPackage(pack, '');
    int index = node.indexWhere((t) => t.contains("  $pack:"));
    node[index] = "  $pack: ^$version";

    output.success("Updated $pack in pubspec");
  }

  if (isAlter) {
    yaml.writeAsStringSync(node.join("\n"));
  }

  // spec = isDev
  //     ? spec.copy(devDependencies: dependencies)
  //     : spec.copy(dependencies: dependencies);
  // await spec.save(Directory(""));
}
