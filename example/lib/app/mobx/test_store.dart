import 'package:mobx/mobx.dart';

part 'test_store.g.dart';

class TestStore = _TestStoreBase with _$TestStore;
abstract class _TestStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}