import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/pages/create_image_page.dart';
import 'package:trip_tales/src/pages/create_text_page.dart';
import 'package:trip_tales/src/pages/create_video_page.dart';
import 'package:trip_tales/src/widgets/button_slider.dart';

void main() {
  testWidgets('ButtonSlider widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ButtonSlider(callback: () {}),
        ),
      ),
    );

    // Verify the initial state of the widget
    expect(find.byType(ButtonSlider), findsOneWidget);
    expect(find.text('Add Memory'), findsNothing);
  });

  testWidgets('ButtonSlider widget test 2', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ButtonSlider(callback: () {}),
        ),
      ),
    );

    // Verify the initial state of the widget
    expect(find.byType(ButtonSlider), findsOneWidget);
    expect(find.text('Add Memory'), findsNothing);
    // Tap on the button to open the menu
    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();

    // Verify that the menu is open
    expect(find.byType(SlideTransition), findsWidgets);
    expect(find.byType(Icon), findsNWidgets(3));

    // Tap on the image button
    await tester.tap(find.byIcon(Icons.image));
    await tester.pumpAndSettle();

    // Verify that the CreateImagePage is opened
    expect(find.byType(CreateImagePage), findsOneWidget);

    // Tap on the video button
    await tester.tap(find.byIcon(Icons.video_library_rounded));
    await tester.pumpAndSettle();

    // Verify that the CreateVideoPage is opened
    expect(find.byType(CreateVideoPage), findsOneWidget);

    // Tap on the text button
    await tester.tap(find.byIcon(Icons.text_snippet_rounded));
    await tester.pumpAndSettle();

    // Verify that the CreateTextPage is opened
    expect(find.byType(CreateTextPage), findsOneWidget);
  });

  testWidgets('ButtonSlider widget opens and closes menu',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ButtonSlider(callback: () {}),
        ),
      ),
    );

    // Verify the initial state of the widget
    expect(find.byType(ButtonSlider), findsOneWidget);
    expect(find.text('Add Memory'), findsOneWidget);

    // Tap on the button to open the menu
    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();

    // Verify that the menu is open
    expect(find.byType(SlideTransition), findsWidgets);
    expect(find.byType(Icon), findsNWidgets(3));

    // Tap on the button again to close the menu
    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();

    // Verify that the menu is closed
    expect(find.byType(SlideTransition), findsNothing);
    expect(find.byType(Icon), findsNothing);
  });

  testWidgets(
      'ButtonSlider widget triggers callback when memory type buttons are tapped',
      (WidgetTester tester) async {
    bool callbackTriggered = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ButtonSlider(
            callback: () {
              callbackTriggered = true;
            },
          ),
        ),
      ),
    );

    // Verify the initial state of the widget
    expect(callbackTriggered, isFalse);

    // Tap on the image button
    await tester.tap(find.byIcon(Icons.image));
    await tester.pumpAndSettle();

    // Verify that the callback is triggered
    expect(callbackTriggered, isTrue);
  });

  testWidgets('ButtonSlider widget opens and closes menu with animation',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ButtonSlider(callback: () {}),
        ),
      ),
    );

    // Verify the initial state of the widget
    expect(find.byType(ButtonSlider), findsOneWidget);
    expect(find.text('Add Memory'), findsOneWidget);

    // Verify that the menu is initially closed
    expect(find.byType(SlideTransition), findsNothing);

    // Tap on the button to open the menu
    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();

    // Verify that the menu is open with animation
    expect(find.byType(SlideTransition), findsWidgets);
    expect(find.byType(Icon), findsNWidgets(3));

    // Tap on the button again to close the menu
    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();

    // Verify that the menu is closed with animation
    expect(find.byType(SlideTransition), findsNothing);
    expect(find.byType(Icon), findsNothing);
  });

  testWidgets(
      'ButtonSlider widget opens menu and triggers callback when memory type buttons are tapped',
      (WidgetTester tester) async {
    bool callbackTriggered = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ButtonSlider(
            callback: () {
              callbackTriggered = true;
            },
          ),
        ),
      ),
    );

    // Verify the initial state of the widget
    expect(callbackTriggered, isFalse);

    // Tap on the image button
    await tester.tap(find.byIcon(Icons.image));
    await tester.pumpAndSettle();

    // Verify that the callback is triggered
    expect(callbackTriggered, isTrue);

    // Reset callback state
    callbackTriggered = false;

    // Tap on the video button
    await tester.tap(find.byIcon(Icons.video_library_rounded));
    await tester.pumpAndSettle();

    // Verify that the callback is triggered
    expect(callbackTriggered, isTrue);

    // Reset callback state
    callbackTriggered = false;

    // Tap on the text button
    await tester.tap(find.byIcon(Icons.text_snippet_rounded));
    await tester.pumpAndSettle();

    // Verify that the callback is triggered
    expect(callbackTriggered, isTrue);
  });
}
