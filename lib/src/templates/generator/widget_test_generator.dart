import 'package:slidy/src/utils/object_generate.dart';

String widgetTestGenerator(ObjectGenerate obj) {
  String package;
  if (obj.isModular) {
    package = r"import 'package:flutter_modular/flutter_modular_test.dart'";
  } else {
    package = r"import 'package:bloc_pattern/bloc_pattern_test.dart'";
  }

  return '''
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
$package;

import 'package:${obj.packageName}/${obj.import.replaceFirst("lib/", "").replaceAll("\\", "/")}';

main() {
//  testWidgets('${obj.name}Widget has message', (WidgetTester tester) async {
//    await tester.pumpWidget(buildTestableWidget(${obj.name}Widget()));
//    final textFinder = find.text('${obj.name}');
//    expect(textFinder, findsOneWidget);
//  });
}
  ''';
}

String widgetTestGeneratorWithoutSuffix(ObjectGenerate obj) {
  String package;
  if (obj.isModular) {
    package = r"import 'package:flutter_modular/flutter_modular_test.dart'";
  } else {
    package = r"import 'package:bloc_pattern/bloc_pattern_test.dart'";
  }
  return '''
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test/flutter_test.dart';
$package;
import 'package:${obj.packageName}/${obj.import.replaceFirst("lib/", "").replaceAll("\\", "/")}';

main() {
  testWidgets('${obj.name} has message', (WidgetTester tester) async {
 //   await tester.pumpWidget(buildTestableWidget(${obj.name}()));
 //   final textFinder = find.text('${obj.name}');
 //   expect(textFinder, findsOneWidget);
  });
}
  ''';
}
