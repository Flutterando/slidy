import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:slidy/src/modules/package_instalation/domain/errors/errors.dart';

import 'package:slidy/src/modules/package_instalation/external/get_package_version.dart';
import 'package:test/test.dart';

import 'external_json_result.dart';

class ClientMock extends Mock implements Client {}

void main() {
  setUpAll(() {
    registerFallbackValue<Uri>(Uri());
  });

  final client = ClientMock();

  final datasource = GetPackageVersionImpl(client);

  test('should install package', () async {
    when(() => client.get(any()))
        .thenAnswer((_) async => Response(jsonPackageResult, 200));
    final result = await datasource.fetch('package');
    expect(result, '2.0.1');
  });
  test(' statusCode 404', () async {
    when(() => client.get(any())).thenAnswer((_) async => Response('', 404));
    expect(() async => await datasource.fetch('package'),
        throwsA(isA<PackageInstalationError>()));
  });

  test('Client http error', () async {
    when(() => client.get(any())).thenThrow(Exception('error'));
    expect(() async => await datasource.fetch('package'),
        throwsA(isA<PackageInstalationError>()));
  });
}
