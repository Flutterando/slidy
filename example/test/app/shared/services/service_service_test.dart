import 'package:flutter_test/flutter_test.dart';
import 'package:example/app/shared/services/service_service.dart';

void main() {
  ServiceService service;

  setUp(() {
    service = ServiceService();
  });

  group('ServiceService Test', () {
    test("First Test", () {
      expect(service, isInstanceOf<ServiceService>());
    });
  });
}
