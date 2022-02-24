import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_console/dart_console.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/core/interfaces/yaml_service.dart';
import 'package:yaml/yaml.dart';

import 'package:slidy/src/core/prints/prints.dart' as output;
import 'command_base.dart';

class RunCommand extends CommandBase {
  String? stateCLIOptions(String title, List<String> options) {
    stdin.echoMode = false;
    stdin.lineMode = false;
    var console = Console();
    var isRunning = true;
    var selected = 0;

    while (isRunning) {
      print('\x1B[2J\x1B[0;0H');
      output.title('Slidy CLI Interactive\n');
      output.warn(title);
      for (var i = 0; i < options.length; i++) {
        if (selected == i) {
          print(output.green(options[i]));
        } else {
          print(output.white(options[i]));
        }
      }

      print('\nUse ↑↓ (keyboard arrows)');
      print('Press \'q\' to quit.');

      var key = console.readKey();

      if (key.controlChar == ControlCharacter.arrowDown) {
        if (selected < options.length - 1) {
          selected++;
        }
      } else if (key.controlChar == ControlCharacter.arrowUp) {
        if (selected > 0) {
          selected--;
        }
      } else if (key.controlChar == ControlCharacter.enter) {
        isRunning = false;
        print('\x1B[2J\x1B[0;0H');
        return options[selected];
      } else if (key.char == 'q') {
        return null;
      }
    }
    print('\x1B[2J\x1B[0;0H');
    return null;
  }

  @override
  final name = 'run';
  @override
  final description = 'run scripts in pubspec.yaml';
  @override
  final invocationSuffix = null;
  @override
  FutureOr run() async {
    final pubspec = Slidy.instance.get<YamlService>();
    YamlMap scripts;
    try {
      scripts = pubspec.getValue(['scripts'])!.value;
    } catch (e) {
      output.error('Please, add param \'scripts\' in your pubspec.yaml');
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

    final commands = argResults?.rest.isNotEmpty == true
        ? List<String>.from(argResults!.rest)
        : <String>[];

    if (commands.isEmpty) {
      final command = stateCLIOptions(
          'Select a command', scripts.value.keys.toList().cast());
      if (command != null) {
        commands.add(command);
      }
    }

    if (commands.isEmpty) {
      throw UsageException('script name not passed for a run command', usage);
    }
    await runCommand(commands, scripts, vars);
  }

  Future<void> runCommand(
      List<String> commands, YamlMap scripts, Map vars) async {
    for (var command in commands) {
      var regex = RegExp("[^\\s\'']+|\'[^\']*\'|'[^']*'");
      var regexVar = RegExp(r'\$([a-zA-Z0-9]+)');

      late String commandExec;
      try {
        commandExec = scripts.value[command] as String;
      } catch (e) {
        commandExec = '';
        output.error('command "$command" not found');
        return;
      }

      for (var match in regexVar.allMatches(commandExec)) {
        if (match.groupCount != 0) {
          var variable = match.group(0)?.replaceFirst('\$', '');
          if (variable != null && vars.containsKey(variable)) {
            commandExec = commandExec.replaceAll(
                match.group(0) ?? '', vars[variable] ?? '');
          }
        }
      }

      for (final item in commandExec.split('&')) {
        final matchList = regex
            .allMatches(item)
            .map((v) => v.group(0)!)
            .toList()
            .map<String>((e) =>
                (e.startsWith('\$') ? vars[e.replaceFirst('\$', '')] ?? e : e))
            .toList();
        await callProcess(matchList);
      }
    }
  }

  Future callProcess(List<String> commands) async {
    try {
      var process = await Process.start(
        commands.first,
        commands.length <= 1
            ? []
            : commands.getRange(1, commands.length).toList(),
        runInShell: true,
      );

      process.stdout.listen((List<int> event) {
        stdout.add(output.green(utf8.decode(event)).codeUnits);
      });
      process.stderr.listen((List<int> event) {
        stderr.add(output.red(utf8.decode(event)).codeUnits);
      });

      if (await process.exitCode == 0) {
        output.success('${commands.join(' ')}\n');
      } else {
        output.error(commands.join(' '));
      }
    } catch (error) {
      output.error(commands.join(' '));
    }
  }
}
