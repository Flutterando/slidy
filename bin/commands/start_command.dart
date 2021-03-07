import 'dart:async';
import 'dart:io';

// import 'package:dart_console/dart_console.dart';
import 'package:slidy/slidy.dart';

import '../prints/prints.dart';
import '../templates/start.dart';
import 'command_base.dart';
import '../prints/prints.dart' as output;

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
    // stdin.echoMode = false;
    // stdin.lineMode = false;
    // var console = Console();
    // var isRunning = true;
    // var selected = 0;

    // while (isRunning) {
    //   print('\x1B[2J\x1B[0;0H');
    //   output.title('Slidy CLI Interative\n');
    //   output.warn(title);
    //   for (var i = 0; i < options.length; i++) {
    //     if (selected == i) {
    //       print(output.green(options[i]));
    //     } else {
    //       print(output.white(options[i]));
    //     }
    //   }

    //   print('\nUse ↑↓ (keyboard arrows)');
    //   print('Press \'q\' to quit.');

    //   var key = console.readKey();

    //   if (key.controlChar == ControlCharacter.arrowDown) {
    //     if (selected < options.length - 1) {
    //       selected++;
    //     }
    //   } else if (key.controlChar == ControlCharacter.arrowUp) {
    //     if (selected > 0) {
    //       selected--;
    //     }
    //   } else if (key.controlChar == ControlCharacter.enter) {
    //     isRunning = false;
    //     return selected;
    //   } else if (key.char == 'q') {
    //     return -1;
    //   } else {}
    // }
    return -1;
  }

  int selecStateManagement() {
    var selected = stateCLIOptions('Choose a state manager', [
      'triple (default)',
      'mobx',
      'flutter_bloc',
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
    if (dirLib.existsSync()) {
      selected ??= stateCLIOptions('This command will delete everything inside the \'lib /\' and \'test\' folders.', [
        'No',
        'Yes',
      ]);
    }
    if (selected == 1) {
      output.msg('Removing lib and test folders');
      if (await dirLib.exists()) {
        await dirLib.delete(recursive: true);
      }
      if (await dirTest.exists()) {
        await dirTest.delete(recursive: true);
      }
    } else {
      output.error('The lib folder must be empty');
      exit(1);
    }
  }

  @override
  FutureOr run() async {
    await isContinue((argResults?['force'] == true) ? 1 : null);

    var result = await Slidy.instance.template.createFile(info: TemplateInfo(yaml: mainFile, destiny: File('lib/main.dart'), key: 'main'));
    execute(result);
    result = await Slidy.instance.template.createFile(info: TemplateInfo(yaml: mainFile, destiny: File('lib/app/app_module.dart'), key: 'app_module'));
    execute(result);
    result = await Slidy.instance.template.createFile(info: TemplateInfo(yaml: mainFile, destiny: File('lib/app/app_widget.dart'), key: 'app_widget'));
    execute(result);
    result = await Slidy.instance.template.createFile(info: TemplateInfo(yaml: mainFile, destiny: File('lib/app/modules/home/home_page.dart'), key: 'home_page'));
    execute(result);
    result = await Slidy.instance.template.createFile(info: TemplateInfo(yaml: mainFile, destiny: File('lib/app/modules/home/home_module.dart'), key: 'home_module'));
    execute(result);

    //install packages
    result = await Slidy.instance.instalation.install(package: PackageName('flutter_modular'));
    execute(result);
    //devs
    result = await Slidy.instance.instalation.install(package: PackageName('flutter_modular_test', isDev: true));
    execute(result);
  }

  @override
  String? get invocationSuffix => null;
}
