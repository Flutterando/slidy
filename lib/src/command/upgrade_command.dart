import 'package:slidy/slidy.dart';

class UpgradeCommand extends CommandBase {
  final name = "upgrade";
  final description = "Upgrade the Slidy version";

  void run() {
    upgrade();
  }
}
