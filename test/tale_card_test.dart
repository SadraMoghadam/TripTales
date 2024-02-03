import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/widgets/tale_card.dart';

void main() {
  testWidgets('CustomTale widget renders correctly',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: CustomTale(
          talePath: 'test_tale_path',
          taleName: 'Test Tale',
          index: 0,
        ),
      ),
    );

    // Verify that the widget has the correct initial state.
    expect(find.text('Test Tale'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border_rounded), findsOneWidget);
  });

  testWidgets('CustomTale widget updates like status on tap',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: CustomTale(
          talePath: 'test_tale_path',
          taleName: 'Test Tale',
          index: 0,
        ),
      ),
    );

    // Tap the like button
    await tester.tap(find.byIcon(Icons.favorite_border_rounded));
    await tester.pump();

    // Verify that the like status is updated
    expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
  });

  testWidgets('CustomTale widget navigates to tale page on tap',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: CustomTale(
          talePath: 'test_tale_path',
          taleName: 'Test Tale',
          index: 0,
        ),
      ),
    );

    // Tap the CustomTale widget
    await tester.tap(find.byType(CustomTale));
    await tester.pumpAndSettle();

    // Verify that it navigates to the tale page
    expect(find.text('Tale Page'),
        findsOneWidget); // Assuming 'Tale Page' is part of your tale page
  });

  testWidgets(
      'CustomTale widget displays loading indicator while loading image info',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: CustomTale(
          talePath: 'test_tale_path',
          taleName: 'Test Tale',
          index: 0,
        ),
      ),
    );

    // Verify that the loading indicator is displayed initially
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Pump the widget after loading image info
    await tester.pump();

    // Verify that the loading indicator is no longer displayed
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('CustomTale widget renders correctly with default values',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: CustomTale(
          talePath: 'test_tale_path',
          taleName: 'Test Tale',
          index: 0,
        ),
      ),
    );

    // Verify that the widget has the correct initial state.
    expect(find.text('Test Tale'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border_rounded), findsOneWidget);
    expect(find.byIcon(Icons.favorite_rounded), findsNothing);
    // Add more verifications based on your widget's initial state
  });

  testWidgets('CustomTale widget updates size for tablet',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: CustomTale(
          talePath: 'test_tale_path',
          taleName: 'Test Tale',
          index: 0,
          isTablet: true,
        ),
      ),
    );

    // Verify that the widget updates its size for tablet
    expect(find.byType(Container), findsOneWidget);
    expect(
        tester.getSize(find.byType(Container)), equals(const Size(480, 320)));
  });

  testWidgets('CustomTale widget updates like status when tapped',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: CustomTale(
          talePath: 'test_tale_path',
          taleName: 'Test Tale',
          index: 0,
        ),
      ),
    );

    // Tap the like button
    await tester.tap(find.byIcon(Icons.favorite_border_rounded));
    await tester.pump();

    // Verify that the like status is updated
    expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);

    // Tap the like button again
    await tester.tap(find.byIcon(Icons.favorite_rounded));
    await tester.pump();

    // Verify that the like status is updated back to false
    expect(find.byIcon(Icons.favorite_border_rounded), findsOneWidget);
  });

  testWidgets('CustomTale widget handles loading image failure',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: CustomTale(
          talePath: 'invalid_image_url', // Invalid URL to simulate failure
          taleName: 'Test Tale',
          index: 0,
        ),
      ),
    );

    // Verify that the error state is handled gracefully
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Test Tale'), findsOneWidget);
    expect(find.byType(Image),
        findsNothing); // Image should not be rendered on failure
  });

  testWidgets('CustomTale widget updates like status asynchronously',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: CustomTale(
          talePath: 'test_tale_path',
          taleName: 'Test Tale',
          index: 0,
        ),
      ),
    );

    // Tap the like button
    await tester.tap(find.byIcon(Icons.favorite_border_rounded));
    await tester.pump();

    // Verify that the like status is updated immediately
    expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);

    // Simulate an asynchronous update (e.g., network request)
    await tester.runAsync(() async {
      // Delayed update to mimic an asynchronous process
      await Future.delayed(const Duration(seconds: 1));

      // Verify that the like status is still updated after the asynchronous process
      expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
    });
  });

  testWidgets('CustomTale widget navigates to tale page with correct tale ID',
      (WidgetTester tester) async {
    // Mock dependencies or services as needed for testing
    // MockTaleService mockTaleService = MockTaleService();

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: CustomTale(
          talePath: 'test_tale_path',
          taleName: 'Test Tale',
          index: 0,
        ),
      ),
    );

    // Tap the CustomTale widget
    await tester.tap(find.byType(CustomTale));
    await tester.pumpAndSettle();

    // Verify that it navigates to the tale page with the correct tale ID
    // Add assertions based on your navigation implementation
    expect(find.text('Tale Page'), findsOneWidget);
  });
}
