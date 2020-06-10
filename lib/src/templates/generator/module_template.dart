import 'package:slidy/src/utils/object_generate.dart';

String moduleGenerator(ObjectGenerate obj) {
  final path = obj.pathModule.replaceFirst('lib/', '');
  final pkg = obj.packageName;
  final import =
      pkg.isNotEmpty ? 'import \'package:$pkg/${path}_page.dart\';' : '';

  final page = pkg.isNotEmpty ? '${obj.name}Page()' : 'Container()';

  return '''
  import 'package:bloc_pattern/bloc_pattern.dart';
  import 'package:flutter/material.dart';
  import 'package:dio/dio.dart';
  ${import.replaceFirst('$pkg/$pkg', pkg)}
  class ${obj.name}Module extends ModuleWidget {
  @override
  List<Bloc> get blocs => [];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => $page;

  static Inject get to => Inject<${obj.name}Module>.of();

}
  ''';
}

String moduleGeneratorModular(ObjectGenerate obj) {
  final path = obj.pathModule.replaceFirst('lib/', '');
  final pkg = obj.packageName;

  final import =
      pkg.isNotEmpty ? 'import \'package:$pkg/${path}_page.dart\';' : '';
  final router = pkg.isNotEmpty
      ? 'Router(Modular.initialRoute, child: (_, args) => ${obj.name}Page()),'
      : '';

  return '''
  import 'package:flutter_modular/flutter_modular.dart';
  import 'package:dio/dio.dart';
  ${import.replaceFirst('$pkg/$pkg', pkg)}
  class ${obj.name}Module extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [$router];

  static Inject get to => Inject<${obj.name}Module>.of();

}
  ''';
}

String moduleGeneratorModularNoRoute(ObjectGenerate obj) {
  final path = obj.pathModule.replaceFirst('lib/', '');
  final pkg = obj.packageName;
  final import =
      pkg.isNotEmpty ? 'import \'package:$pkg/${path}_page.dart\';' : '';

  return '''
  import 'package:flutter_modular/flutter_modular.dart';
  import 'package:flutter/material.dart';
  import 'package:dio/dio.dart';
  ${import.replaceFirst('$pkg/$pkg', pkg)}
  class ${obj.name}Module extends WidgetModule {
  @override
  List<Bind> get binds => [];

  static Inject get to => Inject<${obj.name}Module>.of();

  @override  
  Widget get view => ${obj.name}Page();
}
  ''';
}
