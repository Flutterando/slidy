import 'dart:io';

import 'package:slidy/src/templates/templates.dart' as templates;
import 'package:slidy/src/utils/output_utils.dart' as output;
import 'package:slidy/src/package_manager.dart';
import 'package:slidy/src/utils/utils.dart';

start(args) async {
  var dir = Directory("lib");
  if (dir.listSync().isNotEmpty) {
    output.error("The lib folder must be empty");
    exit(1);
  }

  String package = await getNamePackage();

  File(dir.path + "/main.dart")
    ..createSync()
    ..writeAsStringSync(templates.startMain(package));

  File(dir.path + "/src/app_module.dart")
    ..createSync(recursive: true)
    ..writeAsStringSync(templates.startAppModule(package));
  File(dir.path + "/src/app_bloc.dart")
    ..createSync(recursive: true)
    ..writeAsStringSync(templates.startAppBloc());
  File(dir.path + "/src/app_widget.dart")
    ..createSync(recursive: true)
    ..writeAsStringSync(templates.startAppWidget(package));
  await PackageManager().install(["install", "bloc_pattern", "rxdart", "dio"], false);
  output.success("Project started! enjoy!");
}