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
  bool hasInterface = false,
  Function(ObjectGenerate) generatorInterface,
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
    File fileInterface;
    File fileTest;
    if (ignoreSuffix) {
      file = File('${dir.path}/${name}.dart');
      fileInterface = File('${dir.path}/interfaces/${name}_interface.dart');
      fileTest =
          File('${dir.path.replaceFirst("lib/", "test/")}/${name}_test.dart');
    } else {
      file =
          File('${dir.path}/${name}_${type.replaceAll("_complete", "")}.dart');
      fileInterface = File(
          '${dir.path}/interfaces/${name}_${type.replaceAll("_complete", "")}_interface.dart');
      fileTest = File(
          '${dir.path.replaceFirst("lib/", "test/")}/${name}_${type.replaceAll("_complete", "")}_test.dart');
    }

    if (file.existsSync()) {
      output.error('already exists a $type $name');
      exit(1);
    }

    if (fileTest.existsSync()) {
      output.error('already exists a $type $name test file');
      exit(1);
    }

    if (hasInterface) {
      if (fileInterface.existsSync()) {
        output.error('already exists a $type $name interface file');
        exit(1);
      }
    }

    file.createSync(recursive: true);
    LocalSaveLog().add(file.path);
    output.msg('File ${file.path} created');

    if (hasInterface) {
      fileInterface.createSync(recursive: true);
      LocalSaveLog().add(fileInterface.path);
      output.msg('File ${fileInterface.path} created');
    }

    if (type == 'module_complete') {
      var package = await getNamePackage();
      file.writeAsStringSync(generator(ObjectGenerate(
          packageName: package,
          name: formatName(name),
          pathModule: '$path/$name')));
    } else if (type == 'module') {
      file.writeAsStringSync(generator(ObjectGenerate(
          name: formatName(name), packageName: '', pathModule: path)));
    } else {
      file.writeAsStringSync(generator(ObjectGenerate(
          name: formatName(name),
          type: type,
          import:
              "import '${fileInterface.path.replaceFirst('${dir.path}/', '')}';",
          hasInterface: hasInterface)));
      if (hasInterface) {
        fileInterface.writeAsStringSync(generatorInterface(
            ObjectGenerate(name: 'I${formatName(name)}', type: type)));
        formatFile(fileInterface);
      }
    }

    formatFile(file);

    File module;
    String nameModule;

    if (type == 'bloc' ||
        type == 'controller' ||
        type == 'repository' ||
        type == 'store' ||
        type == 'service') {
      try {
        module = await addModule(
            formatName('${name}_$type'),
            file.path,
            type == 'bloc' || type == 'controller' || type == 'store',
            isModular,
            hasInterface);
      } catch (e) {
        print('not Module');
      }
      nameModule = module == null ? null : basename(module.path);
    }

    if (generatorTest != null) {
      fileTest.createSync(recursive: true);
      LocalSaveLog().add(fileTest.path);

      output.msg('File test ${fileTest.path} created');
      if (type == 'widget' || type == 'page') {
        fileTest.writeAsStringSync(generatorTest(ObjectGenerate(
            name: formatName(name),
            packageName: await getNamePackage(),
            import: file.path,
            module: nameModule != null ? formatName(nameModule) : null,
            pathModule: module?.path,
            isModular: isModular)));
      } else {
        fileTest.writeAsStringSync(generatorTest(ObjectGenerate(
            name: formatName(name),
            type: type,
            packageName: await getNamePackage(),
            import: file.path,
            module: nameModule != null ? formatName(nameModule) : null,
            pathModule: module?.path)));
      }

      formatFile(fileTest);
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

    if (fileBloc.existsSync() ||
        fileState.existsSync() ||
        fileEvent.existsSync()) {
      output.error('already exists a $type $name');
      exit(1);
    }

    if (fileBlocTest.existsSync()) {
      output.error('already exists a $type $name test file');
      exit(1);
    }

    fileBloc.createSync(recursive: true);
    LocalSaveLog().add(fileBloc.path);
    output.msg('File ${fileBloc.path} created');
    fileState.createSync(recursive: true);
    LocalSaveLog().add(fileState.path);
    output.msg('File ${fileState.path} created');
    fileEvent.createSync(recursive: true);
    LocalSaveLog().add(fileEvent.path);
    output.msg('File ${fileEvent.path} created');

    fileBloc.writeAsStringSync(
        flutter_blocGenerator(ObjectGenerate(name: formatName(name))));
    fileState.writeAsStringSync(
        flutter_blocStateGenerator(ObjectGenerate(name: formatName(name))));
    fileEvent.writeAsStringSync(
        flutter_blocEventGenerator(ObjectGenerate(name: formatName(name))));

    formatFile(fileBloc);
    formatFile(fileState);
    formatFile(fileEvent);

    File module;
    String nameModule;

    module = await addModule(
        formatName('${ReCase(name).snakeCase}_$type'),
        fileBloc.path,
        type == 'bloc' || type == 'controller' || type == 'store',
        isModular);
    nameModule = module == null ? null : basename(module.path);

    if (generatorTest != null) {
      fileBlocTest.createSync(recursive: true);
      LocalSaveLog().add(fileBlocTest.path);

      output.msg('File test ${fileBlocTest.path} created');
      if (type == 'widget' || type == 'page') {
        fileBlocTest.writeAsStringSync(generatorTest(ObjectGenerate(
            name: formatName(name),
            type: type,
            packageName: await getNamePackage(),
            import: fileBloc.path,
            module: nameModule != null ? formatName(nameModule) : null,
            pathModule: module?.path,
            isModular: isModular)));
      } else {
        fileBlocTest.writeAsStringSync(generatorTest(ObjectGenerate(
            name: formatName(name),
            type: type,
            packageName: await getNamePackage(),
            import: fileBloc.path,
            module: nameModule != null ? formatName(nameModule) : null,
            pathModule: module?.path)));
      }

      formatFile(fileBlocTest);
    }

    output.success('$type created');
  }
}

