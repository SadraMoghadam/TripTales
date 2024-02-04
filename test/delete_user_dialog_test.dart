import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:trip_tales/src/constants/error_messages.dart';
import 'package:trip_tales/src/controllers/auth_controller.dart';
import 'package:trip_tales/src/services/auth_service.dart';
import 'package:trip_tales/src/utils/app_manager.dart';
import 'package:trip_tales/src/widgets/delete_user_dialog.dart';

// Mock classes for dependencies
class MockAuthController extends Mock implements AuthController {}

class MockAppManager extends Mock implements AppManager {}

void main() {
  late MockAuthController mockAuthController;
  late MockAppManager mockAppManager;

  setUp(() {
    mockAuthController = MockAuthController();
    mockAppManager = MockAppManager();

    // Register mockAuthController and mockAppManager for dependency injection
    Get.put<AuthController>(mockAuthController);
    Get.put<AppManager>(mockAppManager);
  });

  testWidgets('DeleteAccountDialog - UI Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DeleteAccountDialog(),
        ),
      ),
    );

    // Verify that the widget renders correctly
    expect(find.text('Delete Account'), findsOneWidget);
    expect(find.text('Are you sure you want to delete this account?'),
        findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);
    expect(find.text('close'), findsOneWidget);
  });
}
