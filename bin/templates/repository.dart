import 'package:slidy/src/core/models/custom_file.dart';

final _repositoryTemplate = r''' 
repository:
  - class $fileName|pascalcase {
  - 
  - }
i_repository:
  - abstract class I$arg1 {
  - 
  - }
impl_repository:
  - import '$fileName_interface.dart';
  - 
  - class $fileName|pascalcase implements I$fileName|pascalcase {
  - 
  - }
'''
    .split('\n');

//TODO colocar test_file

final repositoryFile = CustomFile(lines: _repositoryTemplate);
