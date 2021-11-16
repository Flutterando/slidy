import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:recase/recase.dart';
import 'package:rxdart/rxdart.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/modules/pipelines/domain/entities/pipeline_v1.dart';
import '../../../../core/prints/prints.dart' as output;
import 'package:slidy/src/modules/pipelines/domain/entities/pipeline.dart';
import 'package:slidy/src/modules/pipelines/domain/errors/errors.dart';

abstract class PipelineV1Usecase {
  Future<Either<PipelineError, SlidyProccess>> call(
      Pipeline pipeline, String command, List<String> args);
}

class PipelineV1UsecaseImpl implements PipelineV1Usecase {
  @override
  Future<Either<PipelineError, SlidyProccess>> call(
      Pipeline pipeline, String command, List<String> args) async {
    final v1 = pipeline as PipelineV1;
    JobV1 job;
    try {
      job = v1.jobs.firstWhere((element) => element.key == command);
    } catch (e) {
      return Left(PipelineError('Command $command not found'));
    }
    var stepName = '';
    try {
      for (var step in job.steps) {
        stepName = step.id;
        print(output.green('STEP: $stepName'));
        final fileName = step.generate?.path == null
            ? ''
            : ReCase(Uri.parse(step.generate!.path).pathSegments.last)
                .camelCase;
        if (step.generate != null) {
          await _executeGenerate();
        }
        if (step.commands.isNotEmpty) {
          await _executeCommand(step.commands, args, fileName);
        }

        print('============\n');
      }
    } catch (e) {
      output.error('step $stepName');
    }

    return Right(SlidyProccess(result: v1.name));
  }

  Future<void> _executeGenerate() async {}

  Future<void> _executeCommand(
      List<String> commands, List<String> args, String fileName) async {
    final regex = RegExp("[^\\s\'']+|\'[^\']*\'|'[^']*'");

    for (var command in commands) {
      command = _processLine(command, args, fileName);
      print(output.green('RUN: $command'));
      await callProcess(
          regex.allMatches(command).map((v) => v.group(0)!).toList());
    }
  }

  String _processLine(String value, List<String> args, String fileName) {
    value =
        value.replaceAll('\$fileName|camelcase', ReCase(fileName).camelCase);
    value =
        value.replaceAll('\$fileName|pascalcase', ReCase(fileName).pascalCase);
    value = value.replaceAll('\$fileName', fileName);

    if (args.isEmpty) return value;
    for (var i = 0; i < args.length; i++) {
      final key = '\$arg${i + 1}';
      value = value.replaceAll(key, args[i]);
    }
    return value;
  }

  Future<int> callProcess(List<String> commands) async {
    try {
      var process = await Process.start(
          commands.first,
          commands.length <= 1
              ? []
              : commands.getRange(1, commands.length).toList(),
          runInShell: true);

      final error = process.stderr.transform(utf8.decoder).map(output.red);
      final success = process.stdout.transform(utf8.decoder);

      await for (var line in Rx.merge([success, error])) {
        print(line);
      }
      if (await process.exitCode == 0) {
        output.success(commands.join(' '));
        return 0;
      } else {
        output.error(commands.join(' '));
        return 1;
      }
    } catch (error) {
      output.error(commands.join(' '));
      return 1;
    }
  }
}
