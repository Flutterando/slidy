String repositoryGenerator(String name) => '''
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';

class ${name}Repository extends Disposable {

  Future fetchPost(Dio client) async {
    final response =
        await client.get('https://jsonplaceholder.typicode.com/posts/1');
    return response.data;
  }


  //dispose will be called automatically
  @override
  void dispose() {
    
  }

}
  ''';

String repositoryGeneratorModular(String name) => '''
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';

class ${name}Repository extends Disposable {

  Future fetchPost(Dio client) async {
    final response =
        await client.get('https://jsonplaceholder.typicode.com/posts/1');
    return response.data;
  }


  //dispose will be called automatically
  @override
  void dispose() {
    
  }

}
  ''';
