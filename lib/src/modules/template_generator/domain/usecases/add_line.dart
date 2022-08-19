import 'package:fpdart/fpdart.dart';
import 'package:slidy/slidy.dart';

import '../models/line_params.dart';

abstract class AddLine {
  Future<Either<SlidyError, SlidyProccess>> call(LineParams params);
}

class AddLineImpl extends AddLine {
  @override
  Future<Either<SlidyError, SlidyProccess>> call(LineParams params) async {
    var lines = await params.file.readAsLines();
    lines = params.replaceLine == null ? lines : lines.map<String>(params.replaceLine!).toList();
    lines.insertAll(params.position, params.inserts);
    await params.file.writeAsString(lines.join('\n'));

    if (params.inserts.isEmpty) {
      return Right(SlidyProccess(result: '${params.file.uri.pathSegments.last} added line'));
    }
    return Right(SlidyProccess(result: '${params.file.uri.pathSegments.last} added line ${params.inserts.first}'));
  }
}
