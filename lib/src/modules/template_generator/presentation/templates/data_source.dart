import 'package:slidy/src/core/models/custom_file.dart';

final _dataSourceTemplate = r''' 
interface_data_source: |
  abstract class I$fileName|pascalcase {  
    
    Future<List<String>> getListData();
  }

data_source: |
  import 'package:dio/dio.dart';  
  $arg2
  class $fileName|pascalcaseImpl implements I$fileName|pascalcase {
    final Dio dio;
  
    $fileName|pascalcaseImpl(this.dio);
  
    @override
    Future<List<String>> getListData() async {
      var response = await dio.get('url');
      return response.data;
    }
  }

data_source_test: | 
  import 'package:flutter_test/flutter_test.dart'; 
   
  void main() {
    //late $arg1 dataSource;
  
    setUpAll(() {
    //  dataSource = $arg3();
    });
  } 
''';

final data_source = CustomFile(yaml: _dataSourceTemplate);
