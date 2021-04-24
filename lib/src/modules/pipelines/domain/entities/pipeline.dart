import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/modules/pipelines/domain/errors/errors.dart';

abstract class Pipeline {
  late final FutureOr<Either<PipelineError, SlidyProccess>> Function(Pipeline pipeline) _usecase;

  Pipeline(FutureOr<Either<PipelineError, SlidyProccess>> Function(Pipeline pipeline) usecase) {
    _usecase = usecase;
  }

  FutureOr<Either<PipelineError, SlidyProccess>> call() async {
    return _usecase(this);
  }
}
