import 'package:bloc/bloc.dart';

enum TestEvent {increment}

class TestBloc extends Bloc<TestEvent, int> {
  TestBloc() : super(0);

  @override
  Stream<int> mapEventToState(TestEvent event) async* {
    switch (event) {
      case TestEvent.increment:
        yield state + 1;
        break;
    }
  }
}