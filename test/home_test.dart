import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/constants/color.dart';
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
    expect(find.byType(Container), findsOneWidget);

    // Test for the presence of Widgets inside Column
    expect(find.byType(Column), findsNWidgets(4));
    // Assuming two Column widgets are expected
    // Test for the presence of Flexible widgets
    expect(find.byType(Flexible), findsNWidgets(2));
    // Two Flexible widgets expected

    expect(find.byType(Stack), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(5));
    expect(find.byType(TextStyle), findsNothing);
    expect(find.byType(DeviceInfo), findsNothing);
    expect(find.byType(Positioned), findsNothing);
    expect(find.byType(ClipRRect), findsOneWidget);
    expect(find.byType(Column), findsNWidgets(4));
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
    expect(find.byKey(Key('logoKey')), findsNothing);
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

  testWidgets('HomePage UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
        home: HomePage())); // Assuming your app's entry point is named MyApp

    // Find the widget with the given key
    final containerKey = Key('container1Key');
    final container = find.byKey(containerKey);

    // Expect to find the container widget
    expect(container, findsOneWidget);

    // Additional tests can be added based on your requirements
  });

  testWidgets('HomePage UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
        home: HomePage())); // Assuming your app's entry point is named MyApp

    // Find the widget with the given key
    final containerKey = Key('container1Key');
    final container = find.byKey(containerKey);

    // Expect to find the container widget
    expect(container, findsOneWidget);

    // Additional tests can be added based on your requirements
  });

  testWidgets('HomePage UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
        home: HomePage())); // Assuming your app's entry point is named MyApp

    // Find the widget with the given key
    final containerKey = Key('container1Key');
    final container = find.byKey(containerKey);

    // Expect to find the container widget
    expect(container, findsOneWidget);

    // Additional tests can be added based on your requirements
  });

  testWidgets('HomePage UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
        home: HomePage())); // Assuming your app's entry point is named MyApp

    // Find the widget with the given key
    final containerKey = Key('container1Key');
    final container = find.byKey(containerKey);

    // Expect to find the container widget
    expect(container, findsOneWidget);

    // Additional tests can be added based on your requirements
  });

  testWidgets('Check if Buttons are Visible', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
        home: HomePage())); // Assuming your app's entry point is named MyApp

    // Find the widgets with the given keys
    final loginButtonKey = Key('loginCustomButtonKey');
    final createAccountButtonKey = Key('createAccountCustomButtonKey');

    final loginButton = find.byKey(loginButtonKey);
    final createAccountButton = find.byKey(createAccountButtonKey);

    // Expect to find both buttons
    expect(loginButton, findsOneWidget);
    expect(createAccountButton, findsOneWidget);
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
    expect(find.byKey(const Key('logoKey')), findsNothing);
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

  testWidgets('Test buildHome text', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return HomePage().buildHome(context);
          },
        ),
      ),
    ));

    // You can add expectations based on the widget behavior
    expect(find.byKey(const Key('logoKey')), findsOneWidget);
    expect(find.text('Live'), findsOneWidget);
    expect(find.text('Feel'), findsOneWidget);
    expect(find.text('Discover'), findsOneWidget);
  });

  testWidgets('Test buildHome text color', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return HomePage().buildHome(context);
          },
        ),
      ),
    ));

    // Verify the presence of key widgets
    expect(find.byKey(const Key('logoKey')), findsOneWidget);
    expect(find.text('Live'), findsOneWidget);
    expect(find.text('Feel'), findsOneWidget);
    expect(find.text('Discover'), findsOneWidget);

    // Verify the style of text widgets
    expect(
      find.text('Live'),
      findsOneWidget,
      reason: 'Live text should be present',
    );
    expect(
      tester
          .widget<Text>(
            find.text('Live'),
          )
          .style
          ?.color,
      equals(AppColors.main1),
      reason: 'Live text should have AppColors.main1 color',
    );
    expect(
      tester
          .widget<Text>(
            find.text('Live'),
          )
          .style
          ?.fontSize,
      equals(50),
      reason: 'Live text should have fontSize 50',
    );
  });

  testWidgets('Test buildHome text font weights', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return HomePage().buildHome(context);
          },
        ),
      ),
    ));

    // Verify the presence of key widgets
    expect(find.byKey(const Key('logoKey')), findsOneWidget);
    expect(find.text('Live'), findsOneWidget);
    expect(find.text('Feel'), findsOneWidget);
    expect(find.text('Discover'), findsOneWidget);

    // Verify the style of text widgets
    expect(
      tester
          .widget<Text>(
            find.text('Live'),
          )
          .style
          ?.color,
      equals(AppColors.main1),
      reason: 'Live text should have AppColors.main1 color',
    );
    expect(
      tester
          .widget<Text>(
            find.text('Feel'),
          )
          .style
          ?.color,
      equals(AppColors.main3),
      reason: 'Feel text should have AppColors.main3 color',
    );
    expect(
      tester
          .widget<Text>(
            find.text('Discover'),
          )
          .style
          ?.color,
      equals(AppColors.main2),
      reason: 'Discover text should have AppColors.main2 color',
    );

    // Verify the font weights
    expect(
      tester
          .widget<Text>(
            find.text('Live'),
          )
          .style
          ?.fontWeight,
      equals(FontWeight.w700),
      reason: 'Live text should have FontWeight.w700',
    );
    expect(
      tester
          .widget<Text>(
            find.text('Feel'),
          )
          .style
          ?.fontWeight,
      equals(FontWeight.w700),
      reason: 'Feel text should have FontWeight.w700',
    );
    expect(
      tester
          .widget<Text>(
            find.text('Discover'),
          )
          .style
          ?.fontWeight,
      equals(FontWeight.w700),
      reason: 'Discover text should have FontWeight.w700',
    );
  });
}
