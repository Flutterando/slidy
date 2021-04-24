import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:slidy/src/modules/pipelines/domain/errors/errors.dart';

abstract class YamlToMapService {
  FutureOr<Either<PipelineError, Map>> convert(String yamlPath);
}
