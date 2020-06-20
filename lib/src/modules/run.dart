import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:slidy/src/utils/output_utils.dart' as output;

void runCommand(List<String> commands) async {
  try {
    final yaml = File('pubspec.yaml');
    var node = await yaml.readAsString();
    var doc = loadYaml(node);
    for (var command in commands) {
      var regex = RegExp("[^\\s\'']+|\'[^\']*\'|'[^']*'");
      var regexVar = RegExp(r'\$([a-zA-Z0-9]+)');

      if (!(doc as Map).containsKey('scripts')) {
        throw 'Please, add param \'scripts\' in your pubspec.yaml';
      }

      if (!(doc['scripts'] as Map).containsKey(command)) {
        throw 'command "$command" not found';
      }

      String commandExec = doc['scripts'][command];

      for (var match in regexVar.allMatches(commandExec)) {
        if (match.groupCount != 0) {
          var variable = match.group(0).replaceFirst('\$', '');
          if ((doc['vars'] as Map).containsKey(variable)) {
            commandExec = commandExec.replaceAll(match.group(0), doc['vars'][variable]);
          }
        }
      }

      print(commandExec);

      for (final item in commandExec.split('&')) {
        final matchList = regex
            .allMatches(item)
            .map((v) => v.group(0))
            .toList()
            .map<String>((e) => (e.startsWith('\$')
                ? doc['vars'][e.replaceFirst('\$', '')]
                : e))
            .toList();
        await callProcess(matchList);
      }
    }
  } catch (e) {
    output.error(e);
  }
}

Future callProcess(List<String> commands) async {
  try {
    var process = await Process.start(
        commands.first,
        commands.length <= 1
            ? []
            : commands.getRange(1, commands.length).toList(),
        runInShell: true);
    await for (var line in process.stdout.transform(utf8.decoder)) {
      print(line);
    }
  } catch (error) {
    print(error);
    throw 'Command Error';
  }
}
