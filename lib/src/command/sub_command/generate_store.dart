import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class GenerateStoreSubCommand extends CommandBase {
  final name = "store";
  final description = "Creates a Store";

  GenerateStoreSubCommand() {
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

  void run() {
    if (argResults.rest.isEmpty) {
      throw UsageException("value not passed for a module command", usage);
    } else {
      Generate.bloc(argResults.rest.first, 'store', !argResults["notest"],
          argResults["flutter_bloc"], argResults["mobx"]);
    }
  }
}

class GenerateStoreAbbrSubCommand extends GenerateStoreSubCommand {
  final name = "ss";
}
