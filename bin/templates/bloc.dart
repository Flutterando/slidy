import 'package:slidy/src/core/models/custom_file.dart';

final _blocTemplate = r''' 
bloc:
  - import 'package:bloc/bloc.dart';
  - 
  - enum $arg1 {increment}
  - 
  - class $fileName|pascalcase extends Bloc<$arg1, int> {
  -   $fileName|pascalcase() : super(0);
  - 
  -   @override
  -   Stream<int> mapEventToState($arg1 event) async* {
  -     switch (event) {
  -       case $arg1.increment:
  -         yield state + 1;
  -         break;
  -     }
  -   }
  - }
bloc_test:
  - import 'package:flutter_test/flutter_test.dart';
  - import 'package:bloc_test/bloc_test.dart';
  - $arg2
  -  
  - void main() {
  - 
  -   blocTest<$arg1, int>('emits [1] when increment is added',
  -     build: () => $arg1(),
  -     act: (bloc) => bloc.add($arg3.increment),
  -     expect: () => [1],
  -   );
  - }
cubit:
  - import 'package:bloc/bloc.dart';
  - 
  - class $fileName|pascalcase extends Cubit<int> {
  -   $fileName|pascalcase() : super(0);
  - 
  -   @override
  -   void increment() => emit(state+1);
  - 
  - }
cubit_test:
  - import 'package:flutter_test/flutter_test.dart';
  - import 'package:bloc_test/bloc_test.dart';
  - $arg2
  -  
  - void main() {
  - 
  -   blocTest<$arg1, int>('emits [1] when increment is added',
  -     build: () => $arg1(),
  -     act: (cubit) => cubit.increment(),
  -     expect: () => [1],
  -   );
  - }
'''
    .split('\n');

final blocFile = CustomFile(lines: _blocTemplate);
