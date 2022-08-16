import 'package:pub_api_client/pub_api_client.dart';
import 'package:slidy/di/injection.dart';
import 'package:slidy/src/modules/package_manager/domain/usecases/install.dart';

import 'domain/repositories/package_repository.dart';
import 'domain/usecases/uninstall.dart';
import 'external/pub_service.dart';
import 'infra/datasources/pub_service.dart';
import 'infra/repositories/package_repository.dart';

void PackageManagerModule() {
  sl
//domain
    ..register<Install>((i) => InstallImpl(i()))
    ..register<Uninstall>((i) => UninstallImpl(i()))
    //infra
    ..register<PackageRepository>((i) => PackageRepositoryImpl(pubspec: i(), client: i()))
    //external
    ..register<PubClient>((i) => PubClient())
    ..register<PubService>((i) => PubServiceImpl(i()));
}
