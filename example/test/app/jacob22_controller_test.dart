import 'package:flutter_test/flutter_test.dart';
import 'package:example/app/jacob22_controller.dart';
 
void main() {
  late Jacob22Controller controller;

  setUpAll(() {
    controller = Jacob22Controller();
  });

  test('increment count', () async {
    expect(controller.count, equals(0));
    controller.increment();
    expect(controller.count, equals(1));
  });
}