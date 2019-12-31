String pageTestGenerator(String name, String packageName, String import,
    String module, String pathModule, bool isModular) {
  String package;
  if (isModular) {
    package = "import 'package:flutter_modular/flutter_modular_test.dart'";
  } else {
    package = "import 'package:bloc_pattern/bloc_pattern_test.dart'";
  }

  return '''
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
$package;

import 'package:${packageName}/${import.replaceFirst("lib/", "").replaceAll("\\", "/")}';

main() {
  testWidgets('${name}Page has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(${name}Page(title: '${name}')));
    final titleFinder = find.text('${name}');
    expect(titleFinder, findsOneWidget);
  });
}
  ''';
}
