import 'package:slidy/src/package_manager.dart';
import 'package:slidy/src/utils/utils.dart';

void unistall(args) => PackageManager().uninstall(args, checkParam(args, "--dev"));