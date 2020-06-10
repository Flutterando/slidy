import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class CreateCommand extends CommandBase {
  @override
  final String name = 'create';
  @override
  final String description = 'Create a Flutter project with basic structure';
  @override
  String get invocationSuffix => '<project name>';

  CreateCommand() {
    argParser.addOption('description',
        abbr: 'd',
        help:
            'The description to use for your new Flutter project. This string ends up in the pubspec.yaml file. (defaults to \"A new Flutter project. Created by Slidy\")');

    argParser.addOption('org',
        abbr: 'o',
        help:
            'The organization responsible for your new Flutter project, in reverse domain name notation. This string is used in Java package names and as prefix in the iOS bundle identifier. (defaults to \"com.example\")');

    argParser.addOption('provider-system',
        abbr: 'p',
        allowed: ['flutter_modular', 'bloc_pattern'],
        help: 'Create a flutter project using an specified provider system.');

    argParser.addOption('state-management',
        abbr: 'm',
        allowed: ['mobx', 'flutter_bloc', 'rxdart'],
        help: 'Create a flutter project using an specified state management.');

    argParser.addFlag('kotlin',
        abbr: 'k', negatable: false, help: 'use kotlin in Android project');

    argParser.addFlag('swift',
        abbr: 's', negatable: false, help: 'use swift in ios project');

    argParser.addFlag('androidx',
        abbr: 'x', negatable: false, help: 'use androidx on android project');
  }

  @override
  void run() {
    if (argResults.rest.isEmpty) {
      throw UsageException(
          'project name not passed for a create command', usage);
    } else {
      /*
      
      */
      create(
        projectName: argResults.rest.first,
        projectDescription: argResults['description'],
        projectOrg: argResults['org'],
        isKotlin: argResults['kotlin'],
        isSwift: argResults['swift'],
        isAndroidX: argResults['androidx'],
        sm: argResults['state-management'],
        provider: argResults['provider-system'],
      );
    }
  }
}
