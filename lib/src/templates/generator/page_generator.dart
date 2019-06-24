String pageGenerator(String name) => '''
import 'package:flutter/material.dart';

class ${name}Page extends StatefulWidget {
  @override
  _${name}PageState createState() => _${name}PageState();
}

class _${name}PageState extends State<${name}Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$name"),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
  ''';
