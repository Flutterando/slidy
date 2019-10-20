String blocTestGenerator(String name, String packageName, String import) => '''
import 'package:flutter_test/flutter_test.dart';

import 'package:${packageName}/${import.replaceFirst("lib/", "").replaceAll("\\", "/")}';

void main() {
  ${name}Bloc bloc;
  
  setUp(() {
      bloc = ${name}Bloc();
  });

  group('${name}Bloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<${name}Bloc>());
    });
  });

}
  ''';
