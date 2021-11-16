import 'package:slidy/di/injection.dart';
import 'package:slidy/src/modules/package_instalation/domain/usecases/install.dart';

import 'domain/repositories/package_instalation_repository.dart';
import 'domain/usecases/uninstall.dart';
import 'external/get_package_version.dart';
import 'infra/datasources/get_package_version.dart';
import 'infra/repositories/package_instalation_repository.dart';

void PackageInstalationModule() {
  sl
//domain
    ..register((i) => Install(i()))
    ..register((i) => Uninstall(i()))
    //infra
    ..register<PackageInstalationRepository>(
        (i) => PackageInstalationRepositoryImpl(pubspec: i(), client: i()))
    //external
    ..register<GetPackageVersion>((i) => GetPackageVersionImpl(i()));
}
