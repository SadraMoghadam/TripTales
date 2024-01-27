import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/pages/my_tales.dart';
import 'package:trip_tales/src/widgets/app_bar_tale.dart';
import 'package:trip_tales/src/widgets/tale_card.dart';

void main() {
  testWidgets('MyTalesPage layout', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(home: MyTalesPage()));

    // Test if the Scaffold is rendered
    expect(find.byType(Scaffold), findsNWidgets(2));

    // Test if the SingleChildScrollView is rendered
    expect(find.byType(SingleChildScrollView), findsOneWidget);

    // Check if main widgets are present
    expect(find.byType(CustomTale), findsNWidgets(7));
    expect(find.byType(Container), findsNWidgets(22));
    expect(find.byType(Column), findsNWidgets(2));
    expect(find.byType(Flexible), findsOneWidget);
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(CustomTale), findsNWidgets(7));
  });
  testWidgets('MyTalesPage builds correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: MyTalesPage()));

    expect(find.byType(CustomTale),
        findsNWidgets(7)); // Expects to find 7 CustomTale widgets
    expect(find.text('Create new Tale'),
        findsOneWidget); // Expects to find a specific tale name
  });

  testWidgets('Testing on different screen sizes', (WidgetTester tester) async {
    // Testing on a larger screen
    tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
    tester.binding.window.devicePixelRatioTestValue = 2.0;
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

    await tester.pumpWidget(MaterialApp(home: MyTalesPage()));
    // Add expectations for the layout on larger screens

    // Testing on a smaller screen
    tester.binding.window.physicalSizeTestValue = Size(320, 480);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

    await tester.pumpWidget(MaterialApp(home: MyTalesPage()));
    // Add expectations for the layout on smaller screens
  });

  testWidgets('Testing performance', (WidgetTester tester) async {
    final Stopwatch stopwatch = Stopwatch()..start();

    // Measure the time taken to build the widget
    await tester.pumpWidget(MaterialApp(home: MyTalesPage()));

    stopwatch.stop();
    print('Widget build time: ${stopwatch.elapsedMilliseconds}ms');
  });
}
