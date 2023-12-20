import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/pages/create_tale_page.dart';
import 'package:trip_tales/src/screen/set_photo_screen.dart';
import 'package:trip_tales/src/widgets/app_bar_tale.dart';
import 'package:trip_tales/src/widgets/canvas_card.dart';
import 'package:trip_tales/src/widgets/tale_card.dart';

void main() {
  testWidgets('MyTalesPage layout', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(home: CreateTalePage()));

    // Test if the Scaffold is rendered
    expect(find.byType(Scaffold), findsNWidgets(2));

    // Test if the SingleChildScrollView is rendered
    expect(find.byType(SingleChildScrollView), findsNWidgets(2));

    // Check if main widgets are present
    expect(find.byType(Container), findsNWidgets(13));
    expect(find.byType(Column), findsNWidgets(4));
    expect(find.byType(Flexible), findsOneWidget);
    expect(find.byType(SizedBox), findsNWidgets(21));
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(CustomCanvas), findsNWidgets(6));
    expect(find.byType(SetPhotoScreen), findsOneWidget);
  });

  testWidgets('MyTalesPage Tale Name Text Field', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(home: CreateTalePage()));
    final taleNameTextFieldFinder =
        find.byKey(const Key('taleNameCustomTextFieldKey'));
    expect(taleNameTextFieldFinder, findsOneWidget);

    // Enter some text into the tale name field
    await tester.enterText(taleNameTextFieldFinder, 'a tale name');
    // clean the text from the tale name field
    await tester.enterText(taleNameTextFieldFinder, '');
    // trigger validation
    await tester.pump();
    // verify "Tale name" hint is displayed
    expect(find.text('Tale Name'), findsOneWidget);
    // Enter text into password form field again
    await tester.enterText(taleNameTextFieldFinder, 'new tale name');
    // Trigger validation
    await tester.pump();
    expect(find.text('Tale Name'), findsOneWidget);
  });

  testWidgets('MyTalesPage Start Creating Button', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(home: CreateTalePage()));
    expect(
        find.byKey(const Key('startCreatingCustomButtonKey')), findsOneWidget);
  });
}
