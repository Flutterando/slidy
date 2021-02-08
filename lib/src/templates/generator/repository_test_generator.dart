import 'package:slidy/src/utils/object_generate.dart';

String repositoryTestGeneratorWithHasura(ObjectGenerate obj) => '''
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:${obj.packageName}/${obj.import.replaceFirst("lib/", "").replaceAll("\\", "/")}';

class MockClient extends Mock implements HasuraConnect {}

void main() {
  ${obj.name}Repository repository;
 // MockClient client;

  setUp(() {
  // repository = ${obj.name}Repository();
  // client = MockClient();
  });

  group('${obj.name}Repository Test', () {
 //  test("First Test", () {
 //    expect(repository, isInstanceOf<${obj.name}Repository>());
 //  });

   test('returns a Post if the http call completes successfully', () async {
 //    when(client.query(any))
 //        .thenAnswer((_) async =>
 //            Response(data: {'title': 'Test'}, statusCode: 200));
 //    Map<String, dynamic> data = await repository.fetchPost(client);
 //    expect(data['title'], 'Test');
   });

  });
}
  ''';

String repositoryTestGenerator(ObjectGenerate obj) => '''
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import 'package:${obj.packageName}/${obj.import.replaceFirst("lib/", "").replaceAll("\\", "/")}';

class MockClient extends Mock implements Dio {}

void main() {
  ${obj.name}Repository repository;
 // MockClient client;

  setUp(() {
  // repository = ${obj.name}Repository();
  // client = MockClient();
  });

  group('${obj.name}Repository Test', () {
 //  test("First Test", () {
 //    expect(repository, isInstanceOf<${obj.name}Repository>());
 //  });

   test('returns a Post if the http call completes successfully', () async {
 //    when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
 //        .thenAnswer((_) async =>
 //            Response(data: {'title': 'Test'}, statusCode: 200));
 //    Map<String, dynamic> data = await repository.fetchPost(client);
 //    expect(data['title'], 'Test');
   });

  });
}
  ''';

String repositoryTestGeneratorModular(ObjectGenerate obj) => '''
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/native_imp.dart';

import 'package:${obj.packageName}/${obj.import.replaceFirst("lib/", "").replaceAll("\\", "/")}';

class MockClient extends Mock implements DioForNative {}

void main() {
  ${obj.name}Repository repository;
  MockClient client;

  setUp(() {
    client = MockClient();
    repository = ${obj.name}Repository(client);
  });

  group('${obj.name}Repository Test', () {
     test("First Test", () {
      //  expect(repository, isInstanceOf<${obj.name}Repository>());
     });

    test('returns a Post if the http call completes successfully', () async {
        //  when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
        //      .thenAnswer((_) async =>
        //          Response(data: {'title': 'Test'}, statusCode: 200));
        //  Map<String, dynamic> data = await repository.fetchPost();
        //  expect(data['title'], 'Test');
    });
  });
}
  ''';

String interfaceRepositoryTestGenerator(ObjectGenerate obj) {
  var fileDart = obj.import.split('/').last;
  var import =
      '${obj.import.replaceFirst("lib/", "").replaceAll(fileDart, 'interfaces/')}${fileDart}';
  return '''
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

import 'package:${obj.packageName}/${obj.import.replaceFirst("lib/", "").replaceAll("\\", "/")}';
import 'package:${obj.packageName}/${import.replaceAll('.dart', '_interface.dart')}';



class MockClient extends Mock implements DioForNative {}

void main() {
  I${obj.name}Repository repository;
 // MockClient client;

  setUp(() {
  // repository = ${obj.name}Repository();
  // client = MockClient();
  });

  group('${obj.name}Repository Test', () {
 //  test("First Test", () {
 //    expect(repository, isInstanceOf<${obj.name}Repository>());
 //  });

   test('returns a Post if the http call completes successfully', () async {
 //    when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
 //        .thenAnswer((_) async =>
 //            Response(data: {'title': 'Test'}, statusCode: 200));
 //    Map<String, dynamic> data = await repository.fetchPost(client);
 //    expect(data['title'], 'Test');
   });

  });
}
''';
}

String interfaceRepositoryTestGeneratorModular(ObjectGenerate obj) {
  var fileDart = obj.import.split('/').last;
  var import =
      '${obj.import.replaceFirst("lib/", "").replaceAll(fileDart, 'interfaces/')}${fileDart}';
  return '''
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

import 'package:${obj.packageName}/${obj.import.replaceFirst("lib/", "").replaceAll("\\", "/")}';
import 'package:${obj.packageName}/${import.replaceAll('.dart', '_interface.dart')}';


class MockClient extends Mock implements DioForNative {}

void main() {
  I${obj.name}Repository repository;
 // MockClient client;

  setUp(() {
  // client = MockClient();
  // repository = ${obj.name}Repository(client);
  });

  group('${obj.name}Repository Test', () {
 //  test("First Test", () {
 //    expect(repository, isInstanceOf<${obj.name}Repository>());
 //  });

   test('returns a Post if the http call completes successfully', () async {
 //    when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
 //        .thenAnswer((_) async =>
 //            Response(data: {'title': 'Test'}, statusCode: 200));
 //    Map<String, dynamic> data = await repository.fetchPost();
 //    expect(data['title'], 'Test');
   });

  });
}
  ''';
}

String interfaceRepositoryTestGeneratorWithHasura(ObjectGenerate obj) {
  var fileDart = obj.import.split('/').last;
  var import =
      '${obj.import.replaceFirst("lib/", "").replaceAll(fileDart, 'interfaces/')}${fileDart}';
  return '''
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:hasura_connect/hasura_connect.dart';

import 'package:${obj.packageName}/${import.replaceAll('.dart', '_interface.dart')}';



class MockClient extends Mock implements HasuraConnect {}

void main() {
  I${obj.name}Repository repository;
 // MockClient client;

  setUp(() {
  // client = MockClient();
  // repository = ${obj.name}Repository(client);
  });

  group('${obj.name}Repository Test', () {
 //  test("First Test", () {
 //    expect(repository, isInstanceOf<${obj.name}Repository>());
 //  });

   test('returns a Post if the http call completes successfully', () async {
 //    when(client.query(any))
 //        .thenAnswer((_) async =>
 //            Response(data: {'title': 'Test'}, statusCode: 200));
 //    Map<String, dynamic> data = await repository.fetchPost(client);
 //    expect(data['title'], 'Test');
   });

  });
}
  ''';
}
