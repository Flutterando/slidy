import 'dart:io';

import 'package:meta/meta.dart';
import 'package:slidy/src/utils/output_utils.dart' as output;
import 'package:slidy/src/utils/utils.dart';

Future<void> uninstall({
  @required List<String> packs,
  @required bool isDev,
  bool showErrors = true,
  String directory,
}) async {
  final spec = await getPubSpec(
      directory: directory == null ? null : Directory(directory));
  final dependencies = isDev ? spec.devDependencies : spec.dependencies;
  final yaml =
      File(directory == null ? 'pubspec.yaml' : '$directory/pubspec.yaml');
  final node = yaml.readAsLinesSync();
  var isAlter = false;

  for (final pack in packs) {
    if (!dependencies.containsKey(pack)) {
      if (showErrors) {
        output.error('Package is not installed');
      }
      continue;
    }
    isAlter = true;
    node.removeWhere((t) => t.contains('  $pack:'));

    output.success('Removed $pack from pubspec');
  }

  if (isAlter) {
    yaml.writeAsStringSync('${node.join('\n')}\n');
  }

  // spec = isDev
  //     ? spec.copy(devDependencies: dependencies)
  //     : spec.copy(dependencies: dependencies);

  // await spec.save(Directory(''));
}
