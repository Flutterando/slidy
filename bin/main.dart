import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/command/revert.dart';
import 'package:slidy/src/command/run_command.dart';

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

void executeOptions(
    ArgResults results, List<String> arguments, CommandRunner runner) {
  if (results.wasParsed('help') || arguments.isEmpty) {
    print(runner.usage);
  }

  if (results.wasParsed('version')) {
    version('2.2.1');
  }
}

void executeCommand(CommandRunner runner, List<String> arguments) {
  runner.run(arguments).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
  });
}

CommandRunner configureCommand(List<String> arguments) {
  var runner =
      CommandRunner('slidy', 'CLI package manager and template for Flutter.')
        ..addCommand(StartCommand())
        ..addCommand(RunCommand())
        ..addCommand(GenerateCommand())
        ..addCommand(GenerateCommandAbbr())
        ..addCommand(UpdateCommand())
        ..addCommand(UpgradeCommand())
        ..addCommand(InstallCommand())
        ..addCommand(InstallCommandAbbr())
        ..addCommand(UninstallCommand())
        ..addCommand(CreateCommand())
        ..addCommand(RevertCommand())
        ..addCommand(LocalizationCommand());

  runner.argParser.addFlag('version', abbr: 'v', negatable: false);
  return runner;
}
