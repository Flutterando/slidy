import 'package:recase/recase.dart';
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

String interfaceServiceGenerator(ObjectGenerate obj) => '''
import 'package:bloc_pattern/bloc_pattern.dart';

abstract class I${obj.name}Service implements Disposable {

}
  ''';

String extendsInterfaceServiceGenerator(ObjectGenerate obj) => '''
import 'package:bloc_pattern/bloc_pattern.dart';
import '${ReCase(obj.name).snakeCase}_service_interface.dart';

class ${obj.name}Service implements I${obj.name}Service {
  //dispose will be called automatically
  @override
  void dispose() {
    
  }
}
  ''';

String interfaceServiceGeneratorModular(ObjectGenerate obj) => '''
import 'package:flutter_modular/flutter_modular.dart';

abstract class I${obj.name}Service implements Disposable {

}
  ''';

String extendsInterfaceServiceGeneratorModular(ObjectGenerate obj) => '''
import 'package:flutter_modular/flutter_modular.dart';
import '${ReCase(obj.name).snakeCase}_service_interface.dart';

class ${obj.name}Service implements I${obj.name}Service {
  //dispose will be called automatically
  @override
  void dispose() {
    
  }
}
  ''';
