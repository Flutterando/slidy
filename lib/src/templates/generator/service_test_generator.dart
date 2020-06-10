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

String interfaceServiceTestGenerator(ObjectGenerate obj) {
  final fileDart = obj.import.split('/').last;
  final import =
      '${obj.import.replaceFirst("lib/", "").replaceAll(fileDart, 'interfaces/')}$fileDart';
  return '''
import 'package:flutter_test/flutter_test.dart';

import 'package:${obj.packageName}/${import.replaceAll(".dart", "_interface.dart")}';


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
}
