import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:trip_tales/src/constants/error_messages.dart';

void main() {
  group('ErrorController Tests', () {
    testWidgets(
        'showSnackBarError displays snackbar with correct error message',
        (WidgetTester tester) async {
      // Arrange
      const errorMessage = 'Test error message';

      // Act
      await tester.pumpWidget(MaterialApp(home: Builder(
        builder: (context) {
          ErrorController.showSnackBarError(errorMessage);
          return Container();
        },
      )));

      // Assert
      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('showSnackBarError displays snackbar with "Oops!" title',
        (WidgetTester tester) async {
      // Arrange
      const errorMessage = 'Test error message';

      // Act
      await tester.pumpWidget(MaterialApp(home: Builder(
        builder: (context) {
          ErrorController.showSnackBarError(errorMessage);
          return Container();
        },
      )));

      // Assert
      expect(find.text('Oops!'), findsOneWidget);
    });

    // Add more tests for other error messages and scenarios as needed
  });
}
