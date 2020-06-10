import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class GenerateWidgetSubCommand extends CommandBase {
  @override
  String get name => 'widget';
  @override
  String get description => 'Creates a widget';

  GenerateWidgetSubCommand() {
    argParser.addFlag('bloc',
        abbr: 'b',
        negatable: false,
        help: 'Creates a widget without Bloc file');
    argParser.addFlag('suffix',
        abbr: 's',
        negatable: false,
        help: 'Creates a widget without a \"Widget\" suffix.');
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
      Generate.widget(
        path: argResults.rest.first,
        blocLess: argResults['bloc'],
        ignoreSuffix: argResults['suffix'],
        flutter_bloc: argResults['flutter_bloc'],
        mobx: argResults['mobx'],
      );
    }
  }
}

class GenerateWidgetAbbrSubCommand extends GenerateWidgetSubCommand {
  @override
  String get name => 'w';
}
