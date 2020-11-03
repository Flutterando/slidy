import 'dart:io';

import 'package:path/path.dart';
import 'package:slidy/src/templates/templates.dart' as templates;
import 'package:slidy/src/utils/file_utils.dart' as file_utils;
import 'package:slidy/src/utils/file_utils.dart';
import 'package:slidy/src/utils/object_generate.dart';
import 'package:slidy/src/utils/utils.dart';
import 'package:slidy/src/utils/output_utils.dart' as output;

import '../utils/utils.dart';

final PACKAGE_JSON_ANNOTATION = 'json_annotation';
final PACKAGE_JSON_SERIALIZABLE = 'json_serializable';

class Generate {
  static Future module(String path, bool createCompleteModule, bool noroute,
      bool withRepository, bool withInterface) async {
    var moduleType = createCompleteModule ? 'module_complete' : 'module';
    var m = await isModular();
    var templateModular = noroute
        ? templates.moduleGeneratorModularNoRoute
        : templates.moduleGeneratorModular;

    await file_utils.createFile('${mainDirectory}$path', moduleType,
        m ? templateModular : templates.moduleGenerator);

    if (createCompleteModule) {
      var _isMobx = await isMobx();
      await page(
        path,
        false,
        m,
        _isMobx,
      );
    }

    if (withRepository) {
      var lastBar = path.lastIndexOf(RegExp(r'/|\\'));
      var repositoryName = path.substring(lastBar);

      path = await repository(
          '$path/repositories/$repositoryName', true, withInterface);
    }
  }

  static void page(String path, bool blocLess,
      [bool flutter_bloc = false, bool mobx = false]) async {
    var m = await isModular();

    if (!blocLess && !flutter_bloc && !mobx) {
      mobx = await isMobx();
    }

    await file_utils.createFile('${mainDirectory}$path', 'page',
        mobx ? templates.pageGeneratorMobX : templates.pageGenerator,
        generatorTest: templates.pageTestGenerator, isModular: m);

    var name = basename(path);
    if (!blocLess) {
      var _isMobx = await isMobx();
      var type = _isMobx ? 'controller' : 'bloc';
      bloc('$path/$name', type);
    }
  }

  static Future widget(String path, bool blocLess, bool ignoreSuffix,
      [bool flutter_bloc = false, bool mobx = false]) async {
    var m = await isModular();

    if (ignoreSuffix) {
      await file_utils.createFile(
          path, 'widget', templates.widgetGeneratorWithoutSuffix,
          generatorTest: templates.widgetTestGeneratorWithoutSuffix,
          ignoreSuffix: ignoreSuffix,
          isModular: m);
    } else {
      await file_utils.createFile(
          '${mainDirectory}$path', 'widget', templates.widgetGenerator,
          generatorTest: templates.widgetTestGenerator, isModular: m);
    }

    var name = basename(path);
    if (!blocLess) {
      var type = (await isMobx()) ? 'controller' : 'bloc';

      bloc('$path/$name', type, true, flutter_bloc, mobx);
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
        templates.blocTestGenerator(ObjectGenerate(
          name: formatName(name.replaceFirst('_bloc.dart', '')),
          packageName: await getNamePackage(),
          import: entity.path,
          module: nameModule == null ? null : formatName(nameModule),
          pathModule: module?.path,
        )),
      );
    } else if (name.contains('_repository.dart')) {
      entityTest.createSync(recursive: true);
      output.msg('File test ${entityTest.path} created');
      entityTest.writeAsStringSync(
        templates.repositoryTestGenerator(ObjectGenerate(
            name: formatName(name.replaceFirst('_repository.dart', '')),
            packageName: await getNamePackage(),
            import: entity.path,
            module: nameModule == null ? null : formatName(nameModule),
            pathModule: module?.path)),
      );
    } else if (name.contains('_page.dart')) {
      entityTest.createSync(recursive: true);
      output.msg('File test ${entityTest.path} created');
      entityTest.writeAsStringSync(
        templates.pageTestGenerator(ObjectGenerate(
            name: formatName(name.replaceFirst('_page.dart', '')),
            packageName: await getNamePackage(),
            import: entity.path,
            module: nameModule == null ? null : formatName(nameModule),
            pathModule: module?.path,
            isModular: m)),
      );
    } else if (name.contains('_controller.dart')) {
      entityTest.createSync(recursive: true);
      output.msg('File test ${entityTest.path} created');
      entityTest.writeAsStringSync(
        m
            ? templates.mobxBlocTestGeneratorModular(ObjectGenerate(
                name: formatName(name.replaceFirst('_controller.dart', '')),
                type: 'controller',
                packageName: await getNamePackage(),
                import: entity.path,
                module: nameModule == null ? null : formatName(nameModule),
                pathModule: module?.path,
              ))
            : templates.mobxBlocTestGenerator(ObjectGenerate(
                name: formatName(name.replaceFirst('_controller.dart', '')),
                type: 'controller',
                packageName: await getNamePackage(),
                import: entity.path,
                module: nameModule == null ? null : formatName(nameModule),
                pathModule: module?.path,
              )),
      );
    } else if (name.contains('_store.dart')) {
      entityTest.createSync(recursive: true);
      output.msg('File test ${entityTest.path} created');
      entityTest.writeAsStringSync(
        m
            ? templates.mobxBlocTestGeneratorModular(ObjectGenerate(
                name: formatName(name.replaceFirst('_store.dart', '')),
                type: 'store',
                packageName: await getNamePackage(),
                import: entity.path,
                module: nameModule == null ? null : formatName(nameModule),
                pathModule: module?.path,
              ))
            : templates.mobxBlocTestGenerator(ObjectGenerate(
                name: formatName(name.replaceFirst('_store.dart', '')),
                type: 'store',
                packageName: await getNamePackage(),
                import: entity.path,
                module: nameModule == null ? null : formatName(nameModule),
                pathModule: module?.path,
              )),
      );
    }

