import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class UninstallCommand extends CommandBase {
  @override
  String get name => 'uninstall';
  @override
  String get description => 'Remove a package';

  UninstallCommand() {
    argParser.addFlag('dev',
        negatable: false, help: 'Remove a package in a dev dependency');
  }
  @override
  void run() {
    if (argResults.rest.isEmpty) {
      throw UsageException('value not passed for a module command', usage);
    } else {
      uninstall(packs: argResults.rest, isDev: argResults['dev']);
    }
  }
}
