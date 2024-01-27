import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/pages/favorite_tales.dart';
import 'package:trip_tales/src/pages/my_tales.dart';
import 'package:trip_tales/src/pages/profile.dart';
import 'package:trip_tales/src/widgets/menu_bar_tale.dart'; // Replace with your file path

void main() {
  testWidgets('CustomMenu initial state test', (WidgetTester tester) async {
    // Build our widget and trigger a frame
    await tester.pumpWidget(MaterialApp(home: CustomMenu()));

    // Verify the initial state of the widget
    expect(find.byType(MyTalesPage), findsOneWidget);
    expect(find.byType(FavoriteTales), findsNothing);
    expect(find.byType(ProfilePage), findsNothing);
  });

  testWidgets('CustomMenu navigation test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CustomMenu()));

    // Tap on Favorite navigation item
    await tester.tap(find.byWidgetPredicate((widget) =>
        widget is NavigationDestination &&
        widget.label == 'Favorite' &&
        widget.tooltip == 'Favorite Tales'));
    await tester.pump();

    // Verify Favorite screen is displayed
    expect(find.byType(MyTalesPage), findsNothing);
    expect(find.byType(FavoriteTales), findsOneWidget);
    expect(find.byType(ProfilePage), findsNothing);

    // Tap on Profile navigation item
    await tester.tap(find.byWidgetPredicate((widget) =>
        widget is NavigationDestination &&
        widget.label == 'Profile' &&
        widget.tooltip == 'Profile Settings'));
    await tester.pump();

    // Verify Profile screen is displayed
    expect(find.byType(MyTalesPage), findsNothing);
    expect(find.byType(FavoriteTales), findsNothing);
    expect(find.byType(ProfilePage), findsOneWidget);
  });

  testWidgets('CustomMenu state management test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CustomMenu()));

    // Verify initial index
    expect(find.byType(MyTalesPage), findsOneWidget);

    // Tap on Favorite navigation item and verify index change
    await tester.tap(find.byWidgetPredicate((widget) =>
        widget is NavigationDestination &&
        widget.label == 'Favorite' &&
        widget.tooltip == 'Favorite Tales'));
    await tester.pump();
    expect(find.byType(FavoriteTales), findsOneWidget);

    // Tap on Profile navigation item and verify index change
    await tester.tap(find.byWidgetPredicate((widget) =>
        widget is NavigationDestination &&
        widget.label == 'Profile' &&
        widget.tooltip == 'Profile Settings'));
    await tester.pump();
    expect(find.byType(ProfilePage), findsOneWidget);
  });

  // Additional tests can be added to cover edge cases, widget presence, etc.

  testWidgets('CustomMenu edge case test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CustomMenu()));

    // Verify initial index
    expect(find.byType(MyTalesPage), findsOneWidget);

    // Tap on Favorite navigation item twice
    await tester.tap(find.byWidgetPredicate((widget) =>
        widget is NavigationDestination &&
        widget.label == 'Favorite' &&
        widget.tooltip == 'Favorite Tales'));
    await tester.pump();
    expect(find.byType(FavoriteTales), findsOneWidget);

    await tester.tap(find.byWidgetPredicate((widget) =>
        widget is NavigationDestination &&
        widget.label == 'Favorite' &&
        widget.tooltip == 'Favorite Tales'));
    await tester.pump();
    expect(find.byType(FavoriteTales),
        findsOneWidget); // Ensure it remains on the same screen
  });

  testWidgets('CustomMenu home navigation test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CustomMenu()));

    // Tap on Home navigation item
    await tester.tap(find.byWidgetPredicate((widget) =>
        widget is NavigationDestination &&
        widget.label == 'Home' &&
        widget.tooltip == 'Home Page'));
    await tester.pump();

    // Verify Home screen is displayed
    expect(find.byType(MyTalesPage), findsOneWidget);
  });
}
