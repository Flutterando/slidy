import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class GenerateControllerSubCommand extends CommandBase {
  @override
  final name = 'controller';
  @override
  final description = 'Creates a controller';

  GenerateControllerSubCommand() {
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
      Generate.bloc(argResults.rest.first, 'controller', !argResults['notest'],
          argResults['flutter_bloc'], argResults['mobx']);
    }
  }
}

class GenerateControllerAbbrSubCommand extends GenerateControllerSubCommand {
  @override
  final name = 'c';
}
