import 'package:pubspec/pubspec.dart';

String moduleGenerator(String pkg, String name) {
  var import = pkg.isNotEmpty
      ? 'import package:${pkg}/src/${name}/${name}_page.dart\n'
      : '';

  var page = pkg.isNotEmpty ? '${name}Page()' : 'Container()';

  return '''
  import 'package:bloc_pattern/bloc_pattern.dart';
  import 'package:flutter/material.dart';
  ${import}
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
