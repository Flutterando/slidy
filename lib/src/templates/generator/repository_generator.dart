import 'package:recase/recase.dart';
import 'package:slidy/src/utils/object_generate.dart';

String repositoryGenerator(ObjectGenerate obj) => '''
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';

class ${obj.name}Repository extends Disposable {

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

String repositoryGeneratorModular(ObjectGenerate obj) => '''
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/native_imp.dart';

class ${obj.name}Repository extends Disposable {
  final DioForNative client;

  ${obj.name}Repository(this.client);

  Future fetchPost() async {
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

String interfaceRepositoryGeneratorModular(ObjectGenerate obj) => '''
import 'package:flutter_modular/flutter_modular.dart';

abstract class I${obj.name}Repository implements Disposable {
  Future fetchPost();
}''';

String extendsInterfaceRepositoryGeneratorModular(ObjectGenerate obj) => '''
import 'package:dio/native_imp.dart';
import 'interfaces/${ReCase(obj.name).snakeCase}_repository_interface.dart';

class ${obj.name}Repository implements I${obj.name}Repository {

  final DioForNative client;

  ${obj.name}Repository(this.client);

  Future fetchPost() async {
    final response =
        await client.get('https://jsonplaceholder.typicode.com/posts/1');
    return response.data;
  }

  //dispose will be called automatically
  @override
  void dispose() {
    
  }
}''';

String interfaceRepositoryGenerator(ObjectGenerate obj) => '''
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/native_imp.dart';

abstract class I${obj.name}Repository implements Disposable {

  Future fetchPost(DioForNative client);
}
  ''';

String extendsInterfaceRepositoryGenerator(ObjectGenerate obj) => '''
import 'package:dio/native_imp.dart';
import 'interfaces/${ReCase(obj.name).snakeCase}_repository_interface.dart';

class ${obj.name}Repository implements I${obj.name}Repository {

  Future fetchPost(DioForNative client) async {
    final response = await client.get('https://jsonplaceholder.typicode.com/posts/1');
    return response.data;
  }

  //dispose will be called automatically
  @override
  void dispose() {
    
  }

}
  ''';
