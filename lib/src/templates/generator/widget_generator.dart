import 'package:slidy/src/utils/object_generate.dart';

String widgetGenerator(ObjectGenerate obj) => '''
import 'package:flutter/material.dart';
class ${obj.name}Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("textFinder"),
    );
  }
}
  ''';

String widgetGeneratorWithoutSuffix(ObjectGenerate obj) => '''
import 'package:flutter/material.dart';
class ${obj.name} extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("textFinder"),
    );
  }
}
  ''';

String widgetStatefulGenerator(ObjectGenerate obj) => '''
import 'package:flutter/material.dart';

class ${obj.name}Widget extends StatefulWidget {
  
  final String title;
  const ${obj.name}Widget({Key key, this.title = "${obj.name}"}) : super(key: key);

  @override
  _${obj.name}WidgetState createState() => _${obj.name}WidgetState();
}

class _${obj.name}WidgetState extends State<${obj.name}Widget> {
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
String widgetStatefulGeneratorWithoutSuffix(ObjectGenerate obj) => '''
import 'package:flutter/material.dart';

class ${obj.name} extends StatefulWidget {
  
  final String title;
  const ${obj.name}({Key key, this.title = "${obj.name}"}) : super(key: key);

  @override
  _${obj.name}State createState() => _${obj.name}State();
}

class _${obj.name}State extends State<${obj.name}> {
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
