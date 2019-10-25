String pageTestGenerator(String name, String packageName, String import,
        String module, String pathModule) =>
    '''
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:${packageName}/${import.replaceFirst("lib/", "").replaceAll("\\", "/")}';

main() {
  testWidgets('${name}Page has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(${name}Page(title: '${name}')));
    final titleFinder = find.text('${name}');
    expect(titleFinder, findsOneWidget);
  });
}
  ''';
