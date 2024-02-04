import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/widgets/app_bar_tale.dart';
import 'package:trip_tales/src/widgets/menu_bar_tale.dart';

void main() {
  testWidgets('CustomMenu widget renders without crashing',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CustomMenu(),
      ),
    );

    // Verify that the widget renders without any errors
    expect(find.byType(CustomMenu), findsOneWidget);
  });

  testWidgets('CustomMenu widget displays loading animation for index 0',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CustomMenu(index: 0),
      ),
    );

    // Verify that the loading animation is displayed
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('CustomMenu widget displays CustomAppBar for index other than 0',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CustomMenu(index: 1),
      ),
    );

    // Verify that CustomAppBar is displayed
    expect(find.byType(CustomAppBar), findsOneWidget);
  });
}
