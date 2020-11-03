import 'package:recase/recase.dart';
import 'package:slidy/src/utils/object_generate.dart';

String interfaceUseCaseGenerator(ObjectGenerate obj) => '''
abstract class I${obj.name} {
  call();
}
  ''';

String useCaseGenerator(ObjectGenerate obj) => '''
import 'package:flutter_modular/flutter_modular.dart';

@Injectable()
class ${obj.name} {

  void call() {
  }

}
  ''';

String extendsInterfaceUseCaseGenerator(ObjectGenerate obj) => '''
import 'package:flutter_modular/flutter_modular.dart';

import 'interfaces/${ReCase(obj.name).snakeCase}_interface.dart';

@Injectable()
class ${obj.name} implements I${obj.name} {

  void call() {
  }

}
  ''';
