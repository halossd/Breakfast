// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness/pages/home.dart';

//Widget test
void main() {
  testWidgets('test search field', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: HomePage(),
    ));

    await tester.enterText(find.byType(TextField), 'bread');

    expect(find.text('bread'), findsOneWidget);
  });
}
