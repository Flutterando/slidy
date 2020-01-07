import 'dart:io';

import 'package:slidy/slidy.dart';
import 'package:slidy/src/utils/utils.dart' show mainDirectory;
import 'package:tuple/tuple.dart';

import '../utils/utils.dart';

void create(String projectName, String projectDescription, String projectOrg,
    bool isKotlin, bool isSwift, bool isAndroidX) {
  startFlutterCreate(projectName, projectDescription, projectOrg, isKotlin,
      isSwift, isAndroidX);
}

void startFlutterCreate(String projectName, String projectDescription,
    String projectOrg, bool isKotlin, bool isSwift, bool isAndroidX) {
  
  mainDirectory = projectName+'/';
    

  var selectedProvider = blocOrModular(null, projectName);
  var selectedBloc = selecStateManagement(null, projectName);

  List<String> flutterArgs = createFlutterArgs(projectName, projectDescription,
      projectOrg, isKotlin, isSwift, isAndroidX);

  Process.start("flutter", flutterArgs, runInShell: true).then((process) {
    stdout.addStream(process.stdout);
    stderr.addStream(process.stderr);
    process.exitCode.then((exit) {
      if (exit == 0) {
        startSlidyCreate(projectName, selectedProvider, selectedBloc);
      }
    });
  });
}

void startSlidyCreate(String projectName, Function selectedProvider, Function selectedState) {
  start(false, true, Directory('$projectName/lib'), Tuple2(selectedProvider, selectedState));
}

List<String> createFlutterArgs(String projectName, String projectDescription,
    String projectOrg, bool isKotlin, bool isSwift, bool isAndroidX) {
  projectDescription = projectDescription == null
      ? "A new Flutter project. Created by Slidy"
      : projectDescription;
  projectOrg = projectOrg == null ? "com.example" : projectOrg;

  var flutterArgs = ["create"];
  flutterArgs.add("--no-pub");

  if (isKotlin) {
    flutterArgs.add("-a");
    flutterArgs.add("kotlin");
  }

  if (isSwift) {
    flutterArgs.add("-i");
    flutterArgs.add("swift");
  }

  if (isAndroidX) {
    flutterArgs.add("--androidx");
  }

  flutterArgs.add("--project-name");
  flutterArgs.add("$projectName");

  if (projectDescription.isNotEmpty) {
    flutterArgs.add("--description");
    flutterArgs.add("'$projectDescription'");
  }

  if (projectOrg.isNotEmpty) {
    flutterArgs.add("--org");
    flutterArgs.add("$projectOrg");
  }

  flutterArgs.add(projectName);
  return flutterArgs;
}
