import 'package:flutter_test/flutter_test.dart';
import 'package:example/app/modules/insurence/insurence_store.dart';

void main() {
  late InsurenceStore store;

  setUpAll(() {
    store = InsurenceStore();
  });

  test('increment count', () async {
    expect(store.state, equals(0));
    store.update(store.state + 1);
    expect(store.state, equals(1));
  });
}
