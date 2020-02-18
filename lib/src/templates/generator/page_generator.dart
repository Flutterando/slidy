import 'package:slidy/src/utils/object_generate.dart';

String pageGenerator(ObjectGenerate obj) => '''
import 'package:flutter/material.dart';

class ${obj.name}Page extends StatefulWidget {
  
  final String title;
  const ${obj.name}Page({Key key, this.title = "${obj.name}"}) : super(key: key);

  @override
  _${obj.name}PageState createState() => _${obj.name}PageState();
}

class _${obj.name}PageState extends State<${obj.name}Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
  ''';

String pageGeneratorMobX(ObjectGenerate obj) => '''
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '${obj.name.toLowerCase()}_controller.dart';

class ${obj.name}Page extends StatefulWidget {
  
  final String title;
  const ${obj.name}Page({Key key, this.title = "${obj.name}"}) : super(key: key);

  @override
  _${obj.name}PageState createState() => _${obj.name}PageState();
}

class _${obj.name}PageState extends ModularState<${obj.name}Page, ${obj.name}Controller> {
  //use 'controller' variable to access controller
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
  ''';
