import 'package:recase/recase.dart';
import 'package:slidy/src/utils/object_generate.dart';

String repositoryGeneratorWithHasura(ObjectGenerate obj) => '''
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hasura_connect/hasura_connect.dart';

class ${obj.name}Repository extends Disposable {

  Future fetchPost(HasuraConnect client) async {
    String docQuery = """
      query {
        posts {
          id
          userId
          title
          body
        }
      }
    """;

    final response =
        await client.query(docQuery);

    return response;
  }


  //dispose will be called automatically
  @override
  void dispose() {
    
  }

}
  ''';

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

String repositoyGeneratorModularWithHasura(ObjectGenerate obj) => '''
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hasura_connect/hasura_connect.dart';

part '${ReCase(obj.name).snakeCase}_${obj.type}.g.dart';

@Injectable()
class ${obj.name}Repository extends Disposable {
  final HasuraConnect client;

  ${obj.name}Repository(this.client);

  Future fetchPost() async {
    String docQuery = """
      query {
        posts {
          id
          userId
          title
          body
        }
      }
    """;

    final response =
        await client.query(docQuery);

    return response;
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

part '${ReCase(obj.name).snakeCase}_${obj.type}.g.dart';

@Injectable()
class ${obj.name}Repository extends Disposable {
  final DioForNative client;

  ${obj.name}Repository(this.client);

  Future fetchPost() async {
    final response =
        await client.get('https://jsonplaceholder.typicode.com/posts/1');
    return response;
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

String extendsInterfaceRepositoryGeneratorModularWithHasura(ObjectGenerate obj) => '''
import 'package:hasura_connect/hasura_connect.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'interfaces/${ReCase(obj.name).snakeCase}_repository_interface.dart';

part '${ReCase(obj.name).snakeCase}_${obj.type}.g.dart';

@Injectable()
class ${obj.name}Repository implements I${obj.name}Repository {

  final HasuraConnect client;

  ${obj.name}Repository(this.client);

  Future fetchPost() async {
    String docQuery = """
      query {
        posts {
          id
          userId
          title
          body
        }
      }
    """;

    final response =
        await client.query(docQuery);

    return response;
  }
}''';

String extendsInterfaceRepositoryGeneratorModular(ObjectGenerate obj) => '''
import 'package:dio/native_imp.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'interfaces/${ReCase(obj.name).snakeCase}_repository_interface.dart';

part '${ReCase(obj.name).snakeCase}_${obj.type}.g.dart';

@Injectable()
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
String extendsInterfaceRepositoryGeneratorWithHasura(ObjectGenerate obj) => '''
import 'package:dio/native_imp.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'interfaces/${ReCase(obj.name).snakeCase}_repository_interface.dart';

class ${obj.name}Repository implements I${obj.name}Repository {

  Future fetchPost(HasuraConnect client) async {
    String docQuery = """
      query {
        posts {
          id
          userId
          title
          body
        }
      }
    """;

    final response =
        await client.query(docQuery);

    return response;
  }

  //dispose will be called automatically
  @override
  void dispose() {
    
  }

}
  ''';


String extendsInterfaceRepositoryGenerator(ObjectGenerate obj) => '''
import 'package:dio/native_imp.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
