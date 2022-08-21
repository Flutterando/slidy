import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:slidy/src/core/errors/errors.dart';
import 'package:slidy/src/core/services/yaml_service.dart';
import 'package:slidy/src/modules/package_manager/domain/errors/errors.dart';
import 'package:slidy/src/modules/package_manager/domain/params/package_name.dart';
import 'package:slidy/src/modules/package_manager/domain/repositories/package_repository.dart';
import 'package:slidy/src/modules/package_manager/infra/datasources/pub_service.dart';

class PackageRepositoryImpl implements PackageRepository {
  final YamlService pubspec;
  final PubService datasource;

  PackageRepositoryImpl({required this.pubspec, required this.datasource});

  @override
  TaskEither<SlidyError, List<String>> getVersions(String packageName) {
    return TaskEither(() async {
      try {
        final versions = await datasource.fetchVersions(packageName);
        return Right(versions);
      } on SlidyError catch (e) {
        return Left(e);
      } on SocketException catch (e) {
        if (e.osError?.errorCode == 11001) {
          throw PackageManagerError('Internet error');
        }
        rethrow;
      }
    });
  }

  @override
  TaskEither<SlidyError, PackageName> putPackage(PackageName package) {
    return TaskEither(
      () async {
        pubspec.update([package.isDev ? 'dev_dependencies' : 'dependencies', package.name], package.version);
        final result = await pubspec.save();
        if (result) {
          return Right(package);
        } else {
          return Left(PackageManagerError('$package not added in pubspec.yaml'));
        }
      },
    );
  }

  @override
  TaskEither<SlidyError, PackageName> removePackage(PackageName package) {
    return TaskEither(() async {
      try {
        final isRemoved = pubspec.remove([package.isDev ? 'dev_dependencies' : 'dependencies', package.name]);
        if (!isRemoved) {
          return Left(PackageManagerError('Dependency not exist'));
        }
        final result = await pubspec.save();
        if (result) {
          return Right(package);
        } else {
          return Left(PackageManagerError('$package not removed in pubspec.yaml'));
        }
      } on SlidyError catch (e) {
        return Left(e);
      }
    });
  }

  @override
  TaskEither<SlidyError, List<String>> findPackage(String packageName) {
    return TaskEither(() async {
      try {
        final packages = await datasource.searchPackage(packageName);
        return Right(packages);
      } on SlidyError catch (e) {
        return Left(e);
      } on SocketException catch (e) {
        if (e.osError?.errorCode == 11001) {
          throw PackageManagerError('Internet error');
        }
        rethrow;
      }
    });
  }
}
