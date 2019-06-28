import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class UpdateCommand extends Command {
  final name = "update";
  final description = "Update a new package or packages.";

  UpdateCommand() {
    argParser.addFlag('dev',
        negatable: false, help: "Update a package in a dev dependency");
  }

  void run() {
    if (argResults.rest.isEmpty) {
      throw new UsageException("value not passed for a module command", usage);
    } else {
      update(argResults.rest, argResults["dev"]);
    }
  }
}
