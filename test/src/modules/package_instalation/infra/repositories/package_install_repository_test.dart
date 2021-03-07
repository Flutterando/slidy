import 'package:mocktail/mocktail.dart';
import 'package:slidy/src/core/entities/slidy_process.dart';
import 'package:slidy/src/core/interfaces/pubspec_service.dart';
import 'package:slidy/src/core/models/pubspec.dart';
import 'package:slidy/src/modules/package_instalation/domain/models/package_name.dart';
import 'package:slidy/src/modules/package_instalation/infra/datasources/get_package_version.dart';
import 'package:slidy/src/modules/package_instalation/infra/repositories/package_instalation_repository.dart';
import 'package:test/test.dart';

class PubspecServiceMock extends Mock implements PubspecService {}

class GetPackageVersionMock extends Mock implements GetPackageVersion {}

void main() {
  final pubspecService = PubspecServiceMock();
  final client = GetPackageVersionMock();

  final service = PackageInstalationRepositoryImpl(pubspec: pubspecService, client: client);

  test('should install package', () async {
    when(pubspecService).calls(#add).thenAnswer((_) async => true);
    when(client).calls(#fetch).thenAnswer((_) async => '1.0.0');
    final result = await service.install(PackageName('package'));
    expect(result.right, isA<SlidyProccess>());
  });

  test('should install package with version', () async {
    when(pubspecService).calls(#add).thenAnswer((_) async => true);
    final result = await service.install(PackageName('package@1.0.2'));
    expect(result.right, isA<SlidyProccess>());
  });

  test('should uninstall package', () async {
    when(pubspecService).calls(#replace).thenAnswer((_) async => true);
    when(pubspecService).calls(#getLine).thenAnswer((_) async => Line(name: 'dependencies', value: LineMap({'package': Line(name: 'name', value: 'value')})));
    final result = await service.uninstall(PackageName('package'));
    expect(result.right, isA<SlidyProccess>());
  });
}
