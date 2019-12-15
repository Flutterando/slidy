String startMain(pkg) => '''
import 'package:flutter/material.dart';
import 'package:${pkg}/app/app_module.dart';

void main() => runApp(AppModule());
  ''';

String startMainModular(pkg) => '''
import 'package:flutter/material.dart';
import 'package:${pkg}/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() => runApp(ModularWidget(module: AppModule(),));
  ''';
