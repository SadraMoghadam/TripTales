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
    expect(find.byKey(Key('logoKey')), findsOneWidget);
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

  testWidgets('Login Button Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
        home: HomePage())); // Assuming your app's entry point is named MyApp

    // Find the widget with the given key
    final loginButtonKey = Key('loginCustomButtonKey');
    final loginButton = find.byKey(loginButtonKey);

    // Expect to find the login button widget
    expect(loginButton, findsOneWidget);

    // Tap the login button
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    // Add additional expectations based on the behavior after tapping the button
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

  testWidgets('Login Button Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
        home: HomePage())); // Assuming your app's entry point is named MyApp

    // Find the widget with the given key
    final loginButtonKey = Key('loginCustomButtonKey');
    final loginButton = find.byKey(loginButtonKey);

    // Expect to find the login button widget
    expect(loginButton, findsOneWidget);

    // Tap the login button
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    // Add additional expectations based on the behavior after tapping the button
  });

  testWidgets('Create Account Button Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
        home: HomePage())); // Assuming your app's entry point is named MyApp

    // Find the widget with the given key
    final createAccountButtonKey = Key('createAccountCustomButtonKey');
    final createAccountButton = find.byKey(createAccountButtonKey);

    // Expect to find the create account button widget
    expect(createAccountButton, findsOneWidget);

    // Tap the create account button
    await tester.tap(createAccountButton);
    await tester.pumpAndSettle();

    // Add additional expectations based on the behavior after tapping the button
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

  testWidgets('Login Button Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
        home: HomePage())); // Assuming your app's entry point is named MyApp

    // Find the widget with the given key
    final loginButtonKey = Key('loginCustomButtonKey');
    final loginButton = find.byKey(loginButtonKey);

    // Expect to find the login button widget
    expect(loginButton, findsOneWidget);

    // Tap the login button
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    // Add additional expectations based on the behavior after tapping the button
  });

  testWidgets('Create Account Button Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
        home: HomePage())); // Assuming your app's entry point is named MyApp

    // Find the widget with the given key
    final createAccountButtonKey = Key('createAccountCustomButtonKey');
    final createAccountButton = find.byKey(createAccountButtonKey);

    // Expect to find the create account button widget
    expect(createAccountButton, findsOneWidget);

    // Tap the create account button
    await tester.tap(createAccountButton);
    await tester.pumpAndSettle();

    // Add additional expectations based on the behavior after tapping the button
  });

  testWidgets('Check Logo Image', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
        home: HomePage())); // Assuming your app's entry point is named MyApp

    // Find the widget with the given key
    final logoKey = Key('logoKey');
    final logoImage = find.byKey(logoKey);

    // Expect to find the logo image widget
    expect(logoImage, findsOneWidget);

    // Check the properties of the logo image (e.g., height, width, etc.)
    final imageWidget = tester.widget<Image>(logoImage);
    expect(imageWidget.image, isA<AssetImage>());
    // Add more expectations based on your requirements
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

  testWidgets('Login Button Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
        home: HomePage())); // Assuming your app's entry point is named MyApp

    // Find the widget with the given key
    final loginButtonKey = Key('loginCustomButtonKey');
    final loginButton = find.byKey(loginButtonKey);

    // Expect to find the login button widget
    expect(loginButton, findsOneWidget);

    // Tap the login button
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    // Add additional expectations based on the behavior after tapping the button
  });

  testWidgets('Create Account Button Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
        home: HomePage())); // Assuming your app's entry point is named MyApp

    // Find the widget with the given key
    final createAccountButtonKey = Key('createAccountCustomButtonKey');
    final createAccountButton = find.byKey(createAccountButtonKey);

    // Expect to find the create account button widget
    expect(createAccountButton, findsOneWidget);

    // Tap the create account button
    await tester.tap(createAccountButton);
    await tester.pumpAndSettle();

    // Add additional expectations based on the behavior after tapping the button
  });

  testWidgets('Check Logo Image', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
        home: HomePage())); // Assuming your app's entry point is named MyApp

    // Find the widget with the given key
    final logoKey = Key('logoKey');
    final logoImage = find.byKey(logoKey);

    // Expect to find the logo image widget
    expect(logoImage, findsOneWidget);

    // Check the properties of the logo image (e.g., height, width, etc.)
    final imageWidget = tester.widget<Image>(logoImage);
    expect(imageWidget.image, isA<AssetImage>());
    // Add more expectations based on your requirements
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

    // Add more expectations based on the visibility and properties of the buttons
  });
}
