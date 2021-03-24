import 'package:slidy/src/core/models/custom_file.dart';

final _widgetsTemplate = r''' 
page:
  - import 'package:flutter/material.dart';
  - 
  - class $fileName|pascalcase extends StatefulWidget {
  -   final String title;
  -   const $fileName|pascalcase({Key key, this.title = "$fileName|pascalcase"}) : super(key: key);
  -   @override
  -   $fileName|pascalcaseState createState() => $fileName|pascalcaseState();
  - }
  - class $fileName|pascalcaseState extends State<$fileName|pascalcase> {
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
page_test:
  - $arg2
  - import 'package:flutter_test/flutter_test.dart';
  - import 'package:flutter_modular_test/flutter_modular_test.dart';
  - 
  - main() {
  -   group('$arg1', () {
  -     testWidgets('has a title and message', (WidgetTester tester) async {
  -       await tester.pumpWidget(buildTestableWidget($arg1(title: 'T')));
  -       final titleFinder = find.text('T');
  -       expect(titleFinder, findsOneWidget);
  -     });
  -   });
  - }
widget:
  - import 'package:flutter/material.dart';
  - 
  - class $fileName|pascalcase extends StatelessWidget {
  -   final String title;
  -   const $fileName|pascalcase({Key key, this.title = "$fileName|pascalcase"}) : super(key: key);
  - 
  -   @override
  -   Widget build(BuildContext context) {
  -     return Container(child: Text(title));
  -   }
  - }
'''
    .split('\n');

final widgetsFile = CustomFile(lines: _widgetsTemplate);
