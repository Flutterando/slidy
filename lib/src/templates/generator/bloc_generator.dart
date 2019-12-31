import 'package:recase/recase.dart';

String blocGenerator(String name) => '''
import 'package:bloc_pattern/bloc_pattern.dart';

class ${ReCase(name).pascalCase}Bloc extends BlocBase {

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }

}
  ''';

String blocGeneratorModular(String name) => '''
import 'package:flutter_modular/flutter_modular.dart';

class ${ReCase(name).pascalCase}Bloc extends Disposable {

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {

  }

}
  ''';

String flutter_blocGenerator(String name) => '''
import 'dart:async';
import 'package:bloc/bloc.dart';

import '${ReCase(name).snakeCase}_event.dart';
import '${ReCase(name).snakeCase}_state.dart';

class ${ReCase(name).pascalCase}Bloc extends Bloc<${ReCase(name).pascalCase}Event, ${ReCase(name).pascalCase}State> {
  @override
  ${ReCase(name).pascalCase}State get initialState => Initial${ReCase(name).pascalCase}State();

  @override
  Stream<${ReCase(name).pascalCase}State> mapEventToState(${ReCase(name).pascalCase}Event event) async* {
    // TODO: Add Logic
  }
}
  ''';

String flutter_blocEventGenerator(String name) => '''
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ${ReCase(name).pascalCase}Event extends Equatable {}

  ''';

String flutter_blocStateGenerator(String name) => '''
import 'package:meta/meta.dart';

@immutable
abstract class ${ReCase(name).pascalCase}State {}
  
class Initial${ReCase(name).pascalCase}State extends ${ReCase(name).pascalCase}State {}
  ''';

String mobx_blocGenerator(String name) => '''
import 'package:mobx/mobx.dart';

part '${ReCase(name).snakeCase}_controller.g.dart';

class ${ReCase(name).pascalCase}Controller = _${ReCase(name).pascalCase}Base with _\$${ReCase(name).pascalCase}Controller;

abstract class _${ReCase(name).pascalCase}Base with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
  ''';
