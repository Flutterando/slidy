import 'dart:io';

import 'package:meta/meta.dart';
import 'package:slidy/src/modules/update.dart';
import 'package:slidy/src/services/pub_service.dart';
import 'package:slidy/src/utils/output_utils.dart' as output;
import 'package:slidy/src/utils/utils.dart';

Future<void> install({
  @required List<String> packs,
  @required bool isDev,
  bool haveTwoLines = false,
  String directory,
}) async {
  final spec = await getPubSpec(
      directory: directory == null ? null : Directory(directory));
  final yaml =
      File(directory == null ? 'pubspec.yaml' : '$directory/pubspec.yaml');
  final node = yaml.readAsLinesSync();
  final indexDependency =
      node.indexWhere((t) => t.contains('dependencies:')) + 1;
  final indexDependencyDev =
      node.indexWhere((t) => t.contains('dev_dependencies:')) + 1;
  var isAlter = false;
  final dependencies = isDev ? spec.devDependencies : spec.dependencies;

  for (final pack in packs) {
    var packName = '';
    var version = '';

    if (pack.contains(':')) {
      packName = pack.split(':')[0];
      version = pack.split(':').length > 1
          ? '${pack.split(':')[1]}:${pack.split(':')[2]}'
          : '${pack.split(':')[1]}';
    } else {
      packName = pack;
    }

    if (dependencies.containsKey(packName) && !haveTwoLines) {
      update(packs: [packName], isDev: isDev);
      continue;
    }

    try {
      if (!haveTwoLines) {
        version = await PubService().getPackage(packName, version);
        node.insert(isDev ? indexDependencyDev : indexDependency,
            '  $packName: ^$version');
      } else if (!dependencies.containsKey(packName)) {
        node.insert(isDev ? indexDependencyDev : indexDependency,
            '  $packName: \n    $version');
      }
      output.success('$packName:$version Added in pubspec');
      isAlter = true;
    } catch (e) {
      output.error('Version or package not found');
    }

    // spec = isDev
    //       ? spec.copy(devDependencies: dependencies)
    //       : spec.copy(dependencies: dependencies);
    //   await spec.save(Directory(''));
    if (isAlter) {
      yaml.writeAsStringSync('${node.join('\n')}\n');
    }
  }
}
