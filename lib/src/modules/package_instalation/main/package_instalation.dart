import 'package:dartz/dartz.dart';
import 'package:slidy/di/injection.dart';
import 'package:slidy/src/core/entities/slidy_process.dart';
import 'package:slidy/src/core/errors/errors.dart';
import 'package:slidy/src/modules/package_instalation/domain/models/package_name.dart';
import 'package:slidy/src/modules/package_instalation/domain/usecases/install.dart';
import 'package:slidy/src/modules/package_instalation/domain/usecases/uninstall.dart';

class PackageInstalation {
  Future<Either<SlidyError, SlidyProccess>> install(
      {required PackageName package}) {
    return sl.get<Install>()(params: package);
  }

  Future<Either<SlidyError, SlidyProccess>> uninstall(
      {required PackageName package}) {
    return sl.get<Uninstall>()(params: package);
  }
}
