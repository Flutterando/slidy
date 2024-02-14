import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:io/io.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/main_module.dart';
import 'package:slidy/src/version.dart';

Future<void> main(List<String> arguments) async {
  Modular.init(MainModule());
  final runner = configureCommand(arguments);

  var hasCommand = runner.commands.keys.any((x) => arguments.contains(x));

  if (hasCommand) {
    try {
      await executeCommand(runner, arguments);
      exit(ExitCode.success.code);
    } on UsageException catch (error) {
      print(error);
      exit(ExitCode.ioError.code);
    } finally {
      Modular.dispose();
    }
  } else {
    var parser = ArgParser();
    parser = runner.argParser;
    var results = parser.parse(arguments);
    executeOptions(results, arguments, runner);
    Modular.dispose();
  }
}

void executeOptions(ArgResults results, List<String> arguments, CommandRunner runner) {
  if (results.wasParsed('help') || arguments.isEmpty) {
    print(runner.usage);
  } else if (results.wasParsed('version')) {
    version();
  } else {
    print('Command not found!\n');
    print(runner.usage);
  }
}

Future<void> executeCommand(CommandRunner runner, List<String> arguments) {
  return runner.run(arguments);
}

CommandRunner configureCommand(List<String> arguments) {
  var runner = CommandRunner('slidy', 'CLI package manager and template for Flutter.')
    ..addCommand(InstallCommand())
    ..addCommand(InstallCommandAbbr())
    ..addCommand(UninstallCommand())
    ..addCommand(VersionsCommand())
    ..addCommand(FindCommand())
    ..addCommand(StartCommand())
    ..addCommand(GenerateCommand())
    ..addCommand(GenerateCommandAbbr())
    ..addCommand(RunCommand());
  //   ..addCommand(UpgradeCommand());

  runner.argParser.addFlag('version', abbr: 'v', negatable: false);
  return runner;
}

void version() async {
  //String version = await getVersion();
  //String version = '0.0.13';
  print('''
███████╗██╗     ██╗██████╗ ██╗   ██╗     ██████╗██╗     ██╗
██╔════╝██║     ██║██╔══██╗╚██╗ ██╔╝    ██╔════╝██║     ██║
███████╗██║     ██║██║  ██║ ╚████╔╝     ██║     ██║     ██║
╚════██║██║     ██║██║  ██║  ╚██╔╝      ██║     ██║     ██║
███████║███████╗██║██████╔╝   ██║       ╚██████╗███████╗██║
╚══════╝╚══════╝╚═╝╚═════╝    ╚═╝        ╚═════╝╚══════╝╚═╝                                             
''');
  print('CLI package manager and template for Flutter');
  print('');
  print('Slidy version: $packageVersion');
}
