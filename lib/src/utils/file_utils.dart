import 'dart:io';
import 'package:path/path.dart';
import 'package:recase/recase.dart';
import 'package:slidy/src/templates/templates.dart';
import 'package:slidy/src/utils/utils.dart';
import 'package:slidy/src/utils/output_utils.dart' as output;

import 'local_save_log.dart';
import 'object_generate.dart';

Future createFile(
  String path,
  String type,
  Function(ObjectGenerate) generator, {
  Function(ObjectGenerate) generatorTest,
  bool ignoreSuffix = false,
  bool isModular = false,
  StateManagementEnum stateManagement = StateManagementEnum.rxDart,
  bool isInterface = false,
  bool hasInterface = false,
}) async {
  output.msg('Creating $type...');

  path = path.replaceAll('\\', '/').replaceAll('\"', '');
  if (path.startsWith('/')) path = path.substring(1);
  if (path.endsWith('/')) path = path.substring(0, path.length - 1);

  path = libPath(path);

  if (mainDirectory.isNotEmpty) {
    path = path.replaceAll('app/$mainDirectory', 'app/');
  }

  Directory dir;
  if (type == 'bloc' ||
      type == 'store' ||
      type == 'controller' ||
      type == 'repository' ||
      type == 'service' ||
      type == 'model') {
    dir = Directory(path).parent;
  } else {
    dir = Directory(path);
  }

  if (type != 'bloc' || stateManagement != StateManagementEnum.flutter_bloc) {
    var name = basename(path);
    File file;
    File fileTest;
    if (!isInterface) {
      if (ignoreSuffix) {
        file = File('${dir.path}/${ReCase(name).snakeCase}.dart');
        fileTest = File(
            '${dir.path.replaceFirst("lib/", "test/")}/${ReCase(name).snakeCase}_test.dart');
      } else {
        file = File(
            '${dir.path}/${ReCase(name).snakeCase}_${type.replaceAll("_complete", "")}.dart');
        fileTest = File(
            '${dir.path.replaceFirst("lib/", "test/")}/${ReCase(name).snakeCase}_${type.replaceAll("_complete", "")}_test.dart');
      }
    } else {
      file = File(
          '${dir.path}/interfaces/${ReCase(name).snakeCase}_${type}_interface.dart');
    }

    if (await file.exists()) {
      output.error('already exists a $type ${ReCase(name).snakeCase}');
      exit(1);
    }

    if (await fileTest?.exists() ?? false) {
      output
          .error('already exists a $type ${ReCase(name).snakeCase} test file');
      exit(1);
    }

    await file.create(recursive: true);
    LocalSaveLog().add(file.path);
    output.msg('File ${file.path} created');

    if (type == 'module_complete') {
      var package = await getNamePackage();
      await file.writeAsString(generator(ObjectGenerate(
          packageName: package,
          name: formatName(name),
          pathModule: '$path/$name')));
    } else if (type == 'module') {
      await file.writeAsString(generator(ObjectGenerate(
          name: formatName(name), packageName: '', pathModule: path)));
    } else {
      await file.writeAsString(
          generator(ObjectGenerate(name: formatName(name), type: type)));
    }

    await formatFile(file);

    File module;
    String nameModule;

    if (!isInterface &&
        (type == 'bloc' ||
            type == 'controller' ||
            type == 'repository' ||
            type == 'store' ||
            type == 'service')) {
      try {
        module = isModular
            ? await addModule(formatName('${name}_$type'), file.path,
                hasInterface: hasInterface)
            : await addModuleOld(
                formatName('${name}_$type'),
                file.path,
                type == 'bloc' || type == 'controller' || type == 'store',
                hasInterface);
      } catch (e) {
        print('not Module');
      }
      nameModule = module == null ? null : basename(module.path);
    }

    if (generatorTest != null) {
      await fileTest.create(recursive: true);
      LocalSaveLog().add(fileTest.path);

      output.msg('File test ${fileTest.path} created');
      if (type == 'widget' || type == 'page') {
        await fileTest.writeAsString(generatorTest(ObjectGenerate(
            name: formatName(name),
            packageName: await getNamePackage(),
            import: file.path,
            module: nameModule != null ? formatName(nameModule) : null,
            pathModule: module?.path,
            isModular: isModular)));
      } else {
        await fileTest.writeAsString(generatorTest(ObjectGenerate(
            name: formatName(name),
            type: type,
            packageName: await getNamePackage(),
            import: file.path,
            module: nameModule != null ? formatName(nameModule) : null,
            pathModule: module?.path)));
      }

      await formatFile(fileTest);
    }

    output.success('$type created');
  } else {
    //Bloc padrao Flutter Bloc

    var name = basename(path);
    File fileBloc;
    File fileEvent;
    File fileState;
    File fileBlocTest;

    fileBloc = File(
        '${dir.path}/bloc/${ReCase(name).snakeCase}_${type.replaceAll("_complete", "")}.dart');
    fileState = File('${dir.path}/bloc/${ReCase(name).snakeCase}_state.dart');
    fileEvent = File('${dir.path}/bloc/${ReCase(name).snakeCase}_event.dart');

    fileBlocTest = File(
        '${dir.path.replaceFirst("lib/", "test/")}/${ReCase(name).snakeCase}_${type.replaceAll("_complete", "")}_test.dart');

    if (await fileBloc.exists() ||
        await fileState.exists() ||
        await fileEvent.exists()) {
      output.error('already exists a $type $name');
      exit(1);
    }

    if (await fileBlocTest.exists()) {
      output.error('already exists a $type $name test file');
      exit(1);
    }

    await fileBloc.create(recursive: true);
    LocalSaveLog().add(fileBloc.path);
    output.msg('File ${fileBloc.path} created');
    await fileState.create(recursive: true);
    LocalSaveLog().add(fileState.path);
    output.msg('File ${fileState.path} created');
    await fileEvent.create(recursive: true);
    LocalSaveLog().add(fileEvent.path);
    output.msg('File ${fileEvent.path} created');

    await fileBloc.writeAsString(
        flutter_blocGenerator(ObjectGenerate(name: formatName(name))));
    await fileState.writeAsString(
        flutter_blocStateGenerator(ObjectGenerate(name: formatName(name))));
    await fileEvent.writeAsString(
        flutter_blocEventGenerator(ObjectGenerate(name: formatName(name))));

    await formatFile(fileBloc);
    await formatFile(fileState);
    await formatFile(fileEvent);

    File module;
    String nameModule;

    module = isModular
        ? await addModule(
            formatName('${ReCase(name).snakeCase}_$type'),
            fileBloc.path,
          )
        : await addModuleOld(
            formatName('${ReCase(name).snakeCase}_$type'),
            fileBloc.path,
            type == 'bloc' || type == 'controller' || type == 'store');
    nameModule = module == null ? null : basename(module.path);

    if (generatorTest != null) {
      await fileBlocTest.create(recursive: true);
      LocalSaveLog().add(fileBlocTest.path);

      output.msg('File test ${fileBlocTest.path} created');
      if (type == 'widget' || type == 'page') {
        await fileBlocTest.writeAsString(generatorTest(ObjectGenerate(
            name: formatName(name),
            type: type,
            packageName: await getNamePackage(),
            import: fileBloc.path,
            module: nameModule != null ? formatName(nameModule) : null,
            pathModule: module?.path,
            isModular: isModular)));
      } else {
        await fileBlocTest.writeAsString(generatorTest(ObjectGenerate(
            name: formatName(name),
            type: type,
            packageName: await getNamePackage(),
            import: fileBloc.path,
            module: nameModule != null ? formatName(nameModule) : null,
            pathModule: module?.path)));
      }

      await formatFile(fileBlocTest);
    }

    output.success('$type created');
  }
}

