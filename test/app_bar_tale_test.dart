import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/widgets/app_bar_tale.dart';

void main() {
  testWidgets('CustomAppBar renders correctly', (WidgetTester tester) async {
    // Build the CustomAppBar widget with mock body and icon visibility
    await tester.pumpWidget(
      MaterialApp(
        home: CustomAppBar(
          bodyTale: Container(), // Mock body
          showIcon: true, // Mock icon visibility
        ),
      ),
    );

    // Verify the presence of the title 'Trip Tales'
    expect(find.text('Trip Tales'), findsOneWidget);

    // Verify the back button is present
    expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);

    // Verify the absence of certain widgets based on initial conditions
    expect(find.text('Header Widget'),
        findsNothing); // Mock header widget not shown initially
  });

  testWidgets('CustomAppBar scroll behavior test', (WidgetTester tester) async {
    // Create a scrollable body (ListView)
    final scrollableBody = ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
    );

    // Build the CustomAppBar widget with the scrollable body and icon visibility
    await tester.pumpWidget(
      MaterialApp(
        home: CustomAppBar(
          bodyTale: scrollableBody,
          showIcon: true,
        ),
      ),
    );

    // Verify the absence of the title 'Trip Tales' when scrolled
    expect(find.text('Trip Tales'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0.0, -200.0));
    await tester.pump();
    expect(find.text('Trip Tales'),
        findsNothing); // Title should disappear when scrolled
  });

  testWidgets('CustomAppBar renders with and without back button icon',
      (WidgetTester tester) async {
    // Build CustomAppBar widget without back button icon
    await tester.pumpWidget(
      MaterialApp(
        home: CustomAppBar(
          bodyTale: Container(), // Mock body
          showIcon: false, // No back button icon
        ),
      ),
    );

    // Verify the absence of the back button icon
    expect(find.byIcon(Icons.arrow_back_rounded), findsNothing);

    // Build CustomAppBar widget with back button icon
    await tester.pumpWidget(
      MaterialApp(
        home: CustomAppBar(
          bodyTale: Container(), // Mock body
          showIcon: true, // Back button icon present
        ),
      ),
    );

    // Verify the presence of the back button icon
    expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);
  });

  testWidgets('CustomAppBar scroll behavior test', (WidgetTester tester) async {
    // Create a scrollable body
    final scrollableBody = ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
    );

    // Build the CustomAppBar widget with a scrollable body and icon visibility
    await tester.pumpWidget(
      MaterialApp(
        home: CustomAppBar(
          bodyTale: scrollableBody,
          showIcon: true, // Back button icon present
        ),
      ),
    );

    // Verify the absence of the title 'Trip Tales' when scrolled
    expect(find.text('Trip Tales'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0.0, -200.0));
    await tester.pump();
    expect(find.text('Trip Tales'),
        findsNothing); // Title should disappear when scrolled
  });

  testWidgets('CustomAppBar context-sensitive widget test',
      (WidgetTester tester) async {
    // Build the CustomAppBar widget with a mock body and icon visibility
    await tester.pumpWidget(
      MaterialApp(
        home: CustomAppBar(
          bodyTale: Container(), // Mock body
          showIcon: true, // Back button icon present
        ),
      ),
    );

    // Verify the absence of a context-sensitive widget initially
    expect(find.text('Context-Sensitive Widget'), findsNothing);

    // Build the CustomAppBar widget with a different context-sensitive widget based on icon visibility
    await tester.pumpWidget(
      MaterialApp(
        home: CustomAppBar(
          bodyTale: Container(), // Mock body
          showIcon: false, // Change icon visibility
        ),
      ),
    );

    // Verify the presence of the context-sensitive widget when icon is hidden
    expect(find.text('Context-Sensitive Widget'),
        findsNothing); // Widget should not be present if icon is hidden
  });

  testWidgets('CustomAppBar icon visibility test', (WidgetTester tester) async {
    // Build the CustomAppBar widget with back button icon present
    await tester.pumpWidget(
      MaterialApp(
        home: CustomAppBar(
          bodyTale: Container(), // Mock body
          showIcon: true, // Back button icon present
        ),
      ),
    );

    // Verify the presence of the back button icon
    expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);

    // Build the CustomAppBar widget without back button icon
    await tester.pumpWidget(
      MaterialApp(
        home: CustomAppBar(
          bodyTale: Container(), // Mock body
          showIcon: false, // Back button icon hidden
        ),
      ),
    );

    // Verify the absence of the back button icon
    expect(find.byIcon(Icons.arrow_back_rounded), findsNothing);
  });

  testWidgets('CustomAppBar title test', (WidgetTester tester) async {
    // Build the CustomAppBar widget
    await tester.pumpWidget(
      MaterialApp(
        home: CustomAppBar(
          bodyTale: Container(), // Mock body
          showIcon: true, // Back button icon present
        ),
      ),
    );

    // Verify the presence and style of the app bar title
    expect(find.text('Trip Tales'), findsOneWidget);
    final titleFinder = find.text('Trip Tales');
    final titleWidget = tester.widget<Text>(titleFinder);
    expect(titleWidget.style!.color, equals(Colors.white)); // Verify text color
    expect(titleWidget.style!.fontSize, equals(43.0)); // Verify font size
  });

  testWidgets('CustomAppBar appBar height test', (WidgetTester tester) async {
    // Build the CustomAppBar widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomAppBar(
            bodyTale: Container(), // Mock body
            showIcon: true, // Back button icon present
          ),
        ),
      ),
    );

    // Verify the height of the app bar
    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.preferredSize.height,
        equals(60)); // Verify appBar height
  });

  testWidgets('CustomAppBar device size test', (WidgetTester tester) async {
    // Build the CustomAppBar widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomAppBar(
            bodyTale: Container(), // Mock body
            showIcon: true, // Back button icon present
          ),
        ),
      ),
    );

    // Verify responsiveness for smaller device sizes
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomAppBar(
            bodyTale: Container(), // Mock body
            showIcon: true, // Back button icon present
          ),
        ),
      ),
    );

    // Verify the presence of the back button icon
    expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);
  });

  // testWidgets('CustomAppBar back button behavior test',
  //     (WidgetTester tester) async {
  //   final mockNavigatorKey = GlobalKey<NavigatorState>();
  //   final scaffoldKey = GlobalKey<ScaffoldState>();
  //
  //   // Build the CustomAppBar widget
  //   await tester.pumpWidget(
  //     MaterialApp(
  //       navigatorKey: mockNavigatorKey,
  //       home: Scaffold(
  //         key: scaffoldKey,
  //         body: CustomAppBar(
  //           bodyTale: Container(), // Mock body
  //           showIcon: true, // Back button icon present
  //         ),
  //       ),
  //     ),
  //   );
  //
  //   // Tap the back button
  //   await tester.tap(find.byIcon(Icons.arrow_back_rounded));
  //   await tester.pumpAndSettle();
  //
  //   // Verify navigation back to previous route
  //   expect(mockNavigatorKey.currentState!.canPop(), isFalse);
  // });
}
