String serviceTestGenerator(String name, String packageName, String import,
        String module, String pathModule) =>
    '''
import 'package:flutter_test/flutter_test.dart';

import 'package:${packageName}/${import.replaceFirst("lib/", "").replaceAll("\\", "/")}';


void main() {
  ${name}Service service;

  setUp(() {
    service = ${name}Service();
  });

  group('${name}Service Test', () {
    test("First Test", () {
      expect(service, isInstanceOf<${name}Service>());
    });

  });
}
  ''';
