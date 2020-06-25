import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_console/dart_console.dart';
import 'package:slidy/src/command/generate_command.dart';
import 'package:slidy/src/modules/install.dart';
import 'package:slidy/src/templates/templates.dart' as templates;
import 'package:slidy/src/utils/file_utils.dart';
import 'package:slidy/src/utils/local_save_log.dart';
import 'package:slidy/src/utils/output_utils.dart' as output;
import 'package:slidy/src/utils/utils.dart';
import 'package:tuple/tuple.dart';

// bool _isContinue() {
//   var result = stdin.readLineSync();
//   if (result.toUpperCase() == 'Y') {
//     return true;
//   } else {
//     return false;
//   }
// }

Map<String, int> providerSystemOptions = {
  'flutter_modular': 0,
  'bloc_pattern': 1
};

Map<String, int> stateManagementOptions = {
  'mobx': 0,
  'flutter_bloc': 1,
  'rxdart': 2
};

int stateCLIOptions(String title, List<String> options) {
  stdin.echoMode = false;
  stdin.lineMode = false;
  var console = Console();
  var isRunning = true;
  var selected = 0;

  while (isRunning) {
    print('\x1B[2J\x1B[0;0H');
    output.title('Slidy CLI Interative\n');
    output.warn(title);
    for (var i = 0; i < options.length; i++) {
      if (selected == i) {
        print(output.green(options[i]));
      } else {
        print(output.white(options[i]));
      }
    }

    print('\nUse ↑↓ (keyboard arrows)');
    print('Press \'q\' to quit.');

    var key = console.readKey();

    if (key.controlChar == ControlCharacter.arrowDown) {
      if (selected < options.length - 1) {
        selected++;
      }
    } else if (key.controlChar == ControlCharacter.arrowUp) {
      if (selected > 0) {
        selected--;
      }
    } else if (key.controlChar == ControlCharacter.enter) {
      isRunning = false;
      return selected;
    } else if (key.char == 'q') {
      return -1;
    } else {}
  }
  return -1;
}

Function blocOrModular([int selected, String directory]) {
  selected ??= stateCLIOptions('What Provider System do you want to use?', [
    'flutter_modular (default)',
    'bloc_pattern',
  ]);

  if (selected == -1) {
    exit(1);
  }

  return () async {
    await removeAllPackages(directory);
    if (selected == 0) {
      output.msg('Instaling flutter_modular...');
      await install(['flutter_modular'], false, directory: directory);
    } else if (selected == 1) {
      output.msg('Instaling bloc_pattern...');
      await install(['bloc_pattern'], false, directory: directory);
    } else {
      exit(1);
    }
  };
}

void generateScript({String directory}) async {
  final yaml =
      File(directory == null ? 'pubspec.yaml' : '$directory/pubspec.yaml');

  if (!(await yaml.exists())) {
    return output
        .warn('Not found pubspec.yaml. Try to add the scripts manually');
  }
  var node = yaml.readAsLinesSync();

  if ((node?.where((element) => element?.trim() == 'scripts:')?.length ?? 0) >
      0) {
    return;
  }

  final index = node.length;

  try {
    node.insert(index, 'vars: ');
    node.insert(index + 1, '    clean: flutter clean');
    node.insert(index + 2, '    get: flutter pub get');
    node.insert(index + 3, '    runner: flutter pub run build_runner');

    node.insert(index + 4, 'scripts: ');
    node.insert(index + 5,
        '    mobx_build: \$clean & \$get & \$runner build --delete-conflicting-outputs');
    node.insert(index + 6,
        '    mobx_watch: \$clean & \$get & \$runner watch --delete-conflicting-outputs');

    yaml.writeAsStringSync('${node.join('\n')}\n');
  } catch (e) {
    output.error('Erro o generate scripts');
  }
}

void generateGitignore({String directory}) async {
  final gitignore =
      File(directory == null ? '.gitignore' : '$directory/.gitignore');

  var node = gitignore.readAsLinesSync();

  if ((node?.where((element) => element?.trim() == '.slidy/')?.length ?? 0) >
      0) {
    return;
  }

  try {
    node.insert(0, '');
    node.insert(0, '.slidy/');
    node.insert(0, '# Slidy History Files');

    gitignore.writeAsStringSync(node.join('\n'));
  } catch (e) {
    output.error('Erro o generate scripts');
  }
}

