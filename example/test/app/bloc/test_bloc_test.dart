import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:example/app/bloc/test_bloc.dart';
 
void main() {

  blocTest<TestBloc, int>('emits [1] when increment is added',
    build: () => TestBloc(),
    act: (bloc) => bloc.add(TestEvent.increment),
    expect: () => [1],
  );
}