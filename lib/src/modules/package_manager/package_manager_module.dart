import 'package:pub_api_client/pub_api_client.dart';
import 'package:slidy/src/core/modular/module.dart';
import 'package:slidy/src/modules/package_manager/domain/usecases/find.dart';
import 'package:slidy/src/modules/package_manager/domain/usecases/install.dart';

import '../../core/modular/bind.dart';
import 'domain/repositories/package_repository.dart';
import 'domain/usecases/uninstall.dart';
import 'domain/usecases/versions.dart';
import 'external/pub_service.dart';
import 'infra/datasources/pub_service.dart';
import 'infra/repositories/package_repository.dart';

class PackageManagerModule extends Module {
  @override
  List<Bind> get binds => [
        //domain
        Bind.singleton<Install>((i) => InstallImpl(i()), export: true),
        Bind.singleton<Uninstall>((i) => UninstallImpl(i()), export: true),
        Bind.singleton<Versions>((i) => VersionsImpl(i()), export: true),
        Bind.singleton<Find>((i) => FindImpl(i()), export: true),
        //infra
        Bind.singleton<PackageRepository>((i) => PackageRepositoryImpl(pubspec: i(), datasource: i()), export: true),
        //external
        Bind.singleton<PubClient>((i) => PubClient(), export: true),
        Bind.singleton<PubService>((i) => PubServiceImpl(i()), export: true),
      ];
}
