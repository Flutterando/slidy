import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/modules/pipelines/domain/entities/pipeline.dart';
import 'package:slidy/src/modules/pipelines/domain/entities/pipeline_v1.dart';
import 'package:slidy/src/modules/pipelines/domain/errors/errors.dart';
import 'package:slidy/src/modules/pipelines/domain/services/yaml_to_map_service.dart';
import 'package:slidy/src/modules/pipelines/domain/usecases/pipeline_v1_execute.dart';

abstract class PipelineExecute {
  FutureOr<Either<PipelineError, SlidyProccess>> call(String yamlPath, String command, [List<String> args = const []]);
}

class PipelineExecuteImpl implements PipelineExecute {
  final PipelineV1Usecase v1;
  final YamlToMapService yamlToMapService;

  PipelineExecuteImpl({required this.v1, required this.yamlToMapService});
  @override
  FutureOr<Either<PipelineError, SlidyProccess>> call(String yamlPath, String command, [List<String> args = const []]) async {
    final yamlToMapResult = await yamlToMapService.convert(yamlPath);
    final result = yamlToMapResult.map<Pipeline>((map) {
      if (map['version'] == 'v1') {
        return PipelineV1.fromMap(map, v1);
      } else {
        return PipelineV1.fromMap(map, v1);
      }
    });
  }
}
