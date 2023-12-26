import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/pages/home.dart';
import 'package:trip_tales/src/utils/device_info.dart';
import 'package:trip_tales/src/widgets/button.dart';

void main() {
  testWidgets('HomePage Layout', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));
    // Test if Scaffold is rendered
    expect(find.byType(Scaffold), findsOneWidget);
//  });

    // Test if Container is rendered
    expect(find.byType(Container), findsNWidgets(2));

    // Test for the presence of Widgets inside Column
    expect(find.byType(Column), findsNWidgets(4));
    // Assuming two Column widgets are expected

    // Test for the presence of Flexible widgets
    expect(find.byType(Flexible), findsNWidgets(2));
    // Two Flexible widgets expected

    expect(find.byType(Stack), findsNWidgets(2));
    expect(find.byType(Container), findsNWidgets(2));
    expect(find.byType(Positioned), findsNWidgets(3));
    expect(find.byType(ClipRRect), findsOneWidget);
    // Assuming four Containers inside Stack

    // Test buildButtons method
    expect(find.byType(OverflowBar), findsOneWidget);
    expect(find.byType(CustomButton), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
  });

  testWidgets('HomePage container size', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));
    final containerFinder = find.byKey(const Key('container1Key'));
    expect(containerFinder, findsOneWidget);
    final container = tester.widget<Container>(containerFinder);
    // expect(container.constraints!.minWidth, DeviceInfo().width);
    //expect(container.constraints!.maxWidth, DeviceInfo().width);
    // expect(container.constraints!.minHeight, DeviceInfo().height);
    //expect(container.constraints!.maxHeight, DeviceInfo().height);
  });

  testWidgets('HomePage logo', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));
    expect(find.byKey(const Key('logoKey')), findsOneWidget);
  });

  testWidgets('HomePage motto', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));
    // Test for specific text or UI elements
    expect(find.text('Live'), findsOneWidget);
    expect(find.text('Feel'), findsOneWidget);
    expect(find.text('Discover'), findsOneWidget);
  });

  testWidgets('HomePage login button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));
    expect(find.byKey(const Key('loginCustomButtonKey')), findsOneWidget);
  });

  testWidgets(
    'HomePage create account button',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));
      expect(find.byKey(const Key('createAccountCustomButtonKey')),
          findsOneWidget);
    },
  );
}
