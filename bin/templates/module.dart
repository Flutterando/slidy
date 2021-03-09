import 'package:slidy/src/core/models/custom_file.dart';

final _generateTemplate = ''' 
module:
  - import 'package:flutter_modular/flutter_modular.dart';
  - import 'package:flutter/material.dart';
  - 
  - class \$fileName|pascalcase extends Module {
  -   @override
  -   final List<Bind> binds = [];
  - 
  -   @override
  -   final List<ModularRoute> routes = [];
  - 
  - }
'''
    .split('\n');

final generateFile = CustomFile(lines: _generateTemplate);
