import 'dart:async';
import 'dart:io';

import 'package:dart_console/dart_console.dart' show Console, ControlCharacter;

import 'package:slidy/slidy.dart';

import 'package:slidy/src/core/prints/prints.dart';
import '../templates/start.dart';
import 'command_base.dart';
import 'package:slidy/src/core/prints/prints.dart' as output;

class StartCommand extends CommandBase {
  @override
  final name = 'start';
  bool argsLength(int n) => (argResults?.arguments.length ?? 0) > n;
  @override
  final description = '"Create a basic structure for your project (confirm that you have no data in the \"lib\" folder)."';

  StartCommand() {
    argParser.addFlag('force', abbr: 'f', negatable: false, help: 'Erase lib dir');
  }

  int stateCLIOptions(String title, List<String> options) {
    stdin.echoMode = false;
    stdin.lineMode = false;
    var console = Console();
    var isRunning = true;
    var selected = 0;

    while (isRunning) {
      print('\x1B[2J\x1B[0;0H');
      output.title('Slidy CLI Interactive\n');
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
        print('\x1B[2J\x1B[0;0H');
        return selected;
      } else if (key.char == 'q') {
        return -1;
      } else {}
    }
    return -1;
  }

  int selecStateManagement() {
    var selected = stateCLIOptions('Choose a state manager', [
      'triple (default)',
      'mobx',
      'flutter_bloc - Cubit',
      'BLoC with rxdart',
    ]);

    if (selected == -1) {
      exit(1);
    }
    return selected;
  }

  Future isContinue([int? selected]) async {
    final dirLib = Directory('lib');
    final dirTest = Directory('test');

    if (await dirLib.exists()) {
      selected ??= stateCLIOptions('This command will delete everything inside the \'lib/\' and \'test\/\' folders.', [
        'No',
        'Yes',
      ]);
    } else {
      selected = 2;
      if (await dirLib.exists()) {
        await dirLib.delete(recursive: true);
      }
      if (await dirTest.exists()) {
        await dirTest.delete(recursive: true);
      }
    }

    if (selected == 1) {
      output.msg('Removing lib and test folders');
      if (await dirLib.exists()) {
        await dirLib.delete(recursive: true);
      }
      if (await dirTest.exists()) {
        await dirTest.delete(recursive: true);
      }
    } else if (selected < 1) {
      output.error('The lib folder must be empty. Or use -f to force start');
      exit(1);
    }
  }

  @override
  FutureOr run() async {
    var resultStateManagement = selecStateManagement();

    await isContinue((argResults?['force'] == true) ? 1 : null);

    var result = await Slidy.instance.template.createFile(info: TemplateInfo(yaml: mainFile, destiny: File('lib/main.dart'), key: 'main'));
    execute(result);
    result = await Slidy.instance.template
        .createFile(info: TemplateInfo(yaml: mainFile, destiny: File('lib/app/app_module.dart'), key: 'app_module'));
    execute(result);
    result = await Slidy.instance.template
        .createFile(info: TemplateInfo(yaml: mainFile, destiny: File('lib/app/app_widget.dart'), key: 'app_widget'));
    execute(result);

    //install packages
    result = await Slidy.instance.instalation.install(package: PackageName('flutter_modular'));
    execute(result);

    switch (resultStateManagement) {
      case 0:
        //Instal flutter_triple
        result = await Slidy.instance.instalation.install(package: PackageName('flutter_triple', isDev: false));
        execute(result);
        //Instal rx_notifier
        result = await Slidy.instance.instalation.install(package: PackageName('triple_test', isDev: true));
        execute(result);
        //Create a controller
        result = await Slidy.instance.template
            .createFile(info: TemplateInfo(yaml: mainFile, destiny: File('lib/app/modules/home/home_store.dart'), key: 'triple'));
        execute(result);
        //Page
        result = await Slidy.instance.template
            .createFile(info: TemplateInfo(yaml: mainFile, destiny: File('lib/app/modules/home/home_page.dart'), key: 'home_page_triple'));
        execute(result);
        result = await Slidy.instance.template.createFile(
            info: TemplateInfo(yaml: mainFile, destiny: File('lib/app/modules/home/home_module.dart'), key: 'home_module_triple'));
        execute(result);

        break;
      case 1:
        //Instal mobx
        result = await Slidy.instance.instalation.install(package: PackageName('mobx', isDev: false));
        execute(result);
        //Instal flutter_mobx
        result = await Slidy.instance.instalation.install(package: PackageName('flutter_mobx', isDev: false));
        execute(result);

        //Instal mobx_codegen
        result = await Slidy.instance.instalation.install(package: PackageName('mobx_codegen', isDev: true));
        execute(result);
        //Create a mobx
        result = await Slidy.instance.template
            .createFile(info: TemplateInfo(yaml: mainFile, destiny: File('lib/app/modules/home/home_store.dart'), key: 'mobx'));
        execute(result);
        result = await Slidy.instance.template
            .createFile(info: TemplateInfo(yaml: mainFile, destiny: File('lib/app/modules/home/home_store.g.dart'), key: 'mobx_g'));
        execute(result);
        //Page
        result = await Slidy.instance.template
            .createFile(info: TemplateInfo(yaml: mainFile, destiny: File('lib/app/modules/home/home_page.dart'), key: 'home_page_mobx'));
        execute(result);
        result = await Slidy.instance.template.createFile(
            info: TemplateInfo(yaml: mainFile, destiny: File('lib/app/modules/home/home_module.dart'), key: 'home_module_mobx'));
        execute(result);

        break;
      case 2:
        //Instal flutter_bloc
        result = await Slidy.instance.instalation.install(package: PackageName('flutter_bloc@7.0.0-nullsafety.4', isDev: false));
        execute(result);
        //Instal bloc_test
        result = await Slidy.instance.instalation.install(package: PackageName('bloc_test@8.0.0-nullsafety.4', isDev: true));
        execute(result);
        //Create a cubit
        result = await Slidy.instance.template
            .createFile(info: TemplateInfo(yaml: mainFile, destiny: File('lib/app/modules/home/counter_cubit.dart'), key: 'cubit'));
        execute(result);
        //Page
        result = await Slidy.instance.template
            .createFile(info: TemplateInfo(yaml: mainFile, destiny: File('lib/app/modules/home/home_page.dart'), key: 'home_page_cubit'));
        execute(result);
        result = await Slidy.instance.template.createFile(
            info: TemplateInfo(yaml: mainFile, destiny: File('lib/app/modules/home/home_module.dart'), key: 'home_module_cubit'));
        execute(result);
        break;
      case 3:
        //Instal rxdart
        result = await Slidy.instance.instalation.install(package: PackageName('rxdart', isDev: false));
        execute(result);
        //Create a rxdart
        result = await Slidy.instance.template
            .createFile(info: TemplateInfo(yaml: mainFile, destiny: File('lib/app/modules/home/home_controller.dart'), key: 'rx_dart'));
        execute(result);

        //Page
        result = await Slidy.instance.template
            .createFile(info: TemplateInfo(yaml: mainFile, destiny: File('lib/app/modules/home/home_page.dart'), key: 'home_page_rx_dart'));
        execute(result);
        result = await Slidy.instance.template.createFile(
            info: TemplateInfo(yaml: mainFile, destiny: File('lib/app/modules/home/home_module.dart'), key: 'home_module_rx_dart'));
        execute(result);

        break;
      default:
        result = await Slidy.instance.template
            .createFile(info: TemplateInfo(yaml: mainFile, destiny: File('lib/app/modules/home/home_page.dart'), key: 'home_page'));
        execute(result);
        result = await Slidy.instance.template
            .createFile(info: TemplateInfo(yaml: mainFile, destiny: File('lib/app/modules/home/home_module.dart'), key: 'home_module'));
        execute(result);
    }

    //devs
    result = await Slidy.instance.instalation.install(package: PackageName('modular_test', isDev: true));
    execute(result);
  }

  @override
  String? get invocationSuffix => null;
}
