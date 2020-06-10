import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class InstallCommand extends CommandBase {
  @override
  final String name = 'install';
  @override
  final String description = 'Install (or update) a new package or packages:';

  InstallCommand() {
    argParser.addFlag('dev',
        negatable: false,
        help: 'Install (or update) a package in a dev dependency');
  }

  @override
  void run() {
    if (argResults.rest.isEmpty) {
      throw UsageException('value not passed for a module command', usage);
    } else {
      install(packs: argResults.rest, isDev: argResults['dev']);
    }
  }
}

class InstallCommandAbbr extends InstallCommand {
  @override
  String get name => 'i';
}
