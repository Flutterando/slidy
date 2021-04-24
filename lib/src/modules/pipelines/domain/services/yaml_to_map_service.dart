import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:slidy/src/modules/pipelines/domain/errors/errors.dart';

abstract class YamlToMapService {
  FutureOr<Either<PipelineError, Map>> convert(String yamlPath);
}
