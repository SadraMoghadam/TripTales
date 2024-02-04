/*
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/widgets/dropdown_button.dart';

void main() {
  testWidgets('CustomDropdownButton initial state',
      (WidgetTester tester) async {
    final List<String> items = ['Item 1', 'Item 2', 'Item 3'];
    const label = 'Select an item';

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomDropdownButton(label: label, items: items, selectedValue: '', onValueChanged: (String? ) {  },),
      ),
    ));

    // Find the CustomDropdownButton widget
    final customDropdownButtonFinder = find.byType(CustomDropdownButton);

    // Check if the widget is present
    expect(customDropdownButtonFinder, findsOneWidget);

    // Verify the initial label and no selected value
    expect(find.text(label), findsOneWidget);
    expect(find.text('Item 1'), findsNothing);
  });

  testWidgets('CustomDropdownButton interaction', (WidgetTester tester) async {
    final List<String> items = ['Item 1', 'Item 2', 'Item 3'];
    const label = 'Select an item';

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomDropdownButton(label: label, items: items),
      ),
    ));

    // Find the CustomDropdownButton widget
    final customDropdownButtonFinder = find.byType(CustomDropdownButton);

    // Check if the widget is present
    expect(customDropdownButtonFinder, findsOneWidget);

    // Tap the dropdown to open
    await tester.tap(customDropdownButtonFinder);
    await tester.pumpAndSettle();

    // Tap the first item in the dropdown
    await tester.tap(find.text('Item 1').last);
    await tester.pumpAndSettle();

    // Verify that the selected value is updated
    expect(find.text('Item 1'), findsOneWidget);
  });
  ;

  testWidgets('CustomDropdownButton error handling',
      (WidgetTester tester) async {
    final List<String> items = []; // Empty items list

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomDropdownButton(label: 'Select an item', items: items),
      ),
    ));

    // Find the CustomDropdownButton widget
    final customDropdownButtonFinder = find.byType(CustomDropdownButton);

    // Check if the widget is present
    expect(customDropdownButtonFinder, findsOneWidget);

    // Tap the dropdown to open (shouldn't throw an error with empty items)
    await tester.tap(customDropdownButtonFinder);
    await tester.pumpAndSettle();

    // Verify that no items are available in the dropdown
    expect(find.byType(DropdownMenuItem), findsNothing);
  });

  testWidgets('CustomDropdownButton state changes',
      (WidgetTester tester) async {
    final List<String> items = ['Item 1', 'Item 2', 'Item 3'];
    const label = 'Select an item';

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomDropdownButton(label: label, items: items),
      ),
    ));

    // Find the CustomDropdownButton widget
    final customDropdownButtonFinder = find.byType(CustomDropdownButton);

    // Check if the widget is present
    expect(customDropdownButtonFinder, findsOneWidget);

    // Verify the initial state
    expect(find.text('Item 1'), findsNothing);

    // Tap the dropdown to open
    await tester.tap(customDropdownButtonFinder);
    await tester.pumpAndSettle();

    // Tap the second item in the dropdown
    await tester.tap(find.text('Item 2').last);
    await tester.pumpAndSettle();

    // Verify the updated selected value
    expect(find.text('Item 2'), findsOneWidget);
  });

  testWidgets('CustomDropdownButton error handling with null items',
      (WidgetTester tester) async {
    List<String>? items; // Null items list

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomDropdownButton(label: 'Select an item', items: items ?? []),
      ),
    ));

    // Find the CustomDropdownButton widget
    final customDropdownButtonFinder = find.byType(CustomDropdownButton);

    // Check if the widget is present
    expect(customDropdownButtonFinder, findsOneWidget);

    // Tap the dropdown to open (shouldn't throw an error with null items)
    await tester.tap(customDropdownButtonFinder);
    await tester.pumpAndSettle();

    // Verify that no items are available in the dropdown
    expect(find.byType(DropdownMenuItem), findsNothing);
  });

  testWidgets('CustomDropdownButton state restoration',
      (WidgetTester tester) async {
    final List<String> items = ['Item 1', 'Item 2', 'Item 3'];
    const label = 'Select an item';

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return CustomDropdownButton(label: label, items: items);
          },
        ),
      ),
    ));

    // Find the CustomDropdownButton widget
    final customDropdownButtonFinder = find.byType(CustomDropdownButton);

    // Check if the widget is present
    expect(customDropdownButtonFinder, findsOneWidget);

    // Tap the dropdown to open and select an item
    await tester.tap(customDropdownButtonFinder);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Item 2').hitTestable());
    await tester.pumpAndSettle();

    // Rebuild the widget tree to simulate state restoration
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return CustomDropdownButton(label: label, items: items);
          },
        ),
      ),
    ));

    // Verify that the selected value is restored
    expect(find.text('Item 2'), findsOneWidget);
  });

  testWidgets('CustomDropdownButton item visibility',
      (WidgetTester tester) async {
    final List<String> items = ['Item 1', 'Item 2', 'Item 3'];
    const label = 'Select an item';

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomDropdownButton(label: label, items: items),
      ),
    ));

    // Find the CustomDropdownButton widget
    final customDropdownButtonFinder = find.byType(CustomDropdownButton);

    // Check if the widget is present
    expect(customDropdownButtonFinder, findsOneWidget);

    // Tap the dropdown to open
    await tester.tap(customDropdownButtonFinder);
    await tester.pumpAndSettle();

    // Verify the visibility of items in the dropdown
    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Item 2'), findsOneWidget);
    expect(find.text('Item 3'), findsOneWidget);
  });

  testWidgets('CustomDropdownButton menu height', (WidgetTester tester) async {
    final List<String> items =
        List.generate(10, (index) => 'Item $index'); // 10 items in the dropdown

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomDropdownButton(label: 'Select an item', items: items),
      ),
    ));

    // Find the CustomDropdownButton widget
    final customDropdownButtonFinder = find.byType(CustomDropdownButton);

    // Check if the widget is present
    expect(customDropdownButtonFinder, findsOneWidget);

    // Tap the dropdown to open
    await tester.tap(customDropdownButtonFinder);
    await tester.pumpAndSettle();

    // Find the dropdown items
    final dropdownItems = find.byType(DropdownMenuItem);

    // Check the height of the dropdown items (assuming all items have the same height)
    final itemWidgets = tester.widgetList(dropdownItems).toList();
    final itemRenderObjects = itemWidgets
        .map((widget) => tester.renderObject(find.byWidget(widget)))
        .toList();

    // Calculate the total height of all items
    final totalHeight = itemRenderObjects.fold<double>(
      0,
      (previousValue, element) => previousValue + element.semanticBounds.height,
    );

    // Verify that the total height is within an acceptable range
    expect(
        totalHeight,
        lessThan(
            100)); // Adjust the threshold based on your item height and count
  });

  testWidgets('CustomDropdownButton icon visibility',
      (WidgetTester tester) async {
    final List<String> items = ['Item 1', 'Item 2', 'Item 3'];
    const label = 'Select an item';

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomDropdownButton(label: label, items: items),
      ),
    ));

    // Find the CustomDropdownButton widget
    final customDropdownButtonFinder = find.byType(CustomDropdownButton);

    // Check if the widget is present
    expect(customDropdownButtonFinder, findsOneWidget);

    // Verify the visibility of the dropdown icon
    expect(find.byIcon(Icons.arrow_forward_ios_outlined), findsOneWidget);
  });

  testWidgets('CustomDropdownButton button width', (WidgetTester tester) async {
    final List<String> items = ['Item 1', 'Item 2', 'Item 3'];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomDropdownButton(label: 'Select an item', items: items),
      ),
    ));

    // Find the CustomDropdownButton widget
    final customDropdownButtonFinder = find.byType(CustomDropdownButton);

    // Check if the widget is present
    expect(customDropdownButtonFinder, findsOneWidget);

    // Get the width of the dropdown button
    final RenderBox buttonBox = tester.renderObject(customDropdownButtonFinder);
    final buttonWidth = buttonBox.size.width;

    // Verify that the dropdown button width matches the expected width
    expect(buttonWidth, equals(300.0)); // Assuming a fixed width of 300.0
  });
  ;

  testWidgets('CustomDropdownButton item selection and state update',
      (WidgetTester tester) async {
    final List<String> items = ['Item 1', 'Item 2', 'Item 3'];
    const label = 'Select an item';

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return CustomDropdownButton(label: label, items: items);
          },
        ),
      ),
    ));

    // Find the CustomDropdownButton widget
    final customDropdownButtonFinder = find.byType(CustomDropdownButton);

    // Check if the widget is present
    expect(customDropdownButtonFinder, findsOneWidget);

    // Tap the dropdown and select an item
    await tester.tap(customDropdownButtonFinder);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Item 2').hitTestable());
    await tester.pumpAndSettle();

    // Verify that the selected value is updated in the widget's state
    expect(find.text('Item 2'), findsOneWidget);
  });

  testWidgets('CustomDropdownButton default selection',
      (WidgetTester tester) async {
    final List<String> items = ['Item 1', 'Item 2', 'Item 3'];
    const String defaultSelectedItem =
        'Item 2'; // Set the default selected item

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomDropdownButton(label: 'Select an item', items: items),
      ),
    ));

    // Find the CustomDropdownButton widget
    final customDropdownButtonFinder = find.byType(CustomDropdownButton);

    // Check if the widget is present
    expect(customDropdownButtonFinder, findsOneWidget);

    // Tap the dropdown to open
    await tester.tap(customDropdownButtonFinder);
    await tester.pumpAndSettle();

    // Verify if the default item is selected
    expect(find.text(defaultSelectedItem), findsOneWidget);
  });

  testWidgets('CustomDropdownButton item selection',
      (WidgetTester tester) async {
    final List<String> items = ['Item 1', 'Item 2', 'Item 3'];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomDropdownButton(label: 'Select an item', items: items),
      ),
    ));

    // Find the CustomDropdownButton widget
    final customDropdownButtonFinder = find.byType(CustomDropdownButton);

    // Check if the widget is present
    expect(customDropdownButtonFinder, findsOneWidget);

    // Tap the dropdown to open
    await tester.tap(customDropdownButtonFinder);
    await tester.pumpAndSettle();

    // Tap an item in the dropdown
    await tester.tap(find.text('Item 3'));
    await tester.pumpAndSettle();

    // Verify if the selected item is as expected
    expect(find.text('Item 3'), findsOneWidget);
  });

  testWidgets('CustomDropdownButton with empty items',
      (WidgetTester tester) async {
    final List<String> items = []; // Empty items list

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomDropdownButton(label: 'Select an item', items: items),
      ),
    ));

    // Find the CustomDropdownButton widget
    final customDropdownButtonFinder = find.byType(CustomDropdownButton);

    // Check if the widget is present
    expect(customDropdownButtonFinder, findsOneWidget);

    // Verify if the dropdown shows a hint or placeholder for an empty list
    expect(find.text('Select an item'), findsOneWidget);
  });
  testWidgets('CustomDropdownButton visibility toggle',
      (WidgetTester tester) async {
    final List<String> items = ['Item 1', 'Item 2', 'Item 3'];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomDropdownButton(label: 'Select an item', items: items),
      ),
    ));

    // Find the CustomDropdownButton widget
    final customDropdownButtonFinder = find.byType(CustomDropdownButton);

    // Check if the widget is present
    expect(customDropdownButtonFinder, findsOneWidget);

    // Verify if the dropdown is initially closed
    expect(find.text('Item 1'), findsNothing);

    // Tap the dropdown to open
    await tester.tap(customDropdownButtonFinder);
    await tester.pumpAndSettle();

    // Verify if the dropdown is now open
    expect(find.text('Item 1'), findsOneWidget);

    // Tap again to close the dropdown
    await tester.tap(customDropdownButtonFinder);
    await tester.pumpAndSettle();

    // Verify if the dropdown is closed again
    expect(find.text('Item 1'), findsNothing);
  });

  testWidgets('CustomDropdownButton with null items list',
      (WidgetTester tester) async {
    List<String>? items; // Null items list

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomDropdownButton(label: 'Select an item', items: items ?? []),
      ),
    ));

    // Find the CustomDropdownButton widget
    final customDropdownButtonFinder = find.byType(CustomDropdownButton);

    // Check if the widget is present
    expect(customDropdownButtonFinder, findsOneWidget);

    // Verify if the dropdown shows a hint or placeholder for a null list
    expect(find.text('Select an item'), findsOneWidget);
  });
}
*/