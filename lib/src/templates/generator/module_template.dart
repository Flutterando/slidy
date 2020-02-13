String moduleGenerator(String pkg, String name, String path) {
  path = path.replaceFirst("lib/", "");

  var import =
      pkg.isNotEmpty ? "import 'package:${pkg}/${path}_page.dart';" : '';

  var page = pkg.isNotEmpty ? '${name}Page()' : 'Container()';

  return '''
  import 'package:bloc_pattern/bloc_pattern.dart';
  import 'package:flutter/material.dart';
  ${import.replaceFirst('$pkg/$pkg', pkg)}
  class ${name}Module extends ModuleWidget {
  @override
  List<Bloc> get blocs => [];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ${page};

  static Inject get to => Inject<${name}Module>.of();

}
  ''';
}

String moduleGeneratorModular(String pkg, String name, String path) {
  path = path.replaceFirst('lib/', '');

  var import =
      pkg.isNotEmpty ? "import 'package:${pkg}/${path}_page.dart';" : '';
  var router =
      pkg.isNotEmpty ? "Router('/', child: (_, args) => ${name}Page())," : '';

  return '''
  import 'package:flutter_modular/flutter_modular.dart';
  ${import.replaceFirst('$pkg/$pkg', pkg)}
  class ${name}Module extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [$router];

  static Inject get to => Inject<${name}Module>.of();

}
  ''';
}

String moduleGeneratorModularNoRoute(String pkg, String name, String path) {
  path = path.replaceFirst('lib/', '');

  var import =
      pkg.isNotEmpty ? "import 'package:${pkg}/${path}_page.dart';" : '';

  return '''
  import 'package:flutter_modular/flutter_modular.dart';
  import 'package:flutter/material.dart';
  ${import.replaceFirst('$pkg/$pkg', pkg)}
  class ${name}Module extends ModuleWidget {
  @override
  List<Bind> get binds => [];

  static Inject get to => Inject<${name}Module>.of();

  @override  
  Widget get view => ${name}Page();
}
  ''';
}