Function selecStateManagement([int selected, String directory]) {
  selected ??= stateCLIOptions('Choose a state manager', [
    'mobx (default)',
    'flutter_bloc',
    'BLoC with rxdart',
  ]);

  if (selected == -1) {
    exit(1);
  }

  return () async {
    if (selected == 2) {
      output.title('Starting a new project with RX BLoC');
      await install(['rxdart'], false, directory: directory);
    } else if (selected == 1) {
      output.title('Starting a new project with flutter_bloc');
      await createBlocBuilder();
      await install(['bloc', 'bloc_test', 'equatable'], false,
          directory: directory);
    } else if (selected == 0) {
      output.title('Starting a new project with Mobx');
      await install(['mobx', 'flutter_mobx'], false, directory: directory);
      await install(['build_runner', 'mobx_codegen'], true,
          directory: directory);

      await generateScript(directory: directory);
    } else {
      exit(1);
    }

    await install(['dio'], false, directory: directory);
    await install(['mockito'], true, directory: directory);
    await generateGitignore(directory: directory);
  };
}

void isContinue(Directory dir, [int selected]) {
  if (dir.existsSync()) {
    if ((dir.listSync()).isNotEmpty) {
      selected ??= stateCLIOptions(
          'This command will delete everything inside the \'lib /\' and \'test\' folders.',
          [
            'No',
            'Yes',
          ]);
    }
    if (selected == 1) {
      output.msg('Removing lib folder');
      dir.deleteSync(recursive: true);
    } else {
      output.error('The lib folder must be empty');
      exit(1);
    }
  }
}

Future start(
    {completeStart,
    bool force = false,
    Directory dir,
    Tuple2<Function, Function> tuple,
    String providerSystem,
    String stateManagement}) async {
  dir ??= Directory('lib');
  tuple ??= Tuple2(blocOrModular(providerSystemOptions[providerSystem]),
      selecStateManagement(stateManagementOptions[stateManagement]));
  await isContinue(dir, force ? 1 : null);
  await tuple.item1();
  await tuple.item2();

  var dirTest = Directory(dir.parent.path + '/test');
  if (await dirTest.exists()) {
    if (dirTest.listSync().isNotEmpty) {
      output.msg('Removing test folder');
      await dirTest.delete(recursive: true);
    }
  }

  var command =
      CommandRunner('slidy', 'CLI package manager and template for Flutter.');
  command.addCommand(GenerateCommand());

  var package = await getNamePackage(dir.parent);
  var m = await isModular();
  createStaticFile('${dir.path}/main.dart',
      m ? templates.startMainModular(package) : templates.startMain(package));

  createStaticFile(
      libPath('app_module.dart'),
      m
          ? templates.startAppModuleModular(package)
          : templates.startAppModule(package));

  if (completeStart) {
    createStaticFile(
        libPath('app_widget.dart'), templates.startAppWidgetComplete(package));

    createStaticFile(libPath('routes.dart'), templates.startRoutes(package));

    createStaticFile(
        libPath('shared/styles/theme_style.dart'), templates.startThemeStyle());

    createStaticFile(
        libPath('shared/locale/locales.dart'), templates.startLocales(package));

    createStaticFile(libPath('shared/locale/pt-BR_locale.dart'),
        templates.startPtBrLocale());

    createStaticFile(libPath('shared/locale/en-US_locale.dart'),
        templates.startEnUSLocale());

    await command.run(['generate', 'module', 'modules/login', '-c']);
    await command.run(['generate', 'module', 'modules/home', '-c']);

    // await install(['flutter_localizations: sdk: flutter'], false,
    //     haveTwoLines: true);
  } else {
    createStaticFile(
        libPath('app_widget.dart'),
        m
            ? templates.startAppWidgetModular(package)
            : templates.startAppWidget(package));

    await command.run(['generate', 'module', 'modules/home', '-c']);
  }

  var _isMobx = await isMobx();

  await command.run(['generate', _isMobx ? 'controller' : 'bloc', 'app']);

  output.msg('Project started! enjoy!');
}
