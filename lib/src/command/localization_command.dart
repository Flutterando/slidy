import 'package:slidy/slidy.dart';
import 'package:slidy/src/modules/localization.dart';

class LocalizationCommand extends CommandBase {
  @override
  final name = 'localization';

  @override
  final description = 'automatically creates translation files';

  @override
  final invocationSuffix = '<project name>';

  @override
  void run() {
    runCommand();
  }
}
