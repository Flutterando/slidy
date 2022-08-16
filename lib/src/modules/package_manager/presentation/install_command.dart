import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/modules/package_manager/domain/usecases/install.dart';

import '../../../core/command/command_base.dart';

class InstallCommand extends CommandBase {
  final install = Slidy.instance.get<Install>();

  @override
  final name = 'install';

  @override
  final description = 'Install (or update) a new package or packages:';

  InstallCommand() {
    argParser.addFlag('dev', negatable: false, help: 'Install (or update) a package in a dev dependency');
  }

  @override
  FutureOr run() async {
    if (argResults?.rest.isEmpty == true) {
      throw UsageException('value not passed for a module command', usage);
    } else {
      for (var pack in argResults!.rest) {
        final package = PackageName(pack, isDev: argResults?['dev'] == true);
        final result = await install.call(package).run();
        execute(result);
      }
    }
  }

  @override
  String? get invocationSuffix => null;
}

class InstallCommandAbbr extends InstallCommand {
  @override
  final name = 'i';
}
