import 'package:slidy/src/services/pub_service.dart';
import 'package:test/test.dart';

void main() {
  PubService pubService;
  setUp(() {
    pubService = PubService();
  });

  group('GetPackage Test', () {
    test('getPackage', () async {
      expect(await pubService.getPackage('bloc_pattern', '2.4.4'), '2.4.4');
    });

    test('package inexistente exception', () {
      expect(
          () async =>
              await pubService.getPackage('bloc_pattern_with_00', '1.0.0'),
          throwsA(isA<Exception>()));
    });

    test('package inexistente exception with text \'Exception: error\'', () {
      expect(
          () async =>
              await pubService.getPackage('bloc_pattern_with_00', '1.0.0'),
          throwsA(predicate(
              (e) => e is Exception && e.toString() == 'Exception: error')));
    });
  });
}
