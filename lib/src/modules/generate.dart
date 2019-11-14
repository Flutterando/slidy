import 'dart:io';

import 'package:path/path.dart';
import 'package:slidy/src/templates/templates.dart' as templates;
import 'package:slidy/src/utils/file_utils.dart' as file_utils;
import 'package:slidy/src/utils/file_utils.dart';
import 'package:slidy/src/utils/utils.dart';
import 'package:slidy/src/utils/output_utils.dart' as output;

class Generate {
  static module(String path, bool createCompleteModule) async {
    String moduleType = createCompleteModule ? 'module_complete' : 'module';
    await file_utils.createFile(path, moduleType, templates.moduleGenerator);
    if (createCompleteModule) {
      await page(path, false);
    }
  }

  static page(String path, bool blocLess,
      [bool flutter_bloc = false, bool mobx = false]) {
    file_utils.createFile(
        path, 'page', templates.pageGenerator, templates.pageTestGenerator);
    String name = basename(path);
    if (!blocLess) {
      bloc("$path/$name", true, flutter_bloc, mobx);
    }
  }

  static widget(String path, bool blocLess, bool ignoreSufix,
      [bool flutter_bloc = false, bool mobx = false]) {
    if (ignoreSufix) {
      file_utils.createFile(
          path,
          'widget',
          templates.widgetGeneratorWithoutSufix,
          templates.widgetTestGeneratorWithoutSufix,
          ignoreSufix);
    } else {
      file_utils.createFile(
        path,
        'widget',
        templates.widgetGenerator,
        templates.widgetTestGenerator,
      );
    }

    String name = basename(path);
    if (!blocLess) {
      bloc("$path/$name", true, flutter_bloc, mobx);
    }
  }

  static test(String path) {
    if (path.contains(".dart")) {
      File entity = File(libPath(path));
      if (!entity.existsSync()) {
        output.error("File $path not exist");
        exit(1);
      }
      _generateTest(
          entity,
          File(libPath(path)
              .replaceFirst("lib/", "test/")
              .replaceFirst(".dart", "_test.dart")));
    } else {
      Directory entity = Directory(libPath(path));
      if (!entity.existsSync()) {
        output.error("Directory $path not exist");
        exit(1);
      }

      for (FileSystemEntity file in entity.listSync()) {
        if (file is File) {
          _generateTest(
              file,
              File(file.path
                  .replaceFirst("lib/", "test/")
                  .replaceFirst(".dart", "_test.dart")));
        }
      }
    }
  }

  static _generateTest(File entity, File entityTest) async {
    if (entityTest.existsSync()) {
      output.error("Test already exists");
      exit(1);
    }

    String name = basename(entity.path);
    File module = file_utils.findModule(entity.path);
    String nameModule = module == null ? null : basename(module.path);

    if (name.contains("_bloc.dart")) {
      entityTest.createSync(recursive: true);
      output.msg("File test ${entityTest.path} created");
      entityTest.writeAsStringSync(
        templates.blocTestGenerator(
          formatName(name.replaceFirst("_bloc.dart", "")),
          await getNamePackage(),
          entity.path,
          nameModule == null ? null : formatName(nameModule),
          module?.path,
        ),
      );
    } else if (name.contains("_repository.dart")) {
      entityTest.createSync(recursive: true);
      output.msg("File test ${entityTest.path} created");
      entityTest.writeAsStringSync(
        templates.repositoryTestGenerator(
            formatName(name.replaceFirst("_repository.dart", "")),
            await getNamePackage(),
            entity.path,
            nameModule == null ? null : formatName(nameModule),
            module?.path),
      );
    }
    formatFile(entityTest);
  }

  static repository(String path, [bool isTest = true]) {
    file_utils.createFile(path, 'repository', templates.repositoryGenerator,
        isTest ? templates.repositoryTestGenerator : null);
  }

  static service(String path, [bool isTest = true]) {
    file_utils.createFile(path, 'service', templates.serviceGenerator,
        isTest ? templates.serviceTestGenerator : null);
  }

  static bloc(String path,
      [bool isTest = true,
      bool flutter_bloc = false,
      bool mobx = false]) async {
    var template;

    if (!flutter_bloc && !mobx) {
      flutter_bloc =
          flutter_bloc ? true : await checkDependency('flutter_bloc');
      mobx = mobx ? true : await checkDependency('flutter_mobx');
    }

    if (flutter_bloc) {
      template = templates.flutter_blocGenerator;
    } else if (mobx) {
      template = templates.mobx_blocGenerator;
    } else {
      template = templates.blocGenerator;
    }

    var testTemplate =
        mobx ? templates.mobxBlocTestGenerator : templates.blocTestGenerator;

    file_utils.createFile(path, mobx ? 'controller' : 'bloc', template,
        isTest ? testTemplate : null);
  }
}
