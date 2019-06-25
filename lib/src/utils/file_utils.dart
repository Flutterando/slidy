import 'dart:io';
import 'package:path/path.dart';
import 'package:slidy/src/utils/utils.dart';
import 'package:slidy/src/utils/output_utils.dart' as output;

void createFile(String path, String type, Function generator) async {
  output.msg("Creating $type...");

  path = libPath(path);

  Directory dir = Directory(path).parent;
  String name = basename(path);

  File file =
      File('${dir.path}/${name}_${type.replaceAll("_complete", "")}.dart');

  if (file.existsSync()) {
    output.error("already exists a $type $name");
    exit(1);
  }

  try {
    file.createSync(recursive: true);
    output.msg("File ${file.path} created");

    if (type == 'module_complete') {
      String package = await getNamePackage();
      file.writeAsStringSync(generator(package, formatName(name)));
    } else if (type == 'module') {
      file.writeAsStringSync(generator("", formatName(name)));
    } else {
      file.writeAsStringSync(generator(formatName(name)));
    }

    formatFile(file);

    if (type == 'bloc' || type == 'repository') {
      addModule(formatName(name), file.path, type == 'bloc');
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

addModule(String nameCap, String path, bool isBloc) async {
  int index;
  File module = findModule(path);

  if (module == null) {
    output.error("Module not found");
    exit(1);
  }

  module = File(module.path.replaceAll("\\", "/"));

  var node = module.readAsStringSync().split("\n");

  node.insert(0,
      "  import 'package:${await getNamePackage()}/${path.replaceFirst("lib/", "").replaceAll("\\", "/")}';");

  if (isBloc) {
    index = node.indexWhere((t) => t.contains("blocs => ["));
    node[index] = node[index]
        .replaceFirst("blocs => [", "blocs => [Bloc((i) => ${nameCap}Bloc()),");
  } else {
    index = node.indexWhere((t) => t.contains("dependencies => ["));
    node[index] = node[index].replaceFirst("dependencies => [",
        "dependencies => [Dependency((i) => ${nameCap}Repository()),");
  }

  module.writeAsStringSync(node.join("\n"));
  formatFile(module);
  output.success("${module.path} modified");
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
