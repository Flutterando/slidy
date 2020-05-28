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

${obj.hasInterface ? obj.import : ''}

class ${obj.name}Service extends Disposable ${obj.hasInterface ? 'implements I${obj.name}Service' : ''} {

  //dispose will be called automatically
  @override
  void dispose() {
    
  }

}
  ''';
String serviceInterfaceGenerator(ObjectGenerate obj) => '''
abstract class ${obj.name}Service {
}
  ''';
