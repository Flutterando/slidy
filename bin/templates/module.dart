import 'package:slidy/src/core/models/custom_file.dart';

final _generateTemplate = ''' 
module: |
  import 'package:flutter_modular/flutter_modular.dart';
  
  class \$fileName|pascalcase extends Module {
    @override
    final List<Bind> binds = [];
  
    @override
    final List<ModularRoute> routes = [];
  
  }
''';

final generateFile = CustomFile(yaml: _generateTemplate);
