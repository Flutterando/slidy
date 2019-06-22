class AppInitModel {
String appWidget(String package) => '''
import 'package:flutter/material.dart';
import 'package:${package}/src/home/home_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Slidy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeModule(),
    );
  }
}
  ''';

String appBloc() => '''
import 'package:bloc_pattern/bloc_pattern.dart';

class AppBloc extends BlocBase {

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }

}
  ''';

String appModule(String package) => '''
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:${package}/src/app_widget.dart';
import 'package:${package}/src/app_bloc.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
    Bloc((i) => AppBloc()),
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();

}
  ''';

  String mainInit(String package) => '''
import 'package:flutter/material.dart';
import 'package:${package}/src/app_module.dart';

void main() => runApp(AppModule());
  ''';
}