String blocTestGenerator(String name, String packageName, String import,
        String module, String pathModule) =>
    '''
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:${packageName}/${import.replaceFirst("lib/", "").replaceAll("\\", "/")}';
import 'package:${packageName}/${pathModule.replaceFirst("lib/", "").replaceAll("\\", "/")}';

void main() {

  initModule(${module}());
  ${name}Bloc bloc;
  
  setUp(() {
      bloc = ${module}.to.bloc<${name}Bloc>();
  });

  group('${name}Bloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<${name}Bloc>());
    });
  });

}
  ''';

String blocTestGeneratorModular(String name, String packageName, String import,
        String module, String pathModule) =>
    '''
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:${packageName}/app/app_module.dart;
import 'package:${packageName}/${import.replaceFirst("lib/", "").replaceAll("\\", "/")}';
import 'package:${packageName}/${pathModule.replaceFirst("lib/", "").replaceAll("\\", "/")}';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(${module}());
  ${name}Bloc bloc;
  
  setUp(() {
      bloc = ${module}.to.get<${name}Bloc>();
  });

  group('${name}Bloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<${name}Bloc>());
    });
  });

}
  ''';

String mobxBlocTestGenerator(String name, String packageName, String import,
        String module, String pathModule) =>
    '''
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:${packageName}/${import.replaceFirst("lib/", "").replaceAll("\\", "/")}';
import 'package:${packageName}/${pathModule.replaceFirst("lib/", "").replaceAll("\\", "/")}';

void main() {

  Modular.init(AppModule());
  bindModule(${module}());
  ${name}Controller ${name.toLowerCase()};
  
  setUp(() {
      ${name.toLowerCase()} = ${module}.to.bloc<${name}Controller>();
  });

  group('${name}Controller Test', () {
    test("First Test", () {
      expect(${name.toLowerCase()}, isInstanceOf<${name}Controller>());
    });

    test("Set Value", () {
      expect(${name.toLowerCase()}.value, equals(0));
      ${name.toLowerCase()}.increment();
      expect(${name.toLowerCase()}.value, equals(1));
    });
  });

}
  ''';

String mobxBlocTestGeneratorModular(String name, String packageName, String import,
        String module, String pathModule) =>
    '''
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:${packageName}/${import.replaceFirst("lib/", "").replaceAll("\\", "/")}';
import 'package:${packageName}/${pathModule.replaceFirst("lib/", "").replaceAll("\\", "/")}';

void main() {

  initModule(${module}());
  ${name}Controller ${name.toLowerCase()};
  
  setUp(() {
      ${name.toLowerCase()} = ${module}.to.bloc<${name}Controller>();
  });

  group('${name}Controller Test', () {
    test("First Test", () {
      expect(${name.toLowerCase()}, isInstanceOf<${name}Controller>());
    });

    test("Set Value", () {
      expect(${name.toLowerCase()}.value, equals(0));
      ${name.toLowerCase()}.increment();
      expect(${name.toLowerCase()}.value, equals(1));
    });
  });

}
  ''';
