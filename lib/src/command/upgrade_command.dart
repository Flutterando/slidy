import 'package:slidy/slidy.dart';

class UpgradeCommand extends CommandBase {
  @override
  String get name => 'upgrade';
  @override
  String get description => 'Upgrade the Slidy version';

  @override
  void run() {
    upgrade();
  }
}
