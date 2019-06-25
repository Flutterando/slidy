import 'package:slidy/src/package_manager.dart';
import 'package:slidy/src/utils/utils.dart';

void uninstall(args) => PackageManager().uninstall(args, checkParam(args, "--dev"));