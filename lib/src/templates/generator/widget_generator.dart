String widgetGenerator(String name) => '''
import 'package:flutter/material.dart';
class ${name}Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
  ''';

String widgetGeneratorWithoutSufix(String name) => '''
import 'package:flutter/material.dart';
class ${name} extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
  ''';