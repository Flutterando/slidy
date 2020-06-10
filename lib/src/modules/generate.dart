import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart';

import 'package:slidy/src/templates/templates.dart' as templates;
import 'package:slidy/src/utils/file_utils.dart' as file_utils;
import 'package:slidy/src/utils/file_utils.dart';
import 'package:slidy/src/utils/object_generate.dart';
import 'package:slidy/src/utils/output_utils.dart' as output;
import 'package:slidy/src/utils/utils.dart';

import '../utils/utils.dart';

const PACKAGE_JSON_ANNOTATION = 'json_annotation';
const PACKAGE_JSON_SERIALIZABLE = 'json_serializable';

class Generate {
  static Future module({
    @required String path,
    @required bool createCompleteModule,
    @required bool noroute,
    @required bool withRepository,
    @required bool withInterface,
  }) async {
    final moduleType = createCompleteModule ? 'module_complete' : 'module';
    final m = await isModular();
    final templateModular = noroute
        ? templates.moduleGeneratorModularNoRoute
        : templates.moduleGeneratorModular;

    await file_utils.createFile('$mainDirectory$path', moduleType,
        m ? templateModular : templates.moduleGenerator);

    if (createCompleteModule) {
      final _isMobx = await isMobx();
      page(
        path: path,
        blocLess: false,
        flutter_bloc: m,
        mobx: _isMobx,
      );
    }

    if (withRepository) {
      final lastBar = path.lastIndexOf(RegExp(r'/|\\'));
      final repositoryName = path.substring(lastBar);

      await repository(
        path: '$path/repositories/$repositoryName',
        isTest: true,
        withInterface: withInterface,
      );
    }
  }

  static Future<void> page({
    @required String path,
    @required bool blocLess,
    bool flutter_bloc = false,
    bool mobx = false,
  }) async {
    final m = await isModular();

    if (!blocLess && !flutter_bloc && !mobx) {
      mobx = await isMobx();
    }

    await file_utils.createFile('$mainDirectory$path', 'page',
        mobx ? templates.pageGeneratorMobX : templates.pageGenerator,
        generatorTest: templates.pageTestGenerator, isModular: m);

    final name = basename(path);
    if (!blocLess) {
      final _isMobx = await isMobx();
      final type = _isMobx ? 'controller' : 'bloc';
      bloc(path: '$path/$name', type: type);
    }
  }

  static Future widget({
    @required String path,
    @required bool blocLess,
    @required bool ignoreSuffix,
    bool flutter_bloc = false,
    bool mobx = false,
  }) async {
    final m = await isModular();

    if (ignoreSuffix) {
      await file_utils.createFile(
          path, 'widget', templates.widgetGeneratorWithoutSuffix,
          generatorTest: templates.widgetTestGeneratorWithoutSuffix,
          ignoreSuffix: ignoreSuffix,
          isModular: m);
    } else {
      await file_utils.createFile(
          '$mainDirectory$path', 'widget', templates.widgetGenerator,
          generatorTest: templates.widgetTestGenerator, isModular: m);
    }

    final name = basename(path);
    if (!blocLess) {
      final type = (await isMobx()) ? 'controller' : 'bloc';

      bloc(
        path: '$path/$name',
        type: type,
        isTest: true,
        flutter_bloc: flutter_bloc,
        mobx: mobx,
      );
    }
  }

  static void test(String path) {
    if (path.contains('.dart')) {
      final entity = File(libPath(path));
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
      final entity = Directory(libPath(path));
      if (!entity.existsSync()) {
        output.error('Directory $path not exist');
        exit(1);
      }

      for (final file in entity.listSync()) {
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

    final m = await isModular();
    final name = basename(entity.path);
    final module = file_utils.findModule(entity.path);
    final nameModule = module == null ? null : basename(module.path);

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

  static Future repository({
    @required String path,
    bool isTest = true,
    bool withInterface = false,
  }) async {
    final m = await isModular();

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

  static Future service({
    @required String path,
    bool isTest = true,
    bool withInterface = false,
  }) async {
    final m = await isModular();

    if (!withInterface) {
      await file_utils.createFile('$mainDirectory$path', 'service',
          m ? templates.serviceGeneratorModular : templates.serviceGenerator,
          generatorTest: isTest ? templates.serviceTestGenerator : null,
          isModular: m);
    } else {
      await file_utils.createFile(
          '$mainDirectory$path',
          'service',
          m
              ? templates.interfaceServiceGeneratorModular
              : templates.interfaceServiceGenerator,
          generatorTest: null,
          isModular: m,
          isInterface: true);

      await file_utils.createFile(
          '$mainDirectory$path',
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

  static Future<void> model({
    @required List<String> path,
    bool isTest = false,
    bool isReactive = false,
  }) async {
    Function(ObjectGenerate) templateModel;

    final getJsonDependencies = await Future.wait([
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
      '$mainDirectory${path.first}',
      'model',
      templateModel,
      ignoreSuffix: false,
    );
  }

  static Future<void> bloc({
    @required String path,
    @required String type,
    bool isTest = true,
    bool flutter_bloc = false,
    bool mobx = false,
  }) async {
    String Function(ObjectGenerate obj) template;
    final m = await isModular();

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

    final testTemplate = mobx
        ? (m
            ? templates.mobxBlocTestGeneratorModular
            : templates.mobxBlocTestGenerator)
        : (m
            ? templates.blocTestGeneratorModular
            : templates.blocTestGenerator);

    final stateManagement = mobx
        ? StateManagementEnum.mobx
        : flutter_bloc
            ? StateManagementEnum.flutter_bloc
            : StateManagementEnum.rxDart;

    await file_utils.createFile('$mainDirectory$path', type, template,
        generatorTest: isTest ? testTemplate : null,
        isModular: m,
        stateManagement: stateManagement);
  }
}
