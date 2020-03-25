import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class UpdateCommand extends CommandBase {
  @override
  final name = 'update';
  @override
  final description = 'Update a new package or packages.';

  UpdateCommand() {
    argParser.addFlag('dev',
        negatable: false, help: 'Update a package in a dev dependency');
  }
  @override
  void run() {
    if (argResults.rest.isEmpty) {
      throw UsageException('value not passed for a module command', usage);
    } else {
      update(argResults.rest, argResults['dev']);
    }
  }
}
