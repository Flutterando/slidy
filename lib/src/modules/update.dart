import 'dart:io';

import 'package:slidy/src/services/pub_service.dart';
import 'package:slidy/src/utils/pubspec.dart';
import 'package:slidy/src/utils/utils.dart';
import 'package:slidy/src/utils/output_utils.dart' as output;

void update(List<String> packs, isDev) async {
  PubSpec spec = await getPubSpec();
  var dependencies = isDev ? spec.devDependencies : spec.dependencies;
  File yaml = File("pubspec.yaml");
  var node = yaml.readAsLinesSync();
  bool isAlter = false;

  int indexDependency = isDev
      ? node.indexWhere((t) => t.contains("dev_dependencies:")) + 1
      : node.indexWhere((t) => t.contains("dependencies:")) + 1;

  for (String pack in packs) {
    if (pack.isEmpty) continue;
    if (!dependencies.containsKey(pack)) {
      output.error("Package is not installed");
      continue;
    }

    isAlter = true;

    String version = await PubService().getPackage(pack, '');
    int index = node.indexWhere((t) => t.contains("  $pack:"));
    if (index < indexDependency) {
      index = node.lastIndexWhere((t) => t.contains("  $pack:"));
    }
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
