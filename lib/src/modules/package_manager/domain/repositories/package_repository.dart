import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/errors.dart';
import '../params/package_name.dart';

abstract class PackageRepository {
  TaskEither<SlidyError, List<String>> getVersions(String packageName);
  TaskEither<SlidyError, PackageName> putPackage(PackageName package);
  TaskEither<SlidyError, PackageName> removePackage(PackageName package);
}
