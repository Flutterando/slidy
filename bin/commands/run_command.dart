import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/core/interfaces/yaml_service.dart';
import 'package:yaml/yaml.dart';

import '../prints/prints.dart' as output;
import 'command_base.dart';

class RunCommand extends CommandBase {
  @override
  final name = 'run';
  @override
  final description = 'run scripts in pubspec.yaml';
  @override
  final invocationSuffix = '<project name>';
  @override
  void run() {
    if (argResults!.rest.isEmpty) {
      throw UsageException('script name not passed for a run command', usage);
    } else {
      runCommand(argResults!.rest);
    }
  }

  Future<void> runCommand(List<String> commands) async {
    final pubspec = Slidy.instance.get<YamlService>();
    YamlMap? scripts;
    try {
      scripts = pubspec.getValue(['scripts'])!.value;
    } catch (e) {
      output.error('Please, add param \'scripts\' in your pubspec.yaml');
      return;
    }

    for (var command in commands) {
      var regex = RegExp("[^\\s\'']+|\'[^\']*\'|'[^']*'");
      var regexVar = RegExp(r'\$([a-zA-Z0-9]+)');

      late String commandExec;
      try {
        commandExec = scripts?.value[command] as String;
      } catch (e) {
        commandExec = '';
        output.error('command "$command" not found');
        return;
      }

      final vars = <String, String>{};
      try {
        var varsLine = pubspec.getValue(['vars']);
        final maps = varsLine?.value as YamlMap;
        for (var key in maps.keys) {
          vars[key] = maps[key];
        }
        // ignore: empty_catches
      } catch (e) {}

      for (var match in regexVar.allMatches(commandExec)) {
        if (match.groupCount != 0) {
          var variable = match.group(0)?.replaceFirst('\$', '');
          if (variable != null && vars.containsKey(variable)) {
            commandExec = commandExec.replaceAll(match.group(0) ?? '', vars[variable] ?? '');
          }
        }
      }

      for (final item in commandExec.split('&')) {
        final matchList = regex.allMatches(item).map((v) => v.group(0)!).toList().map<String>((e) => (e.startsWith('\$') ? vars[e.replaceFirst('\$', '')] ?? e : e)).toList();
        await callProcess(matchList);
      }
    }
  }

  Future callProcess(List<String> commands) async {
    try {
      var process = await Process.start(commands.first, commands.length <= 1 ? [] : commands.getRange(1, commands.length).toList(), runInShell: true);
      await for (var line in process.stdout.transform(utf8.decoder)) {
        print(line);
      }
      output.success(commands.join(' '));
    } catch (error) {
      output.error(commands.join(' '));
    }
  }
}
