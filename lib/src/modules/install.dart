import 'package:slidy/src/package_manager.dart';
import 'package:slidy/src/utils/utils.dart';

void install(args) => PackageManager().install(args, checkParam(args, "--dev"));