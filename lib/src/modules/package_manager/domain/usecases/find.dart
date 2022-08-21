import 'package:fpdart/fpdart.dart';
import 'package:slidy/slidy.dart';

import '../repositories/package_repository.dart';

abstract class Find {
  TaskEither<SlidyError, SlidyProccess> call(String packageName);
}

class FindImpl implements Find {
  final PackageRepository repository;

  FindImpl(this.repository);

  @override
  TaskEither<SlidyError, SlidyProccess> call(String packageName) {
    return TaskEither<SlidyError, String>.of(packageName) //
        .flatMap(repository.findPackage)
        .map(_finishProcess);
  }

  SlidyProccess _finishProcess(List<String> packages) {
    for (var element in packages) {
      print(element);
    }
    return SlidyProccess(result: '');
  }
}
