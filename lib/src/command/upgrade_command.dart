import 'package:slidy/slidy.dart';

class UpgradeCommand extends CommandBase {
  @override
  final name = 'upgrade';
  @override
  final description = 'Upgrade the Slidy version';

  @override
  void run() {
    upgrade();
  }
}
