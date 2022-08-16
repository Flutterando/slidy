import 'package:fpdart/fpdart.dart';
import 'package:slidy/src/modules/package_manager/domain/repositories/package_repository.dart';

import '../../../../core/entities/slidy_process.dart';
import '../../../../core/errors/errors.dart';
import '../params/package_name.dart';

abstract class Uninstall {
  TaskEither<SlidyError, SlidyProccess> call(PackageName package);
}

class UninstallImpl implements Uninstall {
  final PackageRepository repository;

  UninstallImpl(this.repository);

  @override
  TaskEither<SlidyError, SlidyProccess> call(PackageName package) {
    return repository //
        .removePackage(package)
        .map(finishProcess);
  }

  SlidyProccess finishProcess(PackageName package) {
    return SlidyProccess(result: '${package.name} removed!');
  }
}
