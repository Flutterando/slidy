import 'dart:io';

import 'package:meta/meta.dart';
import 'package:slidy/src/services/pub_service.dart';
import 'package:slidy/src/utils/output_utils.dart' as output;
import 'package:slidy/src/utils/utils.dart';

Future<void> update({
  @required List<String> packs,
  @required bool isDev,
}) async {
  final spec = await getPubSpec();
  final dependencies = isDev ? spec.devDependencies : spec.dependencies;
  final yaml = File('pubspec.yaml');
  final node = yaml.readAsLinesSync();
  var isAlter = false;

  final indexDependency = isDev
      ? node.indexWhere((t) => t.contains('dev_dependencies:')) + 1
      : node.indexWhere((t) => t.contains('dependencies:')) + 1;

  for (final pack in packs) {
    if (pack.isEmpty) continue;
    if (!dependencies.containsKey(pack)) {
      output.error('Package is not installed');
      continue;
    }

    isAlter = true;

    final version = await PubService().getPackage(pack, '');
    var index = node.indexWhere((t) => t.contains('  $pack:'));
    if (index < indexDependency) {
      index = node.lastIndexWhere((t) => t.contains('  $pack:'));
    }
    node[index] = '  $pack: ^$version';

    output.success('Updated $pack in pubspec');
  }

  if (isAlter) {
    yaml.writeAsStringSync('${node.join('\n')}\n');
  }

  // spec = isDev
  //     ? spec.copy(devDependencies: dependencies)
  //     : spec.copy(dependencies: dependencies);
  // await spec.save(Directory(''));
}
