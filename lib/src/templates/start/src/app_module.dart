String startAppModule(String pkg) => '''
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:${pkg}/app/app_widget.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();

}
  ''';

  String startAppModuleModular(String pkg) => '''
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:${pkg}/app/app_widget.dart';
import 'package:${pkg}/app/modules/home/home_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
    Router('/', module: HomeModule()),
  ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();

}
  ''';
