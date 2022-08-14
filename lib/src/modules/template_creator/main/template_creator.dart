import 'package:fpdart/fpdart.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/modules/template_creator/domain/models/line_params.dart';
import 'package:slidy/src/modules/template_creator/domain/usecases/add_line.dart';
import 'package:slidy/src/modules/template_creator/domain/usecases/create.dart';

class TemplateCreator {
  Future<Either<SlidyError, SlidyProccess>> createFile({required TemplateInfo info}) {
    return Create()(params: info);
  }

  Future<Either<SlidyError, SlidyProccess>> addLine({required LineParams params}) {
    return AddLine()(params: params);
  }
}
