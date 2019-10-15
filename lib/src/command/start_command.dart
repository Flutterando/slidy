import 'package:slidy/slidy.dart';

class StartCommand extends CommandBase {
  final name = "start";
  final description =
      "Create a basic structure for your project (confirm that you have no data in the \"lib\" folder).";

  StartCommand() {
    argParser.addFlag('force',
        abbr: 'f',
        negatable: false,
        help:
            "Remove the \"lib\" folder and all files before create the structure");
    argParser.addFlag('complete',
        abbr: 'c',
        negatable: false,
        help:
            'Create a complete flutter project with Themes separated of main.dart, named Routes and locales Strings configured'
        //Add in future configured the release android sign
        );
  }

  void run() {
    start(argResults["force"], argResults['complete']);
  }
}
