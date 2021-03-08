import 'package:slidy/src/core/models/custom_file.dart';

final _blocTemplate = r''' 
bloc:
  - import 'package:flutter_triple/flutter_triple.dart';
  - 
  - enum $arg1 {increment, decrement};
  - 
  - class $fileName|pascalcase extends Bloc<$arg1, int> {
  -   $fileName|pascalcase() : super(0);
  - 
  - @override
  - Stream<int> mapEventToState($arg1 event) async* {
  -   switch (event) {
  -     case $arg1.increment:
  -       yield state + 1;
  -       break;
  -   }
  - }
  - 
  - }
triple_test:
  - import 'package:flutter_test/flutter_test.dart';
  - $arg2
  -  
  - void main() {
  -   late $arg1 store;
  - 
  -   setUpAll(() {
  -     store = $arg1();
  -   });
  - 
  -   test('increment count', () async {
  -     expect(store.state, equals(0));
  -     store.update(store.state + 1);
  -     expect(store.state, equals(1));
  -   });
  - }
'''
    .split('\n');

final blocFile = CustomFile(lines: _blocTemplate);
