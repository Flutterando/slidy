import 'package:example/app/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget buildTestableWidget(Widget widget) {
  return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
}

void main() {
  testWidgets('MyWidget has message', (tester) async {
    await tester.pumpWidget(buildTestableWidget(HomePage(title: 'Home')));
    final titleFinder = find.text('Home');
    expect(titleFinder, findsOneWidget);
  });
}
