import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_console/dart_console.dart';
import 'package:slidy/src/command/generate_command.dart';
import 'package:slidy/src/modules/install.dart';
import 'package:slidy/src/templates/templates.dart' as templates;
import 'package:slidy/src/utils/file_utils.dart';
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
  final console = Console();
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

    final key = console.readKey();

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
      await install(
        packs: ['flutter_modular'],
        isDev: false,
        directory: directory,
      );
    } else if (selected == 1) {
      output.msg('Instaling bloc_pattern...');
      await install(
        packs: ['bloc_pattern'],
        isDev: false,
        directory: directory,
      );
    } else {
      exit(1);
    }
  };
}

Future<void> generateScript() async {
  final yaml = File('pubspec.yaml');
  final node = yaml.readAsLinesSync();

  final index =
      node.indexWhere((t) => t.contains('uses-material-design: true')) + 1;

  try {
    node.insert(index, 'scripts: ');
    node.insert(index + 1,
        '\n    mobx_build: flutter clean & flutter pub get & flutter pub run build_runner build --delete-conflicting-outputs');
    node.insert(index + 1,
        '\n    mobx_watch: flutter clean & flutter pub get & flutter pub run build_runner watch --delete-conflicting-outputs');

    yaml.writeAsStringSync('${node.join('\n')}\n');
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
      await install(
        packs: ['rxdart'],
        isDev: false,
        directory: directory,
      );
    } else if (selected == 1) {
      output.title('Starting a new project with flutter_bloc');
      await createBlocBuilder();
      await install(
        packs: ['bloc', 'bloc_test', 'equatable'],
        isDev: false,
        directory: directory,
      );
    } else if (selected == 0) {
      output.title('Starting a new project with Mobx');
      await install(
        packs: ['mobx', 'flutter_mobx'],
        isDev: false,
        directory: directory,
      );
      await install(
        packs: ['build_runner', 'mobx_codegen'],
        isDev: true,
        directory: directory,
      );
      await generateScript();
    } else {
      exit(1);
    }

    await install(
      packs: ['dio'],
      isDev: false,
      directory: directory,
    );
    await install(
      packs: ['mockito'],
      isDev: true,
      directory: directory,
    );
  };
}

Future isContinue(Directory dir, [int selected]) async {
  if (await dir.exists()) {
    if (dir.listSync().isNotEmpty) {
      selected ??= stateCLIOptions(
          'This command will delete everything inside the \'lib /\' and \'test\' folders.',
          [
            'No',
            'Yes',
          ]);
    }
    if (selected == 1) {
      output.msg('Removing lib folder');
      await dir.delete(recursive: true);
    } else {
      output.error('The lib folder must be empty');
      exit(1);
    }
  }
}

Future start({
  bool completeStart,
  bool force = false,
  Directory dir,
  Tuple2<Function, Function> tuple,
  String providerSystem,
  String stateManagement,
}) async {
  dir ??= Directory('lib');
  tuple ??= Tuple2(blocOrModular(providerSystemOptions[providerSystem]),
      selecStateManagement(stateManagementOptions[stateManagement]));
  await isContinue(dir, force ? 1 : null);
  await tuple.item1();
  await tuple.item2();

  final dirTest = Directory('${dir.parent.path}/test');
  if (await dirTest.exists()) {
    if (dirTest.listSync().isNotEmpty) {
      output.msg('Removing test folder');
      await dirTest.delete(recursive: true);
    }
  }

  final command =
      CommandRunner('slidy', 'CLI package manager and template for Flutter.');
  command.addCommand(GenerateCommand());

  final package = await getNamePackage(dir.parent);
  final m = await isModular();
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

  final _isMobx = await isMobx();

  final target = _isMobx ? 'controller' : 'bloc';
  await command.run(['generate', target, 'app']);

  output.msg('Project started! enjoy!');
}
