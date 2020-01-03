import 'dart:io';

import 'package:slidy/src/utils/pubspec.dart';
import 'package:slidy/src/utils/utils.dart';
import 'package:slidy/src/utils/output_utils.dart' as output;

void uninstall(List<String> packs, bool isDev, [bool showErrors = true, String directory]) async {
  PubSpec spec = await getPubSpec(directory: directory == null ? null : Directory(directory));
  var dependencies = isDev ? spec.devDependencies : spec.dependencies;
  File yaml = File(directory == null ? "pubspec.yaml" : '$directory/pubspec.yaml');
  var node = yaml.readAsLinesSync();
  bool isAlter = false;

  for (String pack in packs) {
    if (!dependencies.containsKey(pack)) {
      if (showErrors) {
        output.error("Package is not installed");
      }
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
