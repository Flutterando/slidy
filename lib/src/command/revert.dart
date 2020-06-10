import 'package:slidy/slidy.dart';
import 'package:slidy/src/utils/local_save_log.dart';

class RevertCommand extends CommandBase {
  @override
  final String name = 'revert';
  bool argsLength(int n) => argResults.arguments.length > n;
  @override
  final String description = 'Revert last command';

  @override
  void run() {
    LocalSaveLog().removeLastLog();
  }
}
