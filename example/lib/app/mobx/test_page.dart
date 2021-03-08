import 'package:flutter_modular/flutter_modular.dart';
import 'package:example/app/mobx/test_store.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  final String title;
  const TestPage({Key? key, this.title = "TestPage"}) : super(key: key);
  @override
  TestPageState createState() => TestPageState();
}
class TestPageState extends State<TestPage> {
  final TestStore store = Modular.get();

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