String startAppModule(String pkg) => '''
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:${pkg}/app/app_widget.dart';
<<<<<<< HEAD
import 'package:${pkg}/app/app_bloc.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
    Bloc((i) => AppBloc()),
  ];
=======

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [];
>>>>>>> 2f431f953aed90d425f32232a3317fd7f82f3bb4

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();

}
  ''';
