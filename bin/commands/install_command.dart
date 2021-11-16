import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:io/io.dart';
import 'package:slidy/slidy.dart';

import 'package:slidy/src/core/prints/prints.dart';
import 'command_base.dart';

class InstallCommand extends CommandBase {
  @override
  final name = 'install';

  @override
  final description = 'Install (or update) a new package or packages:';

  InstallCommand() {
    argParser.addFlag('dev',
        negatable: false,
        help: 'Install (or update) a package in a dev dependency');
  }

  @override
  FutureOr run() async {
    if (argResults?.rest.isEmpty == true) {
      throw UsageException('value not passed for a module command', usage);
    } else {
      for (var pack in argResults!.rest) {
        final result = await Slidy.instance.instalation.install(
            package: PackageName(pack, isDev: argResults?['dev'] == true));
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
