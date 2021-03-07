// ignore: unused_element

import 'dart:io';

import 'package:http/http.dart';
import 'package:slidy/di/injection.dart';

import 'core/interfaces/pubspec_service.dart';
import 'core/services/pubspec_service_impl.dart';
import 'modules/package_instalation/package_instalation_module.dart';

void StartAllModules() {
  sl
    //services
    ..register<PubspecService>((i) => PubspecServiceImpl(yaml: File('pubspec.yaml')))

    //external
    ..register<Client>((i) => Client());

  PackageInstalationModule();
}
