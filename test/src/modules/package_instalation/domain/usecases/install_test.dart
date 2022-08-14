import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:slidy/src/core/entities/slidy_process.dart';
import 'package:slidy/src/core/errors/errors.dart';
import 'package:slidy/src/modules/package_instalation/domain/errors/errors.dart';
import 'package:slidy/src/modules/package_instalation/domain/models/package_name.dart';
import 'package:slidy/src/modules/package_instalation/domain/repositories/package_instalation_repository.dart';
import 'package:slidy/src/modules/package_instalation/domain/usecases/install.dart';
import 'package:test/test.dart';

class PackageInstalationRepositoryMock extends Mock implements PackageInstalationRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue<PackageName>(PackageName(''));
  });
  final service = PackageInstalationRepositoryMock();

  final usecase = Install(service);

  test('should install package', () async {
    when(() => service.install(any())).thenAnswer((_) async => Right<SlidyError, SlidyProccess>(SlidyProccess(result: 'ok')));
    final result = await usecase(params: PackageName('package'));
    expect(result.isRight(), true);
  });

  test('install package error', () async {
    when(() => service.install(any())).thenAnswer((_) async => Left<SlidyError, SlidyProccess>(PackageInstalationError('Error')));
    final result = await usecase(params: PackageName('package'));
    expect(result.fold(id, id), isA<PackageInstalationError>());
  });
}
