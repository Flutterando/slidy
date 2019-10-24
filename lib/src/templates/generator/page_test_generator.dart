String pageTestGenerator(String name, String packageName, String import) => '''
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:${packageName}/${import.replaceFirst("lib/", "").replaceAll("\\", "/")}';

Widget buildTestableWidget(Widget widget) {
  return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
}

main() {
  testWidgets('${name}Page has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(${name}Page(title: '${name}')));
    final titleFinder = find.text('${name}');
    expect(titleFinder, findsOneWidget);
  });
}
  ''';
