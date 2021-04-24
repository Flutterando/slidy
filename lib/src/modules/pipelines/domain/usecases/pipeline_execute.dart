import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/modules/pipelines/domain/entities/pipeline.dart';
import 'package:slidy/src/modules/pipelines/domain/entities/pipeline_v1.dart';
import 'package:slidy/src/modules/pipelines/domain/errors/errors.dart';
import 'package:slidy/src/modules/pipelines/domain/services/yaml_to_map_service.dart';
import 'package:slidy/src/modules/pipelines/domain/usecases/pipeline_v1_execute.dart';

abstract class PipelineExecute {
  FutureOr<Either<PipelineError, SlidyProccess>> call(PipelineParams params);
}

class PipelineExecuteImpl implements PipelineExecute {
  final PipelineV1Usecase v1;
  final YamlToMapService yamlToMapService;

  late final mapPipelineByVersion = <String, Pipeline Function(Map)>{'v1': (map) => PipelineV1.fromMap(map, v1)};

  PipelineExecuteImpl({required this.v1, required this.yamlToMapService});
  @override
  FutureOr<Either<PipelineError, SlidyProccess>> call(PipelineParams params) async {
    final yamlToMapResult = await yamlToMapService.convert(params.yamlPath);
    return yamlToMapResult.bind<Pipeline>(_bindServiceResult).asyncBind<SlidyProccess>((pipeline) {
      return pipeline(params.command, params.args);
    });
  }

  Either<PipelineError, Pipeline> _bindServiceResult(Map map) {
    if (!map.containsKey('version')) {
      return left(PipelineError('Version \"${map['version']}\" not supported'));
    } else if (!mapPipelineByVersion.containsKey(map['version'])) {
      return left(PipelineError('Version \"${map['version']}\" not supported'));
    }
    return right(mapPipelineByVersion[map['version']]!.call(map));
  }
}

extension EitherExtension<L, R> on Either<L, R> {
  Future<Either<L, R2>> asyncBind<R2>(Future<Either<L, R2>> Function(R) asyncF) async {
    return fold((l) async => left(l), asyncF);
  }
}

class PipelineParams {
  final String yamlPath;
  final String command;
  final List<String> args;

  PipelineParams({required this.yamlPath, required this.command, this.args = const []});
}
