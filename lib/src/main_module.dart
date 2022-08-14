import 'dart:io';

import 'package:http/http.dart';
import 'package:slidy/di/injection.dart';
import 'package:slidy/src/core/interfaces/yaml_service.dart';
import 'package:slidy/src/core/services/yaml_service_impl.dart';

import 'modules/package_instalation/package_instalation_module.dart';
import 'modules/run/run_module.dart';

void StartAllModules() {
  sl
    //services
    ..register<YamlService>((i) => YamlServiceImpl(yaml: File('pubspec.yaml')))

    //external
    ..register<Client>((i) => Client());

  PackageInstalationModule();
  RunModule();
}
