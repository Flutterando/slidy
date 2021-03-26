import 'package:slidy/src/core/interfaces/pubspec_service.dart';
import 'package:slidy/src/core/models/pubspec.dart';
import 'package:slidy/src/modules/package_instalation/domain/errors/errors.dart';
import 'package:slidy/src/modules/package_instalation/domain/models/package_name.dart';
import 'package:slidy/src/core/errors/errors.dart';
import 'package:slidy/src/core/entities/slidy_process.dart';
import 'package:either_dart/src/either.dart';
import 'package:slidy/src/modules/package_instalation/domain/repositories/package_instalation_repository.dart';
import 'package:slidy/src/modules/package_instalation/infra/datasources/get_package_version.dart';

class PackageInstalationRepositoryImpl implements PackageInstalationRepository {
  final PubspecService pubspec;
  final GetPackageVersion client;

  PackageInstalationRepositoryImpl({required this.pubspec, required this.client});

  @override
  Future<Either<SlidyError, SlidyProccess>> install(PackageName package) async {
    late final Line packageLine;
    try {
      if (package.name.contains('@')) {
        final elements = package.name.split('@');
        package = package.copyWith(name: elements[0].trim(), version: elements[1].trim());
        packageLine = Line.package(name: package.name, version: package.version, isDev: package.isDev);
      } else {
        package = package.copyWith(version: '^${await client.fetch(package.name)}');
        packageLine = Line.package(name: package.name, version: package.version, isDev: package.isDev);
      }
      final result = await pubspec.add(packageLine);
      return Right(SlidyProccess(result: result ? 'Added ${package.name}: ${package.version}' : ''));
    } on SlidyError catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<SlidyError, SlidyProccess>> uninstall(PackageName package) async {
    try {
      var line = await pubspec.getLine(package.isDev ? 'dev_dependencies' : 'dependencies');
      final isRemoved = (line.value as LineMap).remove(package.name) != null;
      if (!isRemoved) {
        throw PackageInstalationError('Dependency not exist');
      }
      final result = await pubspec.replace(line);
      return Right(SlidyProccess(result: result ? 'Removed ${package.name}' : ''));
    } on SlidyError catch (e) {
      return Left(e);
    }
  }
}
