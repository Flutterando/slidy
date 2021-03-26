import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:slidy/di/injection.dart';
import 'package:slidy/src/core/entities/slidy_process.dart';
import 'package:slidy/src/core/interfaces/pubspec_service.dart';
import 'package:slidy/src/core/models/pubspec.dart';
import 'package:slidy/src/main_module.dart';
import 'package:slidy/src/modules/package_instalation/domain/models/package_name.dart';
import 'package:slidy/src/modules/package_instalation/main/package_instalation.dart';
import 'package:test/test.dart';

import '../external/external_json_result.dart';

class ClientMock extends Mock implements Client {}

class PubspecServiceMock extends Mock implements PubspecService {}

void main() {
  setUpAll(() {
    registerFallbackValue<Uri>(Uri());
    registerFallbackValue<Line>(Line(name: '', value: null));
  });

  StartAllModules();
  final main = PackageInstalation();
  final client = ClientMock();
  final pubspecService = PubspecServiceMock();

  sl.changeRegister<Client>((i) => client);
  sl.changeRegister<PubspecService>((i) => pubspecService);

  test('install', () async {
    when(() => client.get(any())).thenAnswer((_) async => Response(jsonPackageResult, 200));
    when(() => pubspecService.add(any())).thenAnswer((_) async => true);
    final result = await main.install(package: PackageName('package'));
    expect(result.right, isA<SlidyProccess>());
  });

  test('uninstall', () async {
    when(() => pubspecService.replace(any())).thenAnswer((_) async => true);
    when(() => pubspecService.getLine(any())).thenAnswer((_) async => Line(name: 'dependencies', value: LineMap({'package': Line(name: 'name', value: 'value')})));
    final result = await main.uninstall(package: PackageName('package'));
    expect(result.right, isA<SlidyProccess>());
  });
}
