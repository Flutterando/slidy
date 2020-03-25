import 'package:args/command_runner.dart';

class CommandBase extends Command {
  String invocationSuffix;
  @override
  String get invocation {
    return invocationSuffix != null && invocationSuffix.isNotEmpty
        ? '${super.invocation} $invocationSuffix'
        : '${super.invocation}';
  }

  @override
  String get description => null;

  @override
  String get name => null;
}
