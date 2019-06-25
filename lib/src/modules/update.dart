import 'package:slidy/src/utils/utils.dart';
import '../package_manager.dart';

void update (args) => PackageManager().update(args, checkParam(args, "--dev"));