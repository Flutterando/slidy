import 'package:slidy/src/services/pub_service.dart';
import 'package:slidy/src/templates/templates.dart';
import 'package:test/test.dart';

void main() {
  group('GetPackage Test', () {
    test("package inexistente exception with text 'Exception: error'", () {
      expect(pageTestGenerator("teste_page" , "package_teste" , "import 'package:bloc_pattern/bloc_pattern_test.dart';" , "test_module","modules/teste"), "");
    });
  });
}
