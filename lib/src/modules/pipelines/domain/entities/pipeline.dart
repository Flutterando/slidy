import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/modules/pipelines/domain/errors/errors.dart';

abstract class Pipeline {
  late final Future<Either<PipelineError, SlidyProccess>> Function(
      Pipeline pipeline, String command, List<String> args) _usecase;

  Pipeline(
      Future<Either<PipelineError, SlidyProccess>> Function(
              Pipeline pipeline, String command, List<String> args)
          usecase) {
    _usecase = usecase;
  }

  Future<Either<PipelineError, SlidyProccess>> call(
      String command, List<String> args) async {
    return _usecase(this, command, args);
  }
}
