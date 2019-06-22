import 'dart:io';
import 'package:path/path.dart';
import 'package:slidy/src/models/repository_model.dart';
import 'package:slidy/src/utils/utils.dart';

import 'models/bloc_model.dart';

import 'package:slidy/src/models/modulo_model.dart';
import 'package:ansicolor/ansicolor.dart';

import 'models/page_model.dart';
import 'models/widget_model.dart';

class Generate {
  AnsiPen error = new AnsiPen()..red(bold: true);
  AnsiPen green = new AnsiPen()..green(bold: true);
  AnsiPen white = new AnsiPen()..white(bold: true);

  Generate(args) {
    if (args[1] == 'module' || args[1] == 'm') {
      module(args[2]);
    } else if (args[1] == 'page' || args[1] == 'p') {
      component(args[2], true, checkParam(args, "-b"));
    } else if (args[1] == 'widget' || args[1] == 'w') {
      component(args[2], false, checkParam(args, "-b"));
    } else if (args[1] == 'bloc' || args[1] == 'b') {
      bloc(args[2]);
    } else if (args[1] == 'repository' || args[1] == 'r') {
      repository(args[2]);
    } else {
      print("Generate: Invalid Command");
    }
  }

  module(String path) async {
    path = validPath(path);

    print("Criando módulo....");
    try {
      Directory directory = Directory(path).parent;
      String name = basename(path);
      String nameCap = formatName(name);

      print("Criando arquivo...");

      File page = new File("${directory.path}/$name\_module.dart");
      if (page.existsSync()) {
        throw Exception("O arquivo especificado já existe");
      } else {
        page.createSync(recursive: true);
      }

      String values = ModuloModel.model(nameCap);
      File f = await page.writeAsString(values, mode: FileMode.write);

      print("Criado arquivo ${white(page.path)}");

      Process.runSync("flutter", ["format", f.absolute.path], runInShell: true);

      print(green("Completed!"));
    } catch (e) {
      print(error("${e.message}"));
    }
  }

  component(String path, bool isPage, bool blocLess) async {
    path = validPath(path);
    String name = basename(path);
    name = resolveName(name);
    String nameCap = formatName(name);

    print(white("Criando view..."));

    var fileview =
        File(path + "/" + "${name}_${isPage ? 'page' : 'widget'}.dart");
    if (fileview.existsSync()) {
      print(error("Já existe um component $name"));
      exit(1);
    } else {
      fileview.createSync(recursive: true);
    }
    fileview.writeAsStringSync(
        isPage ? PageModel().model(nameCap) : WidgetModel().model(nameCap));
    Process.runSync("flutter", ["format", fileview.path], runInShell: true);
    print("Criado arquivo ${white(fileview.path)}");

    //create bloc

    if (blocLess) {
      print(white("Criando bloc..."));

      var filebloc = File(path + "/" + "${name}_bloc.dart");
      if (filebloc.existsSync()) {
        print(error("Já existe um component $name"));
        exit(1);
      } else {
        filebloc.createSync(recursive: true);
      }

      filebloc.writeAsStringSync(BlocModel().model(nameCap));
      Process.runSync("flutter", ["format", filebloc.path], runInShell: true);
      print("Criado arquivo ${white(filebloc.path)}");
      await addModule(nameCap, filebloc.path, ModuleType.BLOC);
    }

    print(green("Completed!"));
  }

  bloc(String path) async {
    path = validPath(path);
    String name = basename(path);
    name = resolveName(name);
    var filebloc = File(Directory(path).parent.path + "/${name}_bloc.dart");

    if (filebloc.existsSync()) {
      print(error("Já existe um BLOC $name"));
      exit(1);
    }

    if (!Directory(path).parent.existsSync()) {
      Directory(path).parent.createSync(recursive: true);
    }

    print(white("Criando arquivo..."));
    String nameCap = formatName(name);
    filebloc.createSync();
    filebloc.writeAsStringSync(BlocModel().model(nameCap));
    Process.runSync("flutter", ["format", filebloc.path], runInShell: true);
    print("Criado arquivos ${white(filebloc.path)}");
    await addModule(nameCap, filebloc.path, ModuleType.BLOC);
    print(green("Completed!"));
  }

  repository(String path) async {
    path = validPath(path);
    String name = basename(path);
    name = resolveName(name);
    var filerepo =
        File(Directory(path).parent.path + "/${name}_repository.dart");
    if (filerepo.existsSync()) {
      print(error("Já existe um Repository $name"));
      exit(1);
    }

    if (!Directory(path).parent.existsSync()) {
      Directory(path).parent.createSync(recursive: true);
    }

    print(white("Criando arquivo..."));
    String nameCap = formatName(name);
    filerepo.createSync();
    filerepo.writeAsStringSync(RepositoryModel().model(nameCap));
    Process.runSync("flutter", ["format", filerepo.path], runInShell: true);
    print("Criado arquivos ${white(filerepo.path)}");
    await addModule(nameCap, filerepo.path, ModuleType.REPOSITORY);
    print(green("Completed!"));
  }

  addModule(String nameCap, String path, ModuleType type) async {
    File module = findModule(path);

    if (module == null) {
      print(error("Nenhum módulo encontrado"));
      exit(1);
    } else {
      module = File(module.path.replaceAll("\\", "/"));
    }

    var node = module.readAsStringSync().split("\n");
    node.insert(0,
        "import 'package:${await getNamePackage()}/${path.replaceFirst("lib/", "").replaceAll("\\", "/")}';");

    if (ModuleType.BLOC == type) {
      int index = node.indexWhere((t) => t.contains("blocs => ["));

      node[index] = node[index].replaceFirst(
          "blocs => [", "blocs => [Bloc((i) => ${nameCap}Bloc()),");
    } else if (ModuleType.REPOSITORY == type) {
      int index = node.indexWhere((t) => t.contains("dependencies => ["));
      node[index] = node[index].replaceFirst("dependencies => [",
          "dependencies => [Dependency((i) => ${nameCap}Repository()),");
    } else {
      print(error("Nenhum tipo selecionado"));
    }

    module.writeAsStringSync(node.join("\n"));
    Process.runSync("flutter", ["format", module.path], runInShell: true);
    print("Modificado ${white(module.path)}");
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

  String validPath(String path) {
    return "lib/src/$path";
  }
}

enum ModuleType {
  BLOC,
  REPOSITORY,
}
