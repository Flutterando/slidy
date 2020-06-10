import 'package:slidy/src/utils/object_generate.dart';

String pageTestGenerator(ObjectGenerate obj) {
  String package;
  if (obj.isModular) {
    package = "import 'package:flutter_modular/flutter_modular_test.dart'";
  } else {
    package = "import 'package:bloc_pattern/bloc_pattern_test.dart'";
  }

  final importPage =
      'package:${obj.packageName}/${obj.import.replaceFirst("lib/", "").replaceAll("\\", "/")}'
          .replaceFirst(
              '${obj.packageName}/${obj.packageName}', obj.packageName);

  return '''
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
$package;

import '$importPage';

main() {
  testWidgets('${obj.name}Page has title', (WidgetTester tester) async {
  //  await tester.pumpWidget(buildTestableWidget(${obj.name}Page(title: '${obj.name}')));
  //  final titleFinder = find.text('${obj.name}');
  //  expect(titleFinder, findsOneWidget);
  });
}
  ''';
}
