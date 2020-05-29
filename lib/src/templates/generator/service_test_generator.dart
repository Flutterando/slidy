import 'package:recase/recase.dart';
import 'package:slidy/src/utils/object_generate.dart';

String serviceTestGenerator(ObjectGenerate obj) => '''
import 'package:flutter_test/flutter_test.dart';

import 'package:${obj.packageName}/${obj.import.replaceFirst("lib/", "").replaceAll("\\", "/")}';


void main() {
  ${obj.name}Service service;

  setUp(() {
//    service = ${obj.name}Service();
  });
//
  group('${obj.name}Service Test', () {
//    test("First Test", () {
//      expect(service, isInstanceOf<${obj.name}Service>());
//    });
//
  });
}
  ''';

String interfaceServiceTestGenerator(ObjectGenerate obj) => '''
import 'package:flutter_test/flutter_test.dart';

import 'package:${obj.packageName}/${obj.import.replaceFirst("lib/", "").replaceAll("\\", "/").replaceAll("_service.dart", "_service_interface.dart")}';


void main() {
  I${obj.name}Service service;

  setUp(() {
//    service = ${obj.name}Service();
  });
//
  group('${obj.name}Service Test', () {
//    test("First Test", () {
//      expect(service, isInstanceOf<${obj.name}Service>());
//    });
//
  });
}
  ''';
