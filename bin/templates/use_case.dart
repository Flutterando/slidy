import 'package:slidy/src/core/models/custom_file.dart';

final _useCaseTemplate = r''' 
use_case:
  - import 'package:dartz/dartz.dart';
  - 
  - abstract class I$fileName|pascalcase {
  -   Future<Either<$fileName|pascalcaseFailure, List<$fileName|pascalcase>>> call();
  - }
  - 
  - class $fileName|pascalcase extends I$fileName|pascalcase { 
  - 
  -   $fileName|pascalcase();
  - 
  -   @override
  -   Future<Either<$fileName|pascalcaseFailure, List<$fileName|pascalcase>>> call() async {
  -     throw UnimplementedError();
  -   }
  - }


use_case_test:
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
  -   var featureMessage = await $fileName|pascalcase()();
  -
  -    expect(featureMessage | null, isInstanceOf<List<$fileName|pascalcase>>());
  -   });
  - }
'''
    .split('\n');

final use_case = CustomFile(lines: _useCaseTemplate);
