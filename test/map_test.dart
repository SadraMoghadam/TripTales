import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trip_tales/src/utils/app_manager.dart';
import 'package:trip_tales/src/utils/tuple.dart';
import 'package:trip_tales/src/widgets/map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MockAppManager extends Mock implements AppManager {}

void main() {
  group('MapScreen Widget Tests', () {
    testWidgets('Initial widget creation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MapScreen(),
        ),
      );

      // Verify that the widget is created successfully
      expect(find.byType(MapScreen), findsOneWidget);
      expect(find.byType(GoogleMap), findsNothing);
    });

    testWidgets('Widget with multiple locations', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MapScreen(multipleLoc: true),
        ),
      );

      // Verify that the widget is created successfully
      expect(find.byType(MapScreen), findsOneWidget);
      expect(find.byType(GoogleMap), findsNothing);

      // Perform interaction to add a marker
      await tester.tap(find.byType(GoogleMap));
      await tester.pump();

      // Verify that a marker is added
      expect(find.byType(Marker), findsOneWidget);
    });

    testWidgets('Widget in read-only mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MapScreen(isReadonly: true),
        ),
      );

      // Verify that the widget is created successfully
      expect(find.byType(MapScreen), findsOneWidget);
      expect(find.byType(GoogleMap), findsNothing);

      // Verify that markers are displayed in read-only mode
      expect(find.byType(Marker), findsWidgets);
    });

    // Add more tests based on your requirements

    testWidgets('Widget with chosen location', (WidgetTester tester) async {
      // Create a MockAppManager to simulate the AppManager behavior
      final mockAppManager = MockAppManager();
      when(mockAppManager.getChosenLocation())
          .thenReturn(Tuple(37.7749, -122.4194));

      await tester.pumpWidget(
        MaterialApp(
          home: MapScreen(isReadonly: true),
        ),
      );

      // Verify that the widget is created successfully
      expect(find.byType(MapScreen), findsOneWidget);
      expect(find.byType(GoogleMap), findsOneWidget);

      // Verify that the chosen location is displayed
      expect(find.byType(Marker), findsOneWidget);
    });
  });

  group('MapScreen Widget Tests', () {
    late MockAppManager mockAppManager;

    setUp(() {
      mockAppManager = MockAppManager();
    });

    testWidgets('Initial widget creation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MapScreen(),
        ),
      );

      expect(find.byType(MapScreen), findsOneWidget);
      expect(find.byType(GoogleMap), findsOneWidget);
    });

    testWidgets('Widget with multiple locations', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MapScreen(multipleLoc: true),
        ),
      );

      expect(find.byType(MapScreen), findsOneWidget);
      expect(find.byType(GoogleMap), findsOneWidget);

      await tester.tap(find.byType(GoogleMap));
      await tester.pump();

      expect(find.byType(Marker), findsOneWidget);
    });

    testWidgets('Widget in read-only mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MapScreen(isReadonly: true),
        ),
      );

      expect(find.byType(MapScreen), findsOneWidget);
      expect(find.byType(GoogleMap), findsOneWidget);

      expect(find.byType(Marker), findsWidgets);
    });

    testWidgets('Widget with chosen location d ', (WidgetTester tester) async {
      // Mock the AppManager to return a chosen location
      when(mockAppManager.getChosenLocation())
          .thenReturn(Tuple(37.7749, -122.4194));

      await tester.pumpWidget(
        MaterialApp(
          home: MapScreen(isReadonly: true),
        ),
      );

      expect(find.byType(MapScreen), findsOneWidget);
      expect(find.byType(GoogleMap), findsOneWidget);

      expect(find.byType(Marker), findsOneWidget);
    });

    // Add more tests based on your requirements
  });
}
