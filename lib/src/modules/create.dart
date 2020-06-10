import 'dart:io';

import 'package:meta/meta.dart';
import 'package:tuple/tuple.dart';

import 'package:slidy/slidy.dart';
import 'package:slidy/src/utils/utils.dart' show mainDirectory;

import '../utils/utils.dart';

const create = startFlutterCreate;

void startFlutterCreate({
  @required String projectName,
  @required String projectDescription,
  @required String projectOrg,
  @required bool isKotlin,
  @required bool isSwift,
  @required bool isAndroidX,
  @required String sm,
  @required String provider,
}) {
  mainDirectory = '$projectName/';

  Function selectedProvider;
  Function selectedBloc;

  if (provider == null) {
    selectedProvider = blocOrModular(null, projectName);
  } else {
    selectedProvider = blocOrModular(
        ['flutter_modular', 'bloc_pattern'].indexOf(provider), projectName);
  }

  if (sm == null) {
    selectedBloc = selecStateManagement(null, projectName);
  } else {
    selectedBloc = selecStateManagement(
        ['mobx', 'flutter_bloc', 'rxbloc'].indexOf(sm), projectName);
  }

  final flutterArgs = createFlutterArgs(
    projectName: projectName,
    projectDescription: projectDescription,
    projectOrg: projectOrg,
    isKotlin: isKotlin,
    isSwift: isSwift,
    isAndroidX: isAndroidX,
  );

  Process.start('flutter', flutterArgs, runInShell: true).then((process) {
    stdout.addStream(process.stdout);
    stderr.addStream(process.stderr);
    process.exitCode.then((exit) {
      if (exit == 0) {
        startSlidyCreate(projectName, selectedProvider, selectedBloc);
      }
    });
  });
}

void startSlidyCreate(
    String projectName, Function selectedProvider, Function selectedState) {
  start(
      completeStart: false,
      force: true,
      dir: Directory('$projectName/lib'),
      tuple: Tuple2(selectedProvider, selectedState));
}

List<String> createFlutterArgs({
  @required String projectName,
  String projectDescription = 'A new Flutter project. Created by Slidy',
  String projectOrg = 'com.example',
  @required bool isKotlin,
  @required bool isSwift,
  @required bool isAndroidX,
}) {
  final flutterArgs = ['create'];
  flutterArgs.add('--no-pub');

  if (isKotlin) {
    flutterArgs.add('-a');
    flutterArgs.add('kotlin');
  }

  if (isSwift) {
    flutterArgs.add('-i');
    flutterArgs.add('swift');
  }

  if (isAndroidX) {
    flutterArgs.add('--androidx');
  }

  flutterArgs.add('--project-name');
  flutterArgs.add('$projectName');

  if (projectDescription.isNotEmpty) {
    flutterArgs.add('--description');
    flutterArgs.add('$projectDescription');
  }

  if (projectOrg.isNotEmpty) {
    flutterArgs.add('--org');
    flutterArgs.add('$projectOrg');
  }

  flutterArgs.add(projectName);
  return flutterArgs;
}
