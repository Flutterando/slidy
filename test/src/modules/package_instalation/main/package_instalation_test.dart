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
  StartAllModules();
  final main = PackageInstalation();
  final client = ClientMock();
  final pubspecService = PubspecServiceMock();

  sl.changeRegister<Client>((i) => client);
  sl.changeRegister<PubspecService>((i) => pubspecService);

  test('install', () async {
    when(client).calls(#get).thenAnswer((_) async => Response(jsonPackageResult, 200));
    when(pubspecService).calls(#add).thenAnswer((_) async => true);
    final result = await main.install(package: PackageName('package'));
    expect(result.right, isA<SlidyProccess>());
  });

  test('uninstall', () async {
    when(pubspecService).calls(#replace).thenAnswer((_) async => true);
    when(pubspecService).calls(#getLine).thenAnswer((_) async => Line(name: 'dependencies', value: LineMap({'package': Line(name: 'name', value: 'value')})));
    final result = await main.uninstall(package: PackageName('package'));
    expect(result.right, isA<SlidyProccess>());
  });
}
