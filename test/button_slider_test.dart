import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/main.dart'; // Replace with your app's main file import
import 'package:trip_tales/src/widgets/button_slider.dart';

void main() {
  testWidgets('ButtonSlider widget opens dialogs on button click',
      (WidgetTester tester) async {
    // Build the app and trigger frame rendering
    await tester.pumpWidget(
        MyApp()); // Replace MyApp() with the entry point of your app

    // Verify that the ButtonSlider widget is present
    expect(find.byType(ButtonSlider), findsOneWidget);

    // Perform interactions with ButtonSlider and validate behaviors
    // For example, tap on buttons within ButtonSlider to trigger dialogs
    // Ensure the dialogs are visible or pushed onto the widget tree
  });
}
