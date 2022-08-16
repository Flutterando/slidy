import 'dart:io';

import '../entities/script.dart';

abstract class ExecuteStep {
  Future<bool> call(Step step);
}

class ExecuteStepImpl implements ExecuteStep {
  @override
  Future<bool> call(Step step) async {
    late List<String> commands;
    final run = step.run.trim();
    if (step.shell == ShellEnum.command) {
      commands = splitCommand(run);
    } else {
      commands = [...step.shell.commands, run];
    }

    var process = await Process.start(
      commands.first,
      environment: step.environment,
      workingDirectory: step.workingDirectory,
      commands.length <= 1 ? [] : commands.getRange(1, commands.length).toList(),
      runInShell: true,
    );

    await stdout.addStream(process.stdout);
    await stderr.addStream(process.stderr);

    final isSuccess = await process.exitCode == 0;

    process.kill();
    return isSuccess;
  }

  List<String> splitCommand(String command) {
    var regex = RegExp("[^\\s\"']+|\"([^\"]*)\"|'([^']*)'");

    return regex.allMatches(command).map((regexMatcher) {
      if (regexMatcher.group(1) != null) {
        // Add double-quoted string without the quotes
        return regexMatcher.group(1)!;
      } else if (regexMatcher.group(2) != null) {
        // Add single-quoted string without the quotes
        return regexMatcher.group(2)!;
      }

      return regexMatcher.group(0)!;
    }).toList();
  }
}
