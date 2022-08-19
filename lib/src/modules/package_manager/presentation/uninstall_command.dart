import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

import '../../../core/command/command_base.dart';
import '../domain/params/package_name.dart';
import '../domain/usecases/uninstall.dart';

class UninstallCommand extends CommandBase {
  final install = Modular.get<Uninstall>();

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
        final package = PackageName(pack, isDev: argResults?['dev'] == true);
        final result = await install.call(package).run();
        execute(result);
      }
    }
  }

  @override
  String? get invocationSuffix => null;
}
