import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class GenerateBlocSubCommand extends CommandBase {
  @override
  final name = 'bloc';
  @override
  final description = 'Creates a bloc';

  GenerateBlocSubCommand() {
    argParser.addFlag('notest',
        abbr: 'n', negatable: false, help: 'no create file test'
        //Add in future configured the release android sign
        );
    argParser.addFlag('flutter_bloc',
        abbr: 'f', negatable: true, help: 'using flutter_bloc package'
        //Add in future configured the release android sign
        );
    argParser.addFlag('mobx',
        abbr: 'm', negatable: true, help: 'using mobx package'
        //Add in future configured the release android sign
        );
  }
  @override
  void run() {
    if (argResults.rest.isEmpty) {
      throw UsageException('value not passed for a module command', usage);
    } else {
      Generate.bloc(argResults.rest.first, 'bloc', !argResults['notest'],
          argResults['flutter_bloc'], argResults['mobx']);
    }
  }
}

class GenerateBlocAbbrSubCommand extends GenerateBlocSubCommand {
  @override
  final name = 'b';
}
