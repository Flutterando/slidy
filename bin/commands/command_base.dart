import 'package:args/command_runner.dart';

abstract class CommandBase extends Command {
  String? get invocationSuffix;
  @override
  String get invocation {
    return invocationSuffix != null && invocationSuffix?.isNotEmpty == true ? '${super.invocation} $invocationSuffix' : '${super.invocation}';
  }

  @override
  String get description;

  @override
  String get name;
}
