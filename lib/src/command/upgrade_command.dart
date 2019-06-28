import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class UpgradeCommand extends Command {
  final name = "upgrade";
  final description =
      "Upgrade the Slidy version";

  void run() {
      upgrade();
  }
}
