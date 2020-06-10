import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:slidy/src/utils/output_utils.dart' as output;

Future<void> runCommand(List<String> commands) async {
  try {
    final yaml = File('pubspec.yaml');
    final node = await yaml.readAsString();
    final doc = loadYaml(node);
    for (final command in commands) {
      final regex = RegExp("[^\\s\'']+|\'[^\']*\'|'[^']*'");

      if (!(doc as Map).containsKey('scripts')) {
        throw 'Please, add param \'scripts\' in your pubspec.yaml';
      }

      if (!(doc['scripts'] as Map).containsKey(command)) {
        throw 'command "$command" not found';
      }

      final String commandExec = doc['scripts'][command];

      for (final item in commandExec.split('&')) {
        final matchList =
            regex.allMatches(item).map((v) => v.group(0)).toList();
        callProcess(matchList);
      }
    }
  } catch (e) {
    output.error(e);
  }
}

Future<void> callProcess(List<String> commands) async {
  try {
    final process = await Process.start(
        commands.first,
        commands.length <= 1
            ? []
            : commands.getRange(1, commands.length).toList(),
        runInShell: true);
    await for (final line in process.stdout.transform(utf8.decoder)) {
      print(line);
    }
  } catch (error) {
    throw 'Command Error';
  }
}
