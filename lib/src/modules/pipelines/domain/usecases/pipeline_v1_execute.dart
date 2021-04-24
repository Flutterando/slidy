import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/modules/pipelines/domain/entities/pipeline.dart';
import 'package:slidy/src/modules/pipelines/domain/errors/errors.dart';

abstract class PipelineV1Usecase {
  Future<Either<PipelineError, SlidyProccess>> call(Pipeline pipeline, String command, List<String> args);
}

class PipelineV1UsecaseImpl implements PipelineV1Usecase {
  @override
  Future<Either<PipelineError, SlidyProccess>> call(Pipeline pipeline, String command, List<String> args) async {
    return Right(SlidyProccess(result: 'result'));
  }
}
