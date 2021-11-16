import 'package:flutter_modular/flutter_modular.dart';
import 'package:example/app/modules/insurence/insurence_store.dart';
import 'package:flutter/material.dart';

class InsurencePage extends StatefulWidget {
  final String title;
  const InsurencePage({Key? key, this.title = "InsurencePage"}) : super(key: key);
  @override
  InsurencePageState createState() => InsurencePageState();
}

class InsurencePageState extends State<InsurencePage> {
  final InsurenceStore store = Modular.get();

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
