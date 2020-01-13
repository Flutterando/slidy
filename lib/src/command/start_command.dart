import 'package:slidy/slidy.dart';

class StartCommand extends CommandBase {
  final name = "start";
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
  }

  @override
  void run() {
    start(completeStart: argResults['complete'], providerSystem: argResults.arguments[0], stateManagement: argResults.arguments[1]);
  }
}
