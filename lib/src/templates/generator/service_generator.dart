import 'package:slidy/src/utils/object_generate.dart';

String serviceGenerator(ObjectGenerate obj) => '''
import 'package:bloc_pattern/bloc_pattern.dart';

class ${obj.name}Service extends Disposable {

  //dispose will be called automatically
  @override
  void dispose() {
    
  }

}
  ''';

String serviceGeneratorModular(ObjectGenerate obj) => '''
import 'package:flutter_modular/flutter_modular.dart';

class ${obj.name}Service extends Disposable {

  //dispose will be called automatically
  @override
  void dispose() {
    
  }

}
  ''';