    await formatFile(entityTest);
  }

  static Future usecase(String path,
      [bool isTest = true, bool withInterface = false]) async {
    var m = await isModular();

    if (!withInterface) {
      await file_utils.createFile(
        path,
        'usecase',
        templates.useCaseGenerator,
        ignoreSuffix: true,
        generatorTest: isTest ? templates.repositoryTestGenerator : null,
        isModular: m,
      );
    } else {
      await file_utils.createFile(
        path,
        'usecase',
        templates.interfaceUseCaseGenerator,
        ignoreSuffix: true,
        generatorTest: null,
        isModular: m,
        isInterface: true,
      );

      await file_utils.createFile(
        path,
        'usecase',
        templates.extendsInterfaceUseCaseGenerator,
        ignoreSuffix: true,
        generatorTest:
            isTest ? templates.interfaceRepositoryTestGenerator : null,
        isModular: m,
        hasInterface: true,
      );
    }
  }

  static Future repository(String path,
      [bool isTest = true, bool withInterface = false]) async {
    var m = await isModular();

    if (!withInterface) {
      await file_utils.createFile(
          path,
          'repository',
          m
              ? templates.repositoryGeneratorModular
              : templates.repositoryGenerator,
          generatorTest: isTest ? templates.repositoryTestGenerator : null,
          isModular: m);
    } else {
      await file_utils.createFile(
        path,
        'repository',
        m
            ? templates.interfaceRepositoryGeneratorModular
            : templates.interfaceRepositoryGenerator,
        generatorTest: null,
        isModular: m,
        isInterface: true,
      );

      await file_utils.createFile(
        path,
        'repository',
        m
            ? templates.extendsInterfaceRepositoryGeneratorModular
            : templates.extendsInterfaceRepositoryGenerator,
        generatorTest:
            isTest ? templates.interfaceRepositoryTestGenerator : null,
        isModular: m,
        hasInterface: true,
      );
    }
  }

  static Future service(String path,
      [bool isTest = true, bool withInterface = false]) async {
    var m = await isModular();

    if (!withInterface) {
      await file_utils.createFile('${mainDirectory}$path', 'service',
          m ? templates.serviceGeneratorModular : templates.serviceGenerator,
          generatorTest: isTest ? templates.serviceTestGenerator : null,
          isModular: m);
    } else {
      await file_utils.createFile(
          '${mainDirectory}$path',
          'service',
          m
              ? templates.interfaceServiceGeneratorModular
              : templates.interfaceServiceGenerator,
          generatorTest: null,
          isModular: m,
          isInterface: true);

      await file_utils.createFile(
          '${mainDirectory}$path',
          'service',
          m
              ? templates.extendsInterfaceServiceGeneratorModular
              : templates.extendsInterfaceServiceGenerator,
          generatorTest:
              isTest ? templates.interfaceServiceTestGenerator : null,
          isModular: m,
          hasInterface: true);
    }
  }

  static void model(List<String> path,
      [bool isTest = false, bool isReactive = false]) async {
    var templateModel;

    var getJsonDependencies = await Future.wait([
      checkDependency(PACKAGE_JSON_ANNOTATION),
      checkDevDependency(PACKAGE_JSON_SERIALIZABLE)
    ]);

    final checkJsonDependencies =
        getJsonDependencies.first && getJsonDependencies.last;

    if (isReactive) {
      if (checkJsonDependencies) {
        templateModel = templates.modelRxGeneratorJsonSerializable;
      } else {
        templateModel = templates.modelRxGenerator;
      }
    } else {
      if (checkJsonDependencies) {
        templateModel = templates.modelGeneratorJsonSerializable;
      } else {
        templateModel = templates.modelGenerator;
      }
    }

    await file_utils.createFile(
      '${mainDirectory}${path.first}',
      'model',
      templateModel,
      ignoreSuffix: false,
    );
  }

  static void bloc(String path, String type,
      [bool isTest = true,
      bool flutter_bloc = false,
      bool mobx = false]) async {
    var template;
    var m = await isModular();

    if (!mobx) {
      mobx = await isMobx();
    }

    if (!flutter_bloc) {
      flutter_bloc = await checkDependency('bloc');
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

    await file_utils.createFile('${mainDirectory}$path', type, template,
        generatorTest: isTest ? testTemplate : null,
        isModular: m,
        stateManagement: stateManagement);
  }
}
