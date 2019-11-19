import 'dart:io';
import 'package:path/path.dart';
import 'package:slidy/src/utils/utils.dart';
import 'package:slidy/src/utils/output_utils.dart' as output;

void createFile(
  String path,
  String type,
  Function generator, [
  Function generatorTest,
  bool ignoreSufix = false,
]) async {
  output.msg("Creating $type...");

  path = path.replaceAll("\\", "/").replaceAll("\"", "");
  if (path.startsWith("/")) path = path.substring(1);
  if (path.endsWith("/")) path = path.substring(0, path.length - 1);

  path = libPath(path);

  Directory dir;
  if (type == 'bloc' ||
      type == 'controller' ||
      type == 'repository' ||
      type == 'service' ||
      type == 'model' ){
    dir = Directory(path).parent;
  } else {
    dir = Directory(path);
  }

  String name = basename(path);
  File file;
  File fileTest;
  if (ignoreSufix) {
    file = File('${dir.path}/${name}.dart');
    fileTest =
        File('${dir.path.replaceFirst("lib/", "test/")}/${name}_test.dart');
  } else {
    file = File('${dir.path}/${name}_${type.replaceAll("_complete", "")}.dart');
    fileTest = File(
        '${dir.path.replaceFirst("lib/", "test/")}/${name}_${type.replaceAll("_complete", "")}_test.dart');
  }

  if (file.existsSync()) {
    output.error("already exists a $type $name");
    exit(1);
  }

  if (fileTest.existsSync()) {
    output.error("already exists a $type $name test file");
    exit(1);
  }

  try {
    file.createSync(recursive: true);
    output.msg("File ${file.path} created");

    if (type == 'module_complete') {
      String package = await getNamePackage();
      file.writeAsStringSync(
          generator(package, formatName(name), "$path/$name"));
    } else if (type == 'module') {
      file.writeAsStringSync(generator("", formatName(name), path));
    } else {
      file.writeAsStringSync(generator(formatName(name)));
    }

    formatFile(file);

    File module;
    String nameModule;

    if (type == 'bloc' ||
        type == 'controller' ||
        type == 'repository' ||
        type == 'service') {
      module = await addModule(
          formatName("${name}_$type"), file.path, type == 'bloc' || type == 'controller');
      nameModule = module == null ? null : basename(module.path);
    }

    if (generatorTest != null) {
      fileTest.createSync(recursive: true);
      output.msg("File test ${fileTest.path} created");
      fileTest.writeAsStringSync(generatorTest(
          formatName(name),
          await getNamePackage(),
          file.path,
          nameModule != null ? formatName(nameModule) : null,
          module?.path));
      formatFile(fileTest);
    }

    output.success("$type created");
  } catch (e) {
    output.error(e);
    exit(1);
  }
}

void formatFile(File file) {
  Process.runSync("flutter", ["format", file.absolute.path], runInShell: true);
}

Future<File> addModule(String nameCap, String path, bool isBloc) async {
  int index;
  File module = findModule(path);

  if (module == null) {
    output.error("Module not found");
    exit(1);
  }

  var node = module.readAsStringSync().split("\n");
  node.insert(0,
      "  import 'package:${await getNamePackage()}/${path.replaceFirst("lib/", "").replaceAll("\\", "/")}';");

  if (isBloc) {
    index = node.indexWhere((t) => t.contains("blocs => ["));
    node[index] = node[index]
        .replaceFirst("blocs => [", "blocs => [Bloc((i) => ${nameCap}()),");
  } else {
    index = node.indexWhere((t) => t.contains("dependencies => ["));
    node[index] = node[index].replaceFirst("dependencies => [",
        "dependencies => [Dependency((i) => ${nameCap}()),");
  }

  module.writeAsStringSync(node.join("\n"));
  formatFile(module);
  output.success("${module.path} modified");

  return module;
}

File findModule(String path) {
  var dir = Directory(path);
  bool loop = true;
  int count = 0;
  File module;
  do {
    module = search(dir);
    dir = dir.parent;
    loop = module == null && basename(dir.path) != 'lib' && count < 10;
    count++;
  } while (loop);
  module = File(module.path.replaceAll("\\", "/"));
  return module;
}

File search(Directory dir) {
  try {
    return dir
        .listSync()
        .firstWhere((f) => f is File && f.path.contains("_module.dart"));
  } catch (e) {
    return null;
  }
}

void createStaticFile(String path, String content) {
  try {
    File file = File(path)
      ..createSync(recursive: true)
      ..writeAsStringSync(content);
    formatFile(file);
    output.success("${file.path} created");
  } catch (e) {
    output.error(e);
    exit(1);
  }
}