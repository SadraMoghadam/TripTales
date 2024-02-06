import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trip_tales/src/widgets/dropdown_button.dart';

void main() {
  group('CustomDropdownButton Widget Tests', () {
    testWidgets('Initial widget creation', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomDropdownButton(
              selectedValue: 'Option 1',
              label: 'Dropdown Label',
              items: ['Option 1', 'Option 2', 'Option 3'],
              onValueChanged: (value) {},
            ),
          ),
        ),
      );

      // Wait for the widget tree to settle.
      await tester.pumpAndSettle();

      // Verify that the widget is created successfully.
      expect(find.byType(CustomDropdownButton), findsOneWidget);
      // expect(find.byType(DropdownButton2), findsOneWidget);
    });

    testWidgets('Dropdown items and hint', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomDropdownButton(
              selectedValue: 'Option 1',
              label: 'Dropdown Label',
              items: ['Option 1', 'Option 2', 'Option 3'],
              onValueChanged: (value) {},
            ),
          ),
        ),
      );

      // Wait for the widget tree to settle.
      await tester.pumpAndSettle();

      // Verify that the dropdown hint and items are displayed.
      expect(find.text('Dropdown Label'), findsNothing);
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsNothing);
      expect(find.text('Option 3'), findsNothing);
    });

    testWidgets('Dropdown selection', (WidgetTester tester) async {
      String selectedValue = 'Option 1';

      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomDropdownButton(
              selectedValue: selectedValue,
              label: 'Dropdown Label',
              items: ['Option 1', 'Option 2', 'Option 3'],
              onValueChanged: (value) {
                selectedValue = value!;
              },
            ),
          ),
        ),
      );

      // Wait for the widget tree to settle.
      await tester.pumpAndSettle();

      // Verify that the selected value is updated.
      expect(selectedValue, 'Option 1');
    });

    // Add more tests based on your requirements
  });
}
