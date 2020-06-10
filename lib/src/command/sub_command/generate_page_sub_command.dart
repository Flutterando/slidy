import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class GeneratePageSubCommand extends CommandBase {
  @override
  String get name => 'page';
  @override
  String get description => 'Creates a page';

  GeneratePageSubCommand() {
    argParser.addFlag('bloc',
        abbr: 'b', negatable: false, help: 'Creates a page without Bloc file');
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
      Generate.page(
        path: argResults.rest.first,
        blocLess: argResults['bloc'],
        flutter_bloc: argResults['flutter_bloc'],
        mobx: argResults['mobx'],
      );
    }
  }
}

class GeneratePageAbbrSubCommand extends GeneratePageSubCommand {
  @override
  String get name => 'p';
}
