import 'package:slidy/src/core/models/custom_file.dart';

final _mainTemplate = ''' 
main:
  - import 'package:flutter/material.dart';
  - import 'package:flutter_modular/flutter_modular.dart';
  - 
  - import 'app/app_module.dart';
  - import 'app/app_widget.dart';
  - 
  - void main() => runApp(ModularApp(module: AppModule(), child: AppWidget()));
app_module:
  - import 'package:flutter_modular/flutter_modular.dart';
  - 
  - import 'modules/home/home_module.dart';
  - 
  - class AppModule extends Module {
  -   @override
  -   final List<Bind> binds = [];
  - 
  -   @override
  -   final List<ModularRoute> routes = [
  -     ModuleRoute(Modular.initialRoute, module: HomeModule()),
  -   ];
  - 
  - }
app_widget:
  - import 'package:flutter/material.dart';
  - import 'package:flutter_modular/flutter_modular.dart';
  - 
  - class AppWidget extends StatelessWidget {
  -   @override
  -   Widget build(BuildContext context) {
  -     return MaterialApp(
  -       title: 'Flutter Slidy',
  -       theme: ThemeData(primarySwatch: Colors.blue),
  -     ).modular();
  -   }
  - }
home_page:
  - import 'package:flutter/material.dart';
  -  
  - class HomePage extends StatefulWidget {
  -   final String title;
  -   const HomePage({Key? key, this.title = 'Home'}) : super(key: key);
  -  
  -   @override
  -   _HomePageState createState() => _HomePageState();
  - }
  -  
  - class _HomePageState extends State<HomePage> {
  -   @override
  -   Widget build(BuildContext context) {
  -     return Scaffold(
  -       appBar: AppBar(
  -         title: Text(widget.title),
  -       ),
  -       body: Column(
  -         children: <Widget>[],
  -       ),
  -     );
  -   }
  - }
home_module:
  - import 'package:flutter_modular/flutter_modular.dart';
  -  
  - import 'home_page.dart';
  -  
  - class HomeModule extends Module {
  -   @override
  -   final List<Bind> binds = [];
  -  
  -   @override
  -   final List<ModularRoute> routes = [
  -     ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
  -   ];
  - }
'''
    .split('\n');

final mainFile = CustomFile(lines: _mainTemplate);
