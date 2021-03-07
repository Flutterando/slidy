import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

import '../prints/prints.dart';
import 'command_base.dart';

class UninstallCommand extends CommandBase {
  @override
  final name = 'uninstall';
  @override
  final description = 'Remove a package';

  UninstallCommand() {
    argParser.addFlag('dev', negatable: false, help: 'Remove a package in a dev dependency');
  }

  @override
  FutureOr run() async {
    if (argResults?.rest.isEmpty == true) {
      throw UsageException('value not passed for a module command', usage);
    } else {
      for (var pack in argResults!.rest) {
        final result = await Slidy.instance.instalation.uninstall(package: PackageName(pack, isDev: argResults?['dev'] == true));
        execute(result);
      }
    }
  }

  @override
  String? get invocationSuffix => null;
}
