import 'package:slidy/src/utils/object_generate.dart';

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

String interfaceRepositoryTestGenerator(ObjectGenerate obj) => '''
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import 'package:${obj.packageName}/${obj.import.replaceFirst("lib/", "").replaceAll("\\", "/").replaceAll("_repository.dart", "_repository_interface.dart")}';

class MockClient extends Mock implements Dio {}

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
 //    Map<String, dynamic> data = await repository.fetchPost(client);
 //    expect(data['title'], 'Test');
   });

  });
}
  ''';
