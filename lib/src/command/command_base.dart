import 'package:args/command_runner.dart';

class CommandBase extends Command {
  String invocationSufix;
  String get invocation {
    return invocationSufix != null && invocationSufix.isNotEmpty
        ? "${super.invocation} $invocationSufix"
        : "${super.invocation}";
  }

  @override
  String get description => null;

  @override
  String get name => null;
}
