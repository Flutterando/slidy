import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/modules/package_manager/domain/usecases/versions.dart';

import '../../../core/command/command_base.dart';
import '../domain/params/package_name.dart';

class VersionsCommand extends CommandBase {
  final versions = Modular.get<Versions>();

  @override
  final name = 'versions';

  @override
  final description = 'get lastest version of package';

  @override
  FutureOr run() async {
    if (argResults?.rest.isEmpty == true) {
      throw UsageException('value not passed for a module command', usage);
    } else {
      for (var pack in argResults!.rest) {
        final package = PackageName(pack, isDev: false);
        final result = await versions.call(package).run();
        execute(result);
      }
    }
  }

  @override
  String? get invocationSuffix => null;
}

class VersionsCommandAbbr extends VersionsCommand {
  @override
  final name = 'vs';
}
