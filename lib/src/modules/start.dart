import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:slidy/src/command/generate_command.dart';
import 'package:slidy/src/templates/templates.dart' as templates;
import 'package:slidy/src/utils/file_utils.dart';
import 'package:slidy/src/utils/output_utils.dart' as output;
import 'package:slidy/src/utils/utils.dart';

import 'package:slidy/src/modules/install.dart';

start(hasForce) async {
  var dir = Directory("lib");
  if (dir.listSync().isNotEmpty) {
    if (hasForce) {
      output.msg("Removing lib folder");
      await dir.delete(recursive: true);
    } else {
      output.error("The lib folder must be empty");
      exit(1);
    }
  }

  output.msg("Starting a new project");

  String package = await getNamePackage();

  createStaticFile('${dir.path}/main.dart', templates.startMain(package));

  createStaticFile(
      libPath('app_module.dart'), templates.startAppModule(package));

  createStaticFile(libPath('app_bloc.dart'), templates.startAppBloc());

  createStaticFile(
      libPath('app_widget.dart'), templates.startAppWidget(package));

  var command =
      CommandRunner("slidy", "CLI package manager and template for Flutter.");
  command.addCommand(GenerateCommand());
  await command.run(['generate', 'module', 'home/home', '-c']);

  await install(["bloc_pattern", "rxdart", "dio"], false);

  output.msg("Project started! enjoy!");
}
