import 'package:slidy/src/utils/object_generate.dart';

String blocTestGenerator(ObjectGenerate obj) {
  final importBloc =
      'package:${obj.packageName}/${obj.import.replaceFirst("lib/", "").replaceAll("\\", "/")}'
          .replaceFirst(
              '${obj.packageName}/${obj.packageName}', obj.packageName);
  final importModule =
      'package:${obj.packageName}/${obj.pathModule.replaceFirst("lib/", "").replaceAll("\\", "/")}'
          .replaceFirst(
              '${obj.packageName}/${obj.packageName}', obj.packageName);
  return '''
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import '$importBloc';
import '$importModule';

void main() {

  initModule(${obj.module}());
  ${obj.name}Bloc bloc;
  
 // setUp(() {
 //     bloc = ${obj.module}.to.bloc<${obj.name}Bloc>();
 // });

 // group('${obj.name}Bloc Test', () {
 //   test("First Test", () {
 //     expect(bloc, isInstanceOf<${obj.name}Bloc>());
 //   });
 // });

}
  ''';
}

String blocTestGeneratorModular(ObjectGenerate obj) => '''
import 'package:flutter_modular/flutter_modular_test.dart';    
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:${obj.packageName}/app/app_module.dart';
import 'package:${obj.packageName}/${obj.import.replaceFirst("lib/", "").replaceAll("\\", "/")}';
import 'package:${obj.packageName}/${obj.pathModule.replaceFirst("lib/", "").replaceAll("\\", "/")}';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(${obj.module}());
  ${obj.name}Bloc bloc;
  
 // setUp(() {
 //     bloc = ${obj.module}.to.get<${obj.name}Bloc>();
 // });

 // group('${obj.name}Bloc Test', () {
 //   test("First Test", () {
 //     expect(bloc, isInstanceOf<${obj.name}Bloc>());
 //   });
 // });

}
  ''';

String mobxBlocTestGenerator(ObjectGenerate obj) => '''
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:${obj.packageName}/${obj.import.replaceFirst("lib/", "").replaceAll("\\", "/")}';
import 'package:${obj.packageName}/${obj.pathModule.replaceFirst("lib/", "").replaceAll("\\", "/")}';

void main() {
  
  initModule(${obj.module}());

  ${obj.name}${obj.type[0].toUpperCase()}${obj.type.substring(1)} ${obj.name.toLowerCase()};
  
  setUp(() {
      ${obj.name.toLowerCase()} = ${obj.module}.to.get<${obj.name}${obj.type[0].toUpperCase()}${obj.type.substring(1)}>();
  });

  group('${obj.name}${obj.type[0].toUpperCase()}${obj.type.substring(1)} Test', () {
  //  test("First Test", () {
  //    expect(${obj.name.toLowerCase()}, isInstanceOf<${obj.name}${obj.type[0].toUpperCase()}${obj.type.substring(1)}>());
  //  });

  //  test("Set Value", () {
  //    expect(${obj.name.toLowerCase()}.value, equals(0));
  //    ${obj.name.toLowerCase()}.increment();
  //    expect(${obj.name.toLowerCase()}.value, equals(1));
  //  });
  });

}
  ''';

String mobxBlocTestGeneratorModular(ObjectGenerate obj) => '''
import 'package:flutter_modular/flutter_modular_test.dart';    
import 'package:flutter_test/flutter_test.dart';

import 'package:${obj.packageName}/${obj.import.replaceFirst("lib/", "").replaceAll("\\", "/")}';
import 'package:${obj.packageName}/${obj.pathModule.replaceFirst("lib/", "").replaceAll("\\", "/")}';

void main() {

  initModule(${obj.module}());
 // ${obj.name}${obj.type[0].toUpperCase()}${obj.type.substring(1)} ${obj.name.toLowerCase()};
 // 
  setUp(() {
 //     ${obj.name.toLowerCase()} = ${obj.module}.to.get<${obj.name}${obj.type[0].toUpperCase()}${obj.type.substring(1)}>();
  });

  group('${obj.name}${obj.type[0].toUpperCase()}${obj.type.substring(1)} Test', () {
 //   test("First Test", () {
 //     expect(${obj.name.toLowerCase()}, isInstanceOf<${obj.name}${obj.type[0].toUpperCase()}${obj.type.substring(1)}>());
 //   });

 //   test("Set Value", () {
 //     expect(${obj.name.toLowerCase()}.value, equals(0));
 //     ${obj.name.toLowerCase()}.increment();
 //     expect(${obj.name.toLowerCase()}.value, equals(1));
 //   });
  });

}
  ''';
