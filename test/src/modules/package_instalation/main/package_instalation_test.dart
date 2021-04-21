import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:slidy/di/injection.dart';
import 'package:slidy/src/core/entities/slidy_process.dart';
import 'package:slidy/src/core/interfaces/yaml_service.dart';

import 'package:slidy/src/main_module.dart';
import 'package:slidy/src/modules/package_instalation/domain/models/package_name.dart';
import 'package:slidy/src/modules/package_instalation/main/package_instalation.dart';
import 'package:test/test.dart';

import '../external/external_json_result.dart';

class ClientMock extends Mock implements Client {}

class YamlServiceMock extends Mock implements YamlService {
  @override
  void update(List<String> path, String value) {}
}

void main() {
  setUpAll(() {
    registerFallbackValue<Uri>(Uri());
  });

  StartAllModules();
  final main = PackageInstalation();
  final client = ClientMock();
  final pubspecService = YamlServiceMock();

  sl.changeRegister<Client>((i) => client);
  sl.changeRegister<YamlService>((i) => pubspecService);

  test('install', () async {
    when(() => client.get(any())).thenAnswer((_) async => Response(jsonPackageResult, 200));
    when(() => pubspecService.save()).thenAnswer((_) async => true);
    final result = await main.install(package: PackageName('package'));
    expect(result.right, isA<SlidyProccess>());
  });

  test('uninstall', () async {
    when(() => pubspecService.remove(any())).thenReturn(true);
    when(() => pubspecService.save()).thenAnswer((_) async => true);
    final result = await main.uninstall(package: PackageName('package'));
    expect(result.right, isA<SlidyProccess>());
  });
}
