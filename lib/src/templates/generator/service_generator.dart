String serviceGenerator(String name) => '''
import 'package:bloc_pattern/bloc_pattern.dart';

class ${name}Service extends Disposable {

  //dispose will be called automatically
  @override
  void dispose() {
    
  }

}
  ''';

String serviceGeneratorModular(String name) => '''
import 'package:flutter_modular/flutter_modular.dart';

class ${name}Service extends Disposable {

  //dispose will be called automatically
  @override
  void dispose() {
    
  }

}
  ''';
