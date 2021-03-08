import 'package:slidy/src/core/models/custom_file.dart';

final _serviceTemplate = r''' 
service:
  - class $fileName|pascalcase {
  - 
  - }
i_service:
  - abstract class I$arg1 {
  - 
  - }
impl_service:
  - import '$fileName_interface.dart';
  - 
  - class $fileName|pascalcase implements I$fileName|pascalcase {
  - 
  - }
test_service:
  - import 'package:flutter_test/flutter_test.dart';
  - $arg2
  -  
  - void main() {
  -   late $arg1 service;
  - 
  -   setUpAll(() {
  -     service = $arg1();
  -   });
  - }
'''
    .split('\n');

final serviceFile = CustomFile(lines: _serviceTemplate);
