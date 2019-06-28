import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

class GenerateRepositorySubCommand extends Command {
  final name = "repository";
  final description = "Creates a repository";

  void run() {
    if (argResults.rest.isEmpty) {
      throw new UsageException("value not passed for a module command", usage);
    } else {
      Generate.repository(argResults.rest.first);
    }
  }
}

class GenerateRepositoryAbbrSubCommand extends GenerateRepositorySubCommand {
  final name = "r";
}