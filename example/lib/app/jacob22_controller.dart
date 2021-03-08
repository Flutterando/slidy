import 'package:rx_notifier/rx_notifier.dart';

class Jacob22Controller {
  final _count = RxNotifier<int>(0);
  int get count => _count.value;
  set count(int value) => _count.value = value;

  void increment() {
    count++;
  }
}
