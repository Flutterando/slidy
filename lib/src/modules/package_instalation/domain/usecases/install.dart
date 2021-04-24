import 'package:dartz/dartz.dart';
import 'package:slidy/src/modules/package_instalation/domain/repositories/package_instalation_repository.dart';
import '../../../../core/entities/slidy_process.dart';
import '../../../../core/errors/errors.dart';
import '../../../../core/interfaces/usecase.dart';
import '../models/package_name.dart';

class Install implements UseCase<SlidyError, SlidyProccess, PackageName> {
  final PackageInstalationRepository repository;

  Install(this.repository);

  @override
  Future<Either<SlidyError, SlidyProccess>> call({required PackageName params}) async {
    return await repository.install(params);
  }
}
