import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:slidy/src/core/errors/errors.dart';
import 'package:slidy/src/modules/run/domain/entities/script.dart';

import '../entities/slidy_pipeline_v1.dart';
import '../services/yaml_reader_service.dart';

abstract class LoadSlidyPipeline {
  TaskEither<SlidyError, SlidyPipelineV1> call(File yamlFile);
}

class LoadSlidyPipelineImpl implements LoadSlidyPipeline {
  final YamlReaderService yamlReader;

  LoadSlidyPipelineImpl(this.yamlReader);

  @override
  TaskEither<SlidyError, SlidyPipelineV1> call(File yamlFile) {
    return TaskEither(() async {
      if (!await yamlFile.exists()) {
        return Left(SlidyError('YAML file (${yamlFile.path}) not found. Add \'slidy.yaml\' file'));
      }
      final yamlText = await yamlFile.readAsString();

      final yamlMap = yamlReader.readYaml(yamlText);

      if (yamlMap['slidy'] == null) {
        return Left(SlidyError('Field [slidy] is required. (ex: slidy: \"1\")'));
      }

      if (yamlMap['slidy'] is! String) {
        return Left(SlidyError('Field [slidy] must be String.'));
      }
      if (yamlMap['slidy'] != '1') {
        return Left(SlidyError('Slidy Version ${yamlMap['slidy']} not supported'));
      }

      final scripts = yamlMap['scripts'];

      if (scripts != null) {
        if (scripts is! Map<String, dynamic>) {
          return Left(SlidyError('Field [scripts] not be a object.'));
        }

        for (var key in scripts.keys) {
          final script = scripts[key]!;
          if (script is String) {
            continue;
          }
          if ((script['run'] == null && script['steps'] == null) || //
              (script['run'] != null && script['steps'] != null)) {
            return Left(SlidyError('Use [run] or [steps] propertie in Script.'));
          }

          if (script['type'] != null && TypeEnum.values.where((e) => e.name == script['type']).isEmpty) {
            return Left(SlidyError('Invalid [type] propertie. Avaliable values (${TypeEnum.values.map((e) => e.name).join('|')})'));
          }

          final steps = script['steps'];

          if (steps != null) {
            if (steps is! List) {
              return Left(SlidyError('Field [steps] not be a List.'));
            }
            for (var step in steps) {
              if (step['type'] != null && TypeEnum.values.where((e) => e.name == step['type']).isEmpty) {
                return Left(SlidyError('Invalid [type] propertie. Avaliable values (${TypeEnum.values.map((e) => e.name).join('|')})'));
              }
              if (step['run'] == null) {
                return Left(SlidyError('Field [run] is required in [step] propertie.'));
              }
            }
          }
        }
      }

      final pipe = SlidyPipelineV1(
        version: yamlMap['slidy'],
        systemVariables: Platform.environment,
        localVariables: yamlMap['variables'] != null ? fixMapVariables(yamlMap['variables']) : {},
        scripts: mapToScriptEntry(scripts),
      );

      return Right(pipe);
    });
  }

  Map<String, String> fixMapVariables(Map variables) {
    return variables.map((key, value) => MapEntry(key, value.toString()));
  }

  Map<String, Script> mapToScriptEntry(Map? json) {
    if (json == null) {
      return {};
    }
    return json.map((key, value) {
      if (value is String) {
        final script = Script(name: key, run: value, type: TypeEnum.command);
        return MapEntry(key, script);
      }

      final script = Script(
        name: value['name'] ?? key,
        run: value['run'],
        description: value['description'] ?? '',
        type: TypeEnum.values.firstWhere((e) => e.name == value['type'], orElse: () => TypeEnum.command),
        workingDirectory: value['working-directory'] ?? '.',
        steps: value['steps'] != null ? value['steps'].map<Step>(mapToStep).toList() : null,
      );
      return MapEntry(key, script);
    });
  }

  Step mapToStep(dynamic map) {
    return Step(
      name: map['name'],
      description: map['description'] ?? '',
      type: TypeEnum.values.firstWhere((e) => e.name == map['type'], orElse: () => TypeEnum.command),
      workingDirectory: map['working-directory'] ?? '.',
      run: map['run'],
    );
  }
}
