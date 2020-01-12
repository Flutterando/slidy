import 'dart:io';

import 'package:path/path.dart';
import 'package:slidy/src/templates/templates.dart' as templates;
import 'package:slidy/src/utils/file_utils.dart' as file_utils;
import 'package:slidy/src/utils/file_utils.dart';
import 'package:slidy/src/utils/utils.dart';
import 'package:slidy/src/utils/output_utils.dart' as output;

import '../utils/utils.dart';

class Generate {
  static Future module(String path, bool createCompleteModule) async {
    var moduleType = createCompleteModule ? 'module_complete' : 'module';
    var m = await isModular();

    await file_utils.createFile('${mainDirectory}$path', moduleType,
        m ? templates.moduleGeneratorModular : templates.moduleGenerator);
    if (createCompleteModule) {
      await page(path, false, m);
    }
  }

  static void page(String path, bool blocLess,
      [bool flutter_bloc = false, bool mobx = false]) async {
    var m = await isModular();
    file_utils.createFile(
        '${mainDirectory}$path', 'page', templates.pageGenerator,
        generatorTest: templates.pageTestGenerator, isModular: m);
    var name = basename(path);
    if (!blocLess) {
      bloc('$path/$name', true, flutter_bloc, mobx);
    }
  }

  static Future widget(String path, bool blocLess, bool ignoreSuffix,
      [bool flutter_bloc = false, bool mobx = false]) async {
    var m = await isModular();

    if (ignoreSuffix) {
      file_utils.createFile(
          path, 'widget', templates.widgetGeneratorWithoutSuffix,
          generatorTest: templates.widgetTestGeneratorWithoutSuffix,
          ignoreSuffix: ignoreSuffix,
          isModular: m);
    } else {
      file_utils.createFile(
          '${mainDirectory}$path', 'widget', templates.widgetGenerator,
          generatorTest: templates.widgetTestGenerator, isModular: m);
    }

    var name = basename(path);
    if (!blocLess) {
      bloc('$path/$name', true, flutter_bloc, mobx);
    }
  }

  static void test(String path) {
    if (path.contains('.dart')) {
      var entity = File(libPath(path));
      if (!entity.existsSync()) {
        output.error('File $path not exist');
        exit(1);
      }
      _generateTest(
          entity,
          File(libPath(path)
              .replaceFirst('lib/', 'test/')
              .replaceFirst('.dart', '_test.dart')));
    } else {
      var entity = Directory(libPath(path));
      if (!entity.existsSync()) {
        output.error('Directory $path not exist');
        exit(1);
      }

      for (var file in entity.listSync()) {
        if (file is File) {
          _generateTest(
              file,
              File(file.path
                  .replaceFirst('lib/', 'test/')
                  .replaceFirst('.dart', '_test.dart')));
        }
      }
    }
  }

  static Future _generateTest(File entity, File entityTest) async {
    if (entityTest.existsSync()) {
      output.error('Test already exists');
      exit(1);
    }

    var m = await isModular();
    var name = basename(entity.path);
    var module = file_utils.findModule(entity.path);
    var nameModule = module == null ? null : basename(module.path);

    if (name.contains('_bloc.dart')) {
      entityTest.createSync(recursive: true);
      output.msg('File test ${entityTest.path} created');
      entityTest.writeAsStringSync(
        templates.blocTestGenerator(
          formatName(name.replaceFirst('_bloc.dart', '')),
          await getNamePackage(),
          entity.path,
          nameModule == null ? null : formatName(nameModule),
          module?.path,
        ),
      );
    } else if (name.contains('_repository.dart')) {
      entityTest.createSync(recursive: true);
      output.msg('File test ${entityTest.path} created');
      entityTest.writeAsStringSync(
        templates.repositoryTestGenerator(
            formatName(name.replaceFirst('_repository.dart', '')),
            await getNamePackage(),
            entity.path,
            nameModule == null ? null : formatName(nameModule),
            module?.path),
      );
    } else if (name.contains('_page.dart')) {
      entityTest.createSync(recursive: true);
      output.msg('File test ${entityTest.path} created');
      entityTest.writeAsStringSync(
        templates.pageTestGenerator(
            formatName(name.replaceFirst('_page.dart', '')),
            await getNamePackage(),
            entity.path,
            nameModule == null ? null : formatName(nameModule),
            module?.path,
            m),
      );
    } else if (name.contains('_controller.dart')) {
      entityTest.createSync(recursive: true);
      output.msg('File test ${entityTest.path} created');
      entityTest.writeAsStringSync(
        m
            ? templates.mobxBlocTestGeneratorModular(
                formatName(name.replaceFirst('_controller.dart', '')),
                await getNamePackage(),
                entity.path,
                nameModule == null ? null : formatName(nameModule),
                module?.path,
              )
            : templates.mobxBlocTestGenerator(
                formatName(name.replaceFirst('_controller.dart', '')),
                await getNamePackage(),
                entity.path,
                nameModule == null ? null : formatName(nameModule),
                module?.path,
              ),
      );
    }

    formatFile(entityTest);
  }

  static Future repository(String path, [bool isTest = true]) async {
    var m = await isModular();
    file_utils.createFile(
        path,
        'repository',
        m
            ? templates.repositoryGeneratorModular
            : templates.repositoryGenerator,
        generatorTest: isTest ? templates.repositoryTestGenerator : null,
        isModular: m);
  }

  static Future service(String path, [bool isTest = true]) async {
    var m = await isModular();
    file_utils.createFile('${mainDirectory}$path', 'service',
        m ? templates.serviceGeneratorModular : templates.serviceGenerator,
        generatorTest: isTest ? templates.serviceTestGenerator : null,
        isModular: m);
  }

  static void model(List<String> path,
      [bool isTest = false, bool isReactive = false]) {
    file_utils.createFile(
      '${mainDirectory}${path.first}',
      'model',
      isReactive ? templates.modelRxGenerator : templates.modelGenerator,
      ignoreSuffix: false,
    );
  }

  static void bloc(String path,
      [bool isTest = true,
      bool flutter_bloc = false,
      bool mobx = false]) async {
    var template;

    var m = await isModular();

    if (!flutter_bloc) {
      flutter_bloc = await checkDependency('bloc');
    }

    if (!mobx) {
      mobx = await checkDependency('flutter_mobx');
    }

    if (flutter_bloc) {
      template = templates.flutter_blocGenerator;
    } else if (mobx) {
      template = templates.mobx_blocGenerator;
    } else {
      template = m ? templates.blocGeneratorModular : templates.blocGenerator;
    }

    var testTemplate = mobx
        ? (m
            ? templates.mobxBlocTestGeneratorModular
            : templates.mobxBlocTestGenerator)
        : (m
            ? templates.blocTestGeneratorModular
            : templates.blocTestGenerator);

    var stateManagement = mobx
        ? StateManagementEnum.mobx
        : flutter_bloc
            ? StateManagementEnum.flutter_bloc
            : StateManagementEnum.rxDart;

    file_utils.createFile(
        '${mainDirectory}$path', mobx ? 'controller' : 'bloc', template,
        generatorTest: isTest ? testTemplate : null,
        isModular: m,
        stateManagement: stateManagement);
  }
}
