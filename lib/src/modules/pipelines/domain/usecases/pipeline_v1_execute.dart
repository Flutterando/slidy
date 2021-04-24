import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/modules/pipelines/domain/entities/pipeline.dart';
import 'package:slidy/src/modules/pipelines/domain/errors/errors.dart';

abstract class PipelineV1Usecase {
  FutureOr<Either<PipelineError, SlidyProccess>> call(Pipeline pipeline);
}

class PipelineV1UsecaseImpl implements PipelineV1Usecase {
  @override
  FutureOr<Either<PipelineError, SlidyProccess>> call(Pipeline pipeline) {}
}
