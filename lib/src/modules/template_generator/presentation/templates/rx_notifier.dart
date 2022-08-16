import 'package:slidy/src/core/models/custom_file.dart';

final _rxNotifierTemplate = r''' 
rx_notifier: |
  import 'package:rx_notifier/rx_notifier.dart';
   
  class $fileName|pascalcase {
    final _count = RxNotifier<int>(0);
    int get count => _count.value;
    setCount(int value) => _count.value = value;
  
    void increment() {
      setCount(count + 1);
    } 
  }
rx_notifier_test: |
  import 'package:flutter_test/flutter_test.dart';
  $arg2
   
  void main() {
    late $arg1 controller;
  
    setUpAll(() {
      controller = $arg1();
    });
  
    test('increment count', () async {
      expect(controller.count, equals(0));
      controller.increment();
      expect(controller.count, equals(1));
    });
  }
''';

final rxnotifierFile = CustomFile(yaml: _rxNotifierTemplate);
