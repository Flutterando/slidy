class WidgetModel {
  String model(String name) => '''
import 'package:flutter/material.dart';
class ${name}Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
  ''';
}