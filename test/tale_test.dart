import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart'; // Import the testing package for mocking HTTP requests
import 'package:trip_tales/src/pages/tale.dart';
import 'package:trip_tales/src/widgets/app_bar_tale.dart';
import 'package:trip_tales/src/widgets/tale_builder.dart';
import 'package:trip_tales/src/widgets/tale_card.dart';

void main() {
  testWidgets('Tale Page layout', (WidgetTester tester) async {
    // Create a mock HTTP client
    final client = MockClient((request) async {
      // Return a mock response
      return http.Response('Mocked data', 200);
    });

    // Replace any default HTTP client initialization in your code with the mock client.
    // For instance, if your code uses http.Client() or http.get(), ensure it uses the 'client' instance instead.

    // Replace the MaterialApp widget setup in your test with the following lines:
    await tester.pumpWidget(
      MaterialApp(
        home: TalePage(),
        // Provide the mock client to the pages or widgets that make HTTP requests
        // For example, you can pass it through an InheritedWidget or Provider
        // Or if the HTTP client is created in the TalePage, pass it directly there.
      ),
    );

    // Your test assertions...
    expect(find.byType(Scaffold), findsNWidgets(2));
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(CustomTale), findsNWidgets(7));
    expect(find.byType(Container), findsNWidgets(22));
    expect(find.byType(Column), findsNWidgets(2));
    expect(find.byType(Flexible), findsOneWidget);
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(TaleBuilder), findsOneWidget);
    expect(find.byType(BoxDecoration), findsOneWidget);
    expect(find.byType(DecorationImage), findsOneWidget);
    expect(find.byType(AssetImage), findsOneWidget);
    expect(find.byType(Stack), findsOneWidget);
  });
}
