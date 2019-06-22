import 'dart:io';

import 'package:slidy/src/generate.dart';
import 'package:slidy/src/package_manager.dart';
import 'package:slidy/src/utils/utils.dart';

import 'models/app_init_model.dart';
import 'models/bloc_model.dart';

import 'package:ansicolor/ansicolor.dart';


class Init {
  AnsiPen error = new AnsiPen()..red(bold: true);
  AnsiPen green = new AnsiPen()..green(bold: true);
  AnsiPen white = new AnsiPen()..white(bold: true);

  Init(args) {
   start();
  }

  start() async {
     var dir = Directory("lib");
    if(dir.listSync().length != 0){
      print(error("A pasta lib deve está completamente vazia"));
      exit(1);
    }

    String package = await getNamePackage();

    File(dir.path + "/main.dart")..createSync()..writeAsStringSync(AppInitModel().mainInit(package));

    File(dir.path + "/src/app_module.dart")..createSync(recursive: true)..writeAsStringSync(AppInitModel().appModule(package));
    File(dir.path + "/src/app_bloc.dart")..createSync(recursive: true)..writeAsStringSync(AppInitModel().appBloc());
    File(dir.path + "/src/app_widget.dart")..createSync(recursive: true)..writeAsStringSync(AppInitModel().appWidget(package));

    PackageManager().install(["install", "bloc_pattern", "rxdart", "dio"], false);
    await Future.delayed(Duration(milliseconds: 800));
    await Generate(["", ""])..module("home/home");
    await Future.delayed(Duration(milliseconds: 800));
    await Generate(["", ""])..component("home", true, false);

  }

}