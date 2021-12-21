import 'package:mocktail/mocktail.dart';
import 'package:slidy/src/core/entities/slidy_process.dart';
import 'package:slidy/src/core/interfaces/yaml_service.dart';
import 'package:slidy/src/modules/package_instalation/domain/models/package_name.dart';
import 'package:slidy/src/modules/package_instalation/infra/datasources/get_package_version.dart';
import 'package:slidy/src/modules/package_instalation/infra/repositories/package_instalation_repository.dart';
import 'package:test/test.dart';

class YamlServiceMock extends Mock implements YamlService {
  @override
  void update(List<String> path, String value) {}
}

class GetPackageVersionMock extends Mock implements GetPackageVersion {}

void main() {
  setUpAll(() {});
  final pubspecService = YamlServiceMock();
  final client = GetPackageVersionMock();

  final service =
      PackageInstalationRepositoryImpl(pubspec: pubspecService, client: client);

  test('should install package', () async {
    when(() => pubspecService.save()).thenAnswer((_) async => true);
    when(() => client.fetch(any())).thenAnswer((_) async => '1.0.0');
    final result = await service.install(PackageName('package'));
    expect(result.isRight(), true);
  });

  test('should install package with version', () async {
    when(() => pubspecService.save()).thenAnswer((_) async => true);
    final result = await service.install(PackageName('package@1.0.2'));
    expect(result.isRight(), true);
  });

  test('should uninstall package', () async {
    when(() => pubspecService.save()).thenAnswer((_) async => true);
    when(() => pubspecService.remove(any())).thenReturn(true);
    final result = await service.uninstall(PackageName('package'));
    expect(result.isRight(), true);
  });
}