void formatFile(File file) {
  Process.runSync('flutter', ['format', file.absolute.path], runInShell: true);
}

Future<File> addModule(String nameCap, String path, bool isBloc,
    [bool isModular = false, bool interface = false]) async {
  int index;
  var module = findModule(path);

  if (module == null) {
    output.error('Module not found');
    exit(1);
  }

  var node = module.readAsStringSync().split('\n');
  var packageName = await getNamePackage();
  var pathFormated = path.replaceFirst('lib/', '').replaceAll('\\', '/');

  var pathFile = '${packageName}/${pathFormated}'
      .replaceAll('$packageName/$packageName', '')
      .replaceFirst('lib/', '')
      .replaceAll('\\', '/')
      .split('app/')
      .last
      .replaceFirst('modules/', '');
  pathFile = pathFile.replaceFirst('${pathFile.split('/').first}/', '');

  node.insert(0, "  import '$pathFile';");

  if (interface) {
    var file = pathFile.split('/').last;

    var interfacePath = pathFile.replaceAll(
        file, 'interfaces/${file.replaceFirst('.dart', '_interface.dart')}');

    node.insert(0, "  import '$interfacePath';");
  }

  if (isModular) {
    var addInterface = (interface) ? '<I$nameCap>' : '';
    index = node.indexWhere((t) => t.contains('binds => ['));
    node[index] = node[index].replaceFirst(
        'binds => [', 'binds => [Bind$addInterface((i) => ${nameCap}()),');
  } else {
    if (isBloc) {
      index = node.indexWhere((t) => t.contains('blocs => ['));
      node[index] = node[index]
          .replaceFirst('blocs => [', 'blocs => [Bloc((i) => ${nameCap}()),');
    } else {
      index = node.indexWhere((t) => t.contains('dependencies => ['));
      node[index] = node[index].replaceFirst('dependencies => [',
          'dependencies => [Dependency((i) => ${nameCap}()),');
    }
  }

  module.writeAsStringSync(node.join('\n'));
  formatFile(module);
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

    print(' Teste' + a?.toString());
    return dir
        .listSync()
        .firstWhere((f) => f is File && f.path.contains('_module.dart'));
  } catch (e) {
    return null;
  }
}

void createStaticFile(String path, String content) {
  try {
    var file = File(path)
      ..createSync(recursive: true)
      ..writeAsStringSync(content);
    LocalSaveLog().add(file.path);

    formatFile(file);
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

  formatFile(fileBlocProvider);

  output.success('bloc_provider created');
}
