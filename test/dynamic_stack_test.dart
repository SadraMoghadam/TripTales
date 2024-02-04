import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trip_tales/src/constants/memory_card_type.dart';
import 'package:trip_tales/src/services/card_service.dart';
import 'package:trip_tales/src/utils/dynamic_stack.dart';
import 'package:trip_tales/src/widgets/memory_card.dart'; // Adjust the import path

void main() {
  testWidgets('DynamicStack handles empty children list',
      (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DynamicStack(
            children: [],
          ),
        ),
      ),
    );

    // Verify that there are no children in the DynamicStack.
    expect(find.byType(MemoryCard), findsNothing);
  });
}
