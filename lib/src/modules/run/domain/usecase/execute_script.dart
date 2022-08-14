import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:slidy/src/core/errors/errors.dart';
import 'package:slidy/src/core/prints/prints.dart' as output;

import '../entities/script.dart';

abstract class ExecuteScript {
  TaskEither<SlidyError, Unit> call(Script script);
}

class ExecuteScriptImpl implements ExecuteScript {
  ExecuteScriptImpl();

  @override
  TaskEither<SlidyError, Unit> call(Script script) {
    return TaskEither(
      () async {
        print('Script:  ${output.green(script.name)}');
        if (script.description.isNotEmpty) {
          print('Description:  ${output.green(script.description)}');
        }
        print('\n---------------- STEPS --------------\n');

        for (var step in script.steps) {
          if (step.name != null) {
            print('Step:  ${output.green(step.name!)}');
          }
          if (step.description.isNotEmpty) {
            print('Description:  ${output.green(step.description)}');
          }
          if (step.name != null || step.description.isNotEmpty) {
            print('\n');
          }
          final result = await processStep(step);
          if (!result) {
            return Left(SlidyError('Step \'${step.name}\' failure.'));
          }
          print('\n----------- END STEP ----------\n');
        }
        return Right(unit);
      },
    );
  }

  Future<bool> processStep(Step step) async {
    late List<String> commands;
    final run = step.run.trim();
    if (step.type == TypeEnum.command) {
      commands = splitCommand(run);
    } else {
      commands = [...step.type.commands, run];
    }

    var process = await Process.start(
      commands.first,
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
