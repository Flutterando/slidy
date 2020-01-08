String repositoryTestGenerator(String name, String packageName, String import,
        String module, String pathModule) =>
    '''
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import 'package:${packageName}/${import.replaceFirst("lib/", "").replaceAll("\\", "/")}';

class MockClient extends Mock implements Dio {}

void main() {
  ${name}Repository repository;
  MockClient client;

  setUp(() {
    repository = ${name}Repository();
    client = MockClient();
  });

  group('${name}Repository Test', () {
    test("First Test", () {
      expect(repository, isInstanceOf<${name}Repository>());
    });

    test('returns a Post if the http call completes successfully', () async {
      when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
          .thenAnswer((_) async =>
              Response(data: {'title': 'Test'}, statusCode: 200));
      Map<String, dynamic> data = await repository.fetchPost(client);
      expect(data['title'], 'Test');
    });

  });
}
  ''';
