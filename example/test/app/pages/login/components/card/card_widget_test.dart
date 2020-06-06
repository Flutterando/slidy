import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/app/pages/login/components/card/card_widget.dart';

Widget buildTestableWidget(Widget widget) {
  return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
}

main() {
  testWidgets('CardWidget has message', (tester) async {
    await tester.pumpWidget(buildTestableWidget(CardWidget()));
    final textFinder = find.text('Card');
    expect(textFinder, findsOneWidget);
  });
}
