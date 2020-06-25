import 'dart:io';

import 'package:slidy/src/services/pub_service.dart';
import 'package:slidy/src/utils/output_utils.dart' as output;
import 'package:slidy/src/utils/utils.dart';

void update(List<String> packs, isDev, {all = false}) async {
  final spec = await getPubSpec();
  var dependencies = isDev ? spec.devDependencies : spec.dependencies;
  final yaml = File('pubspec.yaml');
  final node = yaml.readAsLinesSync();
  var isAlter = false;

  final indexDependency = isDev
      ? node.indexWhere((t) => t.contains('dev_dependencies:')) + 1
      : node.indexWhere((t) => t.contains('dependencies:')) + 1;

  if (!all) {
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
  } else {
    for (var i = indexDependency; i < node.length; i++) {
      var pack = node[i].trim().split(':').map((e) => e.trim()).first;
      if (node[i].isEmpty) {
        break;
      } else if (pack == 'flutter' || pack == 'sdk' || pack == 'flutter_test') {
        continue;
      } else {
        final version = await PubService().getPackage(pack, '');
        var index = node.indexWhere((t) => t.contains('  $pack:'));
        if (index < indexDependency) {
          index = node.lastIndexWhere((t) => t.contains('  $pack:'));
        }
        node[index] = '  $pack: ^$version';
        isAlter = true;
        output.success('Updated $pack in pubspec');
      }
    }
  }

  if (isAlter) {
    yaml.writeAsStringSync(node.join('\n') + '\n');
  }
}
