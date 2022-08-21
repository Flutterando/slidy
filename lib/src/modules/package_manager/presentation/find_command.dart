import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/modules/package_manager/domain/usecases/find.dart';

import '../../../core/command/command_base.dart';

class FindCommand extends CommandBase {
  final find = Modular.get<Find>();

  @override
  final name = 'find';

  @override
  final description = 'Find package';

  @override
  FutureOr run() async {
    if (argResults?.rest.isEmpty == true) {
      throw UsageException('value not passed for a module command', usage);
    } else {
      for (var pack in argResults!.rest) {
        final result = await find.call(pack).run();
        execute(result);
        break;
      }
    }
  }

  @override
  String? get invocationSuffix => null;
}

class FindCommandAbbr extends FindCommand {
  @override
  final name = 'f';
}
