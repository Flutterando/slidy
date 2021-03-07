import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:slidy/slidy.dart';

import '../../prints/prints.dart';
import '../../templates/module.dart';
import '../command_base.dart';

class GenerateModuleSubCommand extends CommandBase {
  @override
  final name = 'module';

  @override
  final description = 'Creates a module';

  GenerateModuleSubCommand() {
    //  argParser.addFlag('complete', abbr: 'c', negatable: false, help: 'Creates a module with Page and Controller/Bloc files');
  }

  @override
  FutureOr run() async {
    if (argResults?.rest.isNotEmpty == false) {
      throw UsageException('value not passed for a module command', usage);
    }
    final fileName = File(argResults?.rest.first ?? '').uri.pathSegments.last;
    final file = File('${Directory.current.path}/lib/app/${argResults?.rest.first}/${fileName}_module.dart');
    final result = await Slidy.instance.template.createFile(info: TemplateInfo(key: 'module', destiny: file, yaml: generateFile));
    execute(result);
  }

  @override
  String? get invocationSuffix => null;
}

class GenerateModuleAbbrSubCommand extends GenerateModuleSubCommand {
  @override
  final name = 'm';
}
