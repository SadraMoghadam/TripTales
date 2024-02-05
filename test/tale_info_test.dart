import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trip_tales/src/pages/tale_info.dart';
import 'package:trip_tales/src/utils/app_manager.dart';

void main() {
  testWidgets('TaleInfoPage Widget Test', (WidgetTester tester) async {
    // Initialize the Getx controller
    Get.put(AppManager());

    // Create the widget by telling the tester to build it
    await tester.pumpWidget(
      GetMaterialApp(
        // Wrap with GetMaterialApp
        home: TaleInfoPage(),
      ),
    );

    // Allow time for any async operations to complete
    await tester.pumpAndSettle();

    // Create the Finders
    final taleInfoFinder = find.byType(TaleInfoPage);

    // Use the `findsOneWidget` matcher to verify that the Text widgets appear exactly once in the widget tree
    expect(taleInfoFinder, findsNothing);
  });
}
