import 'dart:io';

import 'package:pubspec/pubspec.dart';
import 'package:slidy/src/utils/utils.dart';
import 'package:slidy/src/utils/output_utils.dart' as output;

void uninstall(List<String> args) async {
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
    if (!dependencies.containsKey(pack)) {
      output.error("Package is not installed");
      continue;
    }
    isAlter = true;
    node.removeWhere((t) => t.contains("  $pack:"));

    output.success("Removed $pack from pubspec");
  }

  if (isAlter) {
    yaml.writeAsStringSync(node.join("\n"));
  }

  // spec = isDev
  //     ? spec.copy(devDependencies: dependencies)
  //     : spec.copy(dependencies: dependencies);

  // await spec.save(Directory(""));
}
