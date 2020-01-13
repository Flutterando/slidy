import 'package:slidy/slidy.dart';

class StartCommand extends CommandBase {
  final name = "start";
  bool argsLength(int n) => argResults.arguments.length > n; 
  final description =
      "Create a basic structure for your project (confirm that you have no data in the \"lib\" folder).";

  StartCommand() {
   argParser.addFlag('complete',
        abbr: 'c',
        negatable: false,
        help:
            'Create a complete flutter project with Themes separated of main.dart, named Routes and locales Strings configured'
        //Add in future configured the release android sign
        );

  argParser.addOption('providerSystem',
      abbr: 'p',
      help:
          'Create a flutter project using an specified provider system. Options: flutter_modular / bloc_pattern'
      //Add in future configured the release android sign
      );

  argParser.addOption('stateManagement',
      abbr: 's',
      help:
          'Create a flutter project using an specified state management. Options: mobx / flutter_bloc / rxdart'
      //Add in future configured the release android sign
      );
  }

  @override
  void run() {
    start(completeStart: argResults['complete'], providerSystem: argResults['providerSystem'], stateManagement: argResults['stateManagement']);
  }
}
