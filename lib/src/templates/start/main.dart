String startMain(pkg) => '''
import 'package:flutter/material.dart';
import 'package:${pkg}/src/app_module.dart';

void main() => runApp(AppModule());
  ''';