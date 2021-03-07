import 'package:flutter_test/flutter_test.dart';
import 'package:example/app/home/home_store.dart';
 
void main() {
  late HomeStore store;

  setUpAll(() {
    store = HomeStore();
  });

  test('increment count', () async {
    expect(store.state, equals(0));
    store.update(store.state + 1);
    expect(store.state, equals(1));
  });
}