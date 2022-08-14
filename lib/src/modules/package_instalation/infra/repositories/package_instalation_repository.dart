import 'package:fpdart/fpdart.dart';
import 'package:slidy/src/core/entities/slidy_process.dart';
import 'package:slidy/src/core/errors/errors.dart';
import 'package:slidy/src/core/interfaces/yaml_service.dart';
import 'package:slidy/src/modules/package_instalation/domain/errors/errors.dart';
import 'package:slidy/src/modules/package_instalation/domain/models/package_name.dart';
import 'package:slidy/src/modules/package_instalation/domain/repositories/package_instalation_repository.dart';
import 'package:slidy/src/modules/package_instalation/infra/datasources/get_package_version.dart';

class PackageInstalationRepositoryImpl implements PackageInstalationRepository {
  final YamlService pubspec;
  final GetPackageVersion client;

  PackageInstalationRepositoryImpl({required this.pubspec, required this.client});

  @override
  Future<Either<SlidyError, SlidyProccess>> install(PackageName package) async {
    try {
      if (package.name.contains('@')) {
        final elements = package.name.split('@');
        package = package.copyWith(name: elements[0].trim(), version: elements[1].trim());
      } else {
        package = package.copyWith(version: '^${await client.fetch(package.name)}');
      }
      pubspec.update([package.isDev ? 'dev_dependencies' : 'dependencies', package.name], package.version);
      final result = await pubspec.save();
      return Right(SlidyProccess(result: result ? 'Added ${package.name}: ${package.version}' : ''));
    } on SlidyError catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<SlidyError, SlidyProccess>> uninstall(PackageName package) async {
    try {
      final isRemoved = pubspec.remove([package.isDev ? 'dev_dependencies' : 'dependencies', package.name]);
      if (!isRemoved) {
        throw PackageInstalationError('Dependency not exist');
      }
      final result = await pubspec.save();
      return Right(SlidyProccess(result: result ? 'Removed ${package.name}' : ''));
    } on SlidyError catch (e) {
      return Left(e);
    }
  }
}
