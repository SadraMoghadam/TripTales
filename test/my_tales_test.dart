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
}
