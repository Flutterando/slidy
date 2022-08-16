import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:slidy/src/core/errors/errors.dart';

import '../entities/slidy_pipeline_v1.dart';

abstract class ResolveVariables {
  Either<SlidyError, String> call(String text, SlidyPipelineV1 pipeline);
}

class ResolveVariablesImpl implements ResolveVariables {
  ResolveVariablesImpl();

  @override
  Either<SlidyError, String> call(String text, SlidyPipelineV1 pipeline) {
    text = resolveVariable(text, pipeline.localVariables, r'(?<var>\$\{Local\.var\.(?<key>\w+)\})');
    text = resolveVariable(text, pipeline.systemVariables, r'(?<var>\$\{System\.env\.(?<key>\w+)\})');
    text = resolveSystemVariables(text);
    return Right(text);
  }

  String resolveVariable(String text, Map<String, String> variables, String regexText) {
    final regex = RegExp(regexText);
    final matches = regex.allMatches(text);
    for (var match in matches) {
      final variable = match.namedGroup('var');
      final key = match.namedGroup('key');
      if (variable != null && variables.containsKey(key)) {
        text = text.replaceFirst(variable, variables[key]!);
      }
    }
    return text;
  }

  String resolveSystemVariables(String text) {
    return resolveVariable(
        text,
        {
          'operatingSystem': Platform.operatingSystem,
          'pathSeparator': Platform.pathSeparator,
          'operatingSystemVersion': Platform.operatingSystemVersion,
        },
        r'(?<var>\$\{System\.(?<key>\w+)\})');
  }
}