Future<void> formatFile(File file) async {
  await Process.run('flutter', ['format', file.absolute.path],
      runInShell: true);
}

Future<File> addModule(
  String nameCap,
  String path, {
  bool hasInterface = false,
}) async {
  int index;
  var module = findModule(path);

  if (module == null) {
    output.error('Module not found');
    exit(1);
  }

  var node = (await module.readAsString()).split('\n');

  var modulePath = module.path
      .replaceAll('\\', '/')
      .replaceFirst(module.path.split('/').last, '');

  var pathFormated = path.replaceAll('\\', '/');
  var pathFile = pathFormated.replaceAll(modulePath, '');

  var import = "import '$pathFile';";
  if (hasInterface) {
    var file = pathFile.split('/').last;
    var interfacePath = pathFile.replaceAll(
        file, 'interfaces/${file.replaceFirst('.dart', '_interface.dart')}');

    import += "\nimport '${interfacePath}';";
  }

  node.insert(0, import);
  if (nameCap.contains('Repository') &&
      !node.any(
          (element) => element.contains("import 'package:dio/dio.dart';"))) {
    node.insert(0, "import 'package:dio/dio.dart';");
  }

  index = node.indexWhere((t) => t.contains('binds => ['));
  node[index] = node[index].replaceFirst(
    'binds => [',
    (hasInterface
        ? (nameCap.contains('Repository')
            ? 'binds => [Bind<I${nameCap}>((i) => ${nameCap}(Dio())),'
            : 'binds => [Bind<I${nameCap}>((i) => ${nameCap}()),')
        : (nameCap.contains('Repository')
            ? 'binds => [Bind((i) => ${nameCap}(Dio())),'
            : 'binds => [Bind((i) => ${nameCap}()),')),
  );

  await module.writeAsString(node.join('\n'));
  await formatFile(module);

  output.success('${module.path} modified');
  return module;
}

