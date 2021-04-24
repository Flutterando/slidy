import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import 'commands/generate_command.dart';
import 'commands/install_command.dart';
import 'commands/run_command.dart';
import 'commands/start_command.dart';
import 'commands/uninstall_command.dart';
import 'commands/upgrade_command.dart';

void main(List<String> arguments) {
  final runner = configureCommand(arguments);

  var hasCommand = runner.commands.keys.any((x) => arguments.contains(x));

  if (hasCommand) {
    executeCommand(runner, arguments);
  } else {
    var parser = ArgParser();
    parser = runner.argParser;
    var results = parser.parse(arguments);
    executeOptions(results, arguments, runner);
  }
}

void executeOptions(ArgResults results, List<String> arguments, CommandRunner runner) {
  if (results.wasParsed('help') || arguments.isEmpty) {
    print(runner.usage);
  } else if (results.wasParsed('version')) {
    version('3.2.0+1');
  } else {
    print('Command not found!\n');
    print(runner.usage);
  }
}

void executeCommand(CommandRunner runner, List<String> arguments) {
  runner.run(arguments).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
  });
}

CommandRunner configureCommand(List<String> arguments) {
  var runner = CommandRunner('slidy', 'CLI package manager and template for Flutter.')
    ..addCommand(InstallCommand())
    ..addCommand(InstallCommandAbbr())
    ..addCommand(UninstallCommand())
    ..addCommand(StartCommand())
    ..addCommand(GenerateCommand())
    ..addCommand(GenerateCommandAbbr())
    ..addCommand(RunCommand())
    ..addCommand(UpgradeCommand());

  runner.argParser.addFlag('version', abbr: 'v', negatable: false);
  return runner;
}

void version(String version) async {
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
  print('Slidy version: $version');
}
