import 'package:fpdart/fpdart.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/modules/template_generator/domain/usecases/add_line.dart';
import 'package:slidy/src/modules/template_generator/domain/usecases/create.dart';

import '../domain/models/line_params.dart';
import '../domain/models/template_info.dart';

class TemplateCreator {
  Future<Either<SlidyError, SlidyProccess>> createFile({required TemplateInfo info}) {
    return Create()(params: info);
  }

  Future<Either<SlidyError, SlidyProccess>> addLine({required LineParams params}) {
    return AddLine()(params: params);
  }
}
