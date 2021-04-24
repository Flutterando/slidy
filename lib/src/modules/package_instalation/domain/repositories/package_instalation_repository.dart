import 'package:dartz/dartz.dart';
import 'package:slidy/src/modules/package_instalation/domain/models/package_name.dart';

import '../../../../core/entities/slidy_process.dart';
import '../../../../core/errors/errors.dart';

abstract class PackageInstalationRepository {
  Future<Either<SlidyError, SlidyProccess>> install(PackageName package);
  Future<Either<SlidyError, SlidyProccess>> uninstall(PackageName package);
}
