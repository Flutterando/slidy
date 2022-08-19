import 'dart:io';

import 'package:http/http.dart';
import 'package:slidy/src/core/modular/module.dart';
import 'package:slidy/src/core/services/yaml_service.dart';
import 'package:slidy/src/core/services/yaml_service_impl.dart';

import 'core/modular/bind.dart';
import 'modules/package_manager/package_manager_module.dart';
import 'modules/pipeline/run_module.dart';

void StartAllModules() {
  PackageManagerModule();
}

class MainModule extends Module {
  @override
  List<Module> get imports => [
        RunModule(),
        PackageManagerModule(),
      ];

  @override
  List<Bind> get binds => [
        //services
        Bind.singleton<YamlService>((i) => YamlServiceImpl(yaml: File('pubspec.yaml'))),
        //external
        Bind.singleton<Client>((i) => Client()),
      ];
}
