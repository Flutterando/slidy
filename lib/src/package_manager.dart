import 'dart:io';

import 'package:pubspec/pubspec.dart';
import 'package:slidy/src/utils/utils.dart';
import 'package:slidy/src/services/pub_service.dart';
import 'package:slidy/src/utils/output_utils.dart' as output;

class PackageManager {
  install(List<String> args, bool isDev) async {
    List<String> packs = List.from(args);
    packs.removeAt(0);
    packs.removeWhere((t) => t == "--dev");
    PubSpec spec = await getPubSpec();
    File yaml = File("pubspec.yaml");
    var node = yaml.readAsLinesSync();
    int indexDependency =
        node.indexWhere((t) => t.contains("dependencies:")) + 1;
    int indexDependencyDev =
        node.indexWhere((t) => t.contains("dev_dependencies:")) + 1;
    bool isAlter = false;
    var dependencies = isDev ? spec.devDependencies : spec.dependencies;

    for (String pack in packs) {
      String packName = "";
      String version = "";

      if (pack.contains(":")) {
        packName = pack.split(":")[0];
        version = pack.split(":")[1];
      } else {
        packName = pack;
      }

      if (dependencies.containsKey(packName)) {
        await update(["update", packName], isDev);
        continue;
      }

      try {
        version = await PubService().getPackage(packName, version);
        node.insert(isDev ? indexDependencyDev : indexDependency,
            "  $packName: ^$version");
        output.success("$packName:$version Added in pubspec");
        isAlter = true;
      } catch (e) {
        output.error("Version or package not found");
      }

      // spec = isDev
      //       ? spec.copy(devDependencies: dependencies)
      //       : spec.copy(dependencies: dependencies);
      //   await spec.save(Directory(""));
      if (isAlter) {
        yaml.writeAsStringSync(node.join("\n"));
      }
    }
  }

  update(List<String> args, bool isDev) async {
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
        output.warn("Package is not installed");
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

  uninstall(List<String> args, bool isDev) async {
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
        output.warn("Package is not installed");
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
}
