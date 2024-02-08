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
}
