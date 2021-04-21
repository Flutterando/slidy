import 'package:slidy/src/core/models/custom_file.dart';

final _repositoryTemplate = r''' 
repository: |
  class $fileName|pascalcase {
  
  }
i_repository: |
  abstract class I$arg1 {
  
  }
impl_repository: |
  import '$fileName_interface.dart';
  
  class $fileName|pascalcase implements I$fileName|pascalcase {
  
  }
test_repository: |
  import 'package:flutter_test/flutter_test.dart';
  $arg2
   
  void main() {
    late $arg1 repository;
  
    setUpAll(() {
      repository = $arg1();
    });
  }
''';

final repositoryFile = CustomFile(yaml: _repositoryTemplate);
