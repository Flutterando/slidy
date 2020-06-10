import 'package:slidy/slidy.dart';
import 'package:slidy/src/modules/localization.dart';

class LocalizationCommand extends CommandBase {
  @override
  final String name = 'localization';

  @override
  final String description = 'automatically creates translation files';

  @override
  String get invocationSuffix => '<project name>';

  @override
  void run() {
    runCommand();
  }
}
