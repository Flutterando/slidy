import 'package:fpdart/fpdart.dart';
import 'package:slidy/src/modules/package_manager/domain/repositories/package_repository.dart';

import '../../../../core/entities/slidy_process.dart';
import '../../../../core/errors/errors.dart';
import '../params/package_name.dart';

abstract class Install {
  TaskEither<SlidyError, SlidyProccess> call(PackageName package);
}

class InstallImpl implements Install {
  final PackageRepository repository;

  InstallImpl(this.repository);

  @override
  TaskEither<SlidyError, SlidyProccess> call(PackageName package) {
    return _resolveVersion(package) //
        .flatMap(repository.putPackage)
        .map(_finishProcess);
  }

  TaskEither<SlidyError, PackageName> _resolveVersion(PackageName package) {
    return TaskEither(() async {
      if (package.name.contains('@')) {
        final elements = package.name.split('@');
        return Right(package.copyWith(name: elements[0].trim(), version: elements[1].trim()));
      } else {
        final result = await repository.getVersions(package.name).run();
        return result.map((allVersion) => package.copyWith(version: '^${allVersion.last}'));
      }
    });
  }

  SlidyProccess _finishProcess(PackageName package) {
    return SlidyProccess(result: 'Added ${package.name}: ${package.version}');
  }
}
