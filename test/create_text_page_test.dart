import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trip_tales/src/pages/create_text_page.dart';
import 'package:trip_tales/src/services/card_service.dart';
import 'package:trip_tales/src/widgets/button.dart';
import 'package:trip_tales/src/widgets/dropdown_button.dart';
import 'package:trip_tales/src/widgets/map.dart';
import 'package:trip_tales/src/widgets/text_field.dart';

void main() {
  // Initialize GetX
  WidgetsFlutterBinding.ensureInitialized();

  // Register CardService
  Get.put<CardService>(CardService());
  testWidgets('Test CreateTextPage widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return CreateTextPage();
          },
        ),
      ),
    ));

    // Find widgets based on their keys or properties
    expect(find.text('Add new text'), findsOneWidget);
    expect(find.byType(CustomTextField), findsNWidgets(2));
    expect(find.byType(CustomDropdownButton), findsNWidgets(3));
    expect(find.byType(Slider), findsOneWidget);
    expect(find.byType(CustomButton), findsOneWidget);

    // Tap the location button and verify if the MapScreen dialog appears
    await tester.tap(find.byIcon(Icons.location_on));
    await tester.pumpAndSettle();
    expect(find.byType(MapScreen), findsOneWidget);
  });

  testWidgets('Test CreateTextPage widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return CreateTextPage();
          },
        ),
      ),
    ));

    // Find widgets based on their keys or properties
    expect(find.text('Add new text'), findsOneWidget);
    expect(find.byType(CustomTextField), findsNWidgets(2));
    expect(find.byType(CustomDropdownButton), findsNWidgets(3));
    expect(find.byType(Slider), findsOneWidget);
    expect(find.byType(CustomButton),
        findsNWidgets(2)); // Including the close button

    // Verify that the text controllers are initially empty
    final nameController = tester
        .widget<CustomTextField>(find.byType(CustomTextField).first)
        .controller;
    final textController = tester
        .widget<CustomTextField>(find.byType(CustomTextField).last)
        .controller;
    expect(nameController.text, '');
    expect(textController.text, '');

    // Enter text in the name field and verify the changes
    await tester.enterText(find.byType(CustomTextField).first, 'Test Name');
    await tester.pumpAndSettle();
    expect(nameController.text, 'Test Name');

    // Enter text in the text field and verify the changes
    await tester.enterText(find.byType(CustomTextField).last, 'Test Text');
    await tester.pumpAndSettle();
    expect(textController.text, 'Test Text');
  });
}
