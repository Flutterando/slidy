import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class UninstallCommand extends Command {
  final name = "uninstall";
  final description =
      "Remove a package";

  UninstallCommand() {
        argParser.addFlag('dev',
        negatable: false,
        help:
            "Remove a package in a dev dependency");
  }

  void run() {
    if (argResults.rest.isEmpty) {
      throw new UsageException("value not passed for a module command", usage);
    } else {
      uninstall(argResults.rest, argResults["dev"]);
    }
  }
}