@deprecated
Future<File> addModuleOld(String nameCap, String path, bool isBloc,
    [bool hasInterface]) async {
  int index;
  var module = findModule(path);

  if (module == null) {
    output.error('Module not found');
    exit(1);
  }

  var node = (await module.readAsString()).split('\n');
  var packageName = await getNamePackage();
  var import = hasInterface
      ? 'package:${packageName}/${path.replaceFirst("lib/", "").replaceAll("\\", "/")}'
          .replaceAll('$packageName/${packageName}_interface', packageName)
      : 'package:${packageName}/${path.replaceFirst("lib/", "").replaceAll("\\", "/")}'
          .replaceAll('$packageName/$packageName', packageName);
  node.insert(0, "  import '$import';");

  if (isBloc) {
    index = node.indexWhere((t) => t.contains('blocs => ['));
    node[index] = node[index]
        .replaceFirst('blocs => [', 'blocs => [Bloc((i) => ${nameCap}()),');
  } else {
    index = node.indexWhere((t) => t.contains('dependencies => ['));
    node[index] = node[index].replaceFirst(
        'dependencies => [',
        hasInterface
            ? 'dependencies => [Dependency((i) => I${nameCap}()),'
            : 'dependencies => [Dependency((i) => ${nameCap}()),');
  }

  await module.writeAsString(node.join('\n'));
  await formatFile(module);
  output.success('${module.path} modified');

  return module;
}

File findModule(String path) {
  var dir = Directory(path);
  var loop = true;
  var count = 0;
  File module;
  do {
    module = search(dir);
    dir = dir.parent;
    loop = module == null && basename(dir.path) != 'lib' && count < 10;
    count++;
  } while (loop);
  module = File(module.path.replaceAll('\\', '/'));
  return module;
}

File search(Directory dir) {
  try {
    var a = dir
        .listSync()
        .firstWhere((f) => f is File && f.path.contains('_module.dart'));

    print(' Test' + a?.toString());
    return dir
        .listSync()
        .firstWhere((f) => f is File && f.path.contains('_module.dart'));
  } catch (e) {
    return null;
  }
}

void createStaticFile(String path, String content) async {
  try {
    var file = File(path)
      ..createSync(recursive: true)
      ..writeAsStringSync(content);
    LocalSaveLog().add(file.path);

    await formatFile(file);
    output.success('${file.path} created');
  } catch (e) {
    output.error(e);
    exit(1);
  }
}

Future<void> createBlocBuilder() async {
  output.success('Creating the bloc?');
  var path = 'lib/app/shared/';

  var dir = Directory(path);

  var name = basename(path);
  File fileBlocProvider;

  fileBlocProvider = File('${dir.path}/bloc_builder.dart');

  if (fileBlocProvider.existsSync()) {
    return;
  }

  fileBlocProvider.createSync(recursive: true);
  LocalSaveLog().add(fileBlocProvider.path);

  output.msg('File /${fileBlocProvider.path} created');

  fileBlocProvider.writeAsStringSync(
      bloc_builderGenerator(ObjectGenerate(name: formatName(name))));

  await formatFile(fileBlocProvider);

  output.success('bloc_provider created');
}
