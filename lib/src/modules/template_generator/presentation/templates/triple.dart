import 'package:slidy/src/core/models/custom_file.dart';

final _tripleTemplate = r''' 
triple: |
  import 'package:flutter_triple/flutter_triple.dart';
  
  class $fileName|pascalcase extends NotifierStore<Exception, int> {
  
    $fileName|pascalcase() : super(0);
  
  }
triple_test: |
  import 'package:flutter_test/flutter_test.dart';
  $arg2
   
  void main() {
    late $arg1 store;
  
    setUpAll(() {
      store = $arg1();
    });
  
    test('increment count', () async {
      expect(store.state, equals(0));
      store.update(store.state + 1);
      expect(store.state, equals(1));
    });
  }
''';

final tripleFile = CustomFile(yaml: _tripleTemplate);
