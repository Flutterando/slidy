String widgetTestGenerator(String name, String packageName, String import) => '''
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:${packageName}/${import.replaceFirst("lib/", "").replaceAll("\\", "/")}';

Widget buildTestableWidget(Widget widget) {
  return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
}

main() {
  testWidgets('${name}Widget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(${name}Widget()));
    final textFinder = find.text('${name}');
    expect(textFinder, findsOneWidget);
  });
}
  ''';

  String widgetTestGeneratorWithoutSufix(String name, String packageName, String import) => '''
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:${packageName}/${import.replaceFirst("lib/", "").replaceAll("\\", "/")}';

Widget buildTestableWidget(Widget widget) {
  return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
}

main() {
  testWidgets('${name} has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(${name}()));
    final textFinder = find.text('${name}');
    expect(textFinder, findsOneWidget);
  });
}
  ''';
