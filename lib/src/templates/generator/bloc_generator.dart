String blocGenerator(String name) => '''
import 'package:bloc_pattern/bloc_pattern.dart';

class ${name}Bloc extends BlocBase {

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }

}
  ''';

String blocGeneratorModular(String name) => '''
import 'package:flutter_modular/flutter_modular.dart';

class ${name}Bloc extends Disposable {

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {

  }

}
  ''';

String flutter_blocGenerator(String name) => '''
import 'package:bloc/bloc.dart';

enum ${name}Event { increment, decrement }

class ${name}Bloc extends Bloc<${name}Event, int> {

  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(${name}Event event) async* {
    switch (event) {
      case ${name}Event.decrement:
        yield state - 1;
        break;
      case ${name}Event.increment:
        yield state + 1;
        break;
    }
  }
}
  ''';
  

String mobx_blocGenerator(String name) => '''
import 'package:mobx/mobx.dart';

part '${name.toLowerCase()}_controller.g.dart';

class ${name}Controller = _${name}Base with _\$${name}Controller;

abstract class _${name}Base with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
  ''';
