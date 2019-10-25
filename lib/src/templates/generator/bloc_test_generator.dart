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
