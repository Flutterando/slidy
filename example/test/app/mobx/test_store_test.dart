import 'package:flutter_test/flutter_test.dart';
import 'package:example/app/mobx/test_store.dart';
 
void main() {
  late TestStore store;

  setUpAll(() {
    store = TestStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}