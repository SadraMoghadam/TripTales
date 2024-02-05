import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:trip_tales/main.dart';
import 'package:trip_tales/src/services/auth_service.dart';
import 'package:trip_tales/src/utils/password_strength_indicator.dart';
import 'package:trip_tales/src/widgets/button.dart';
import 'package:trip_tales/src/widgets/change_password.dart';

void main() {}
  /*
  group('ChangePasswordDialog', () {
    test('checkPasswordStrength should correctly evaluate password strength',
        () {
      final changePasswordDialog = ChangePasswordDialog();

      // Test 1: Weak password (missing uppercase, lowercase, digits, and special characters)
      changePasswordDialog.checkPasswordStrength('weakpassword');
      expect(changePasswordDialog.hasUppercase, isFalse);
      expect(changePasswordDialog.hasLowercase, isFalse);
      expect(changePasswordDialog.hasDigits, isFalse);
      expect(changePasswordDialog.hasSpecialCharacters, isFalse);

      // Test 2: Strong password (contains uppercase, lowercase, digits, and special characters)
      changePasswordDialog.checkPasswordStrength('StrongPassword123!');
      expect(changePasswordDialog.hasUppercase, isTrue);
      expect(changePasswordDialog.hasLowercase, isTrue);
      expect(changePasswordDialog.hasDigits, isTrue);
      expect(changePasswordDialog.hasSpecialCharacters, isTrue);

      // Test 3: Password with only lowercase characters
      changePasswordDialog.checkPasswordStrength('onlylowercase');
      expect(changePasswordDialog.hasUppercase, isFalse);
      expect(changePasswordDialog.hasLowercase, isTrue);
      expect(changePasswordDialog.hasDigits, isFalse);
      expect(changePasswordDialog.hasSpecialCharacters, isFalse);
    });
  });
}
*/
/*
void main() {
  // Register AuthService using Get.put
  Get.put(AuthService());

  // Run the app
  runApp(MyApp());

  testWidgets('ChangePasswordDialog Layout Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: ChangePasswordDialog(),
      ),
    );

    // Ensure the title is rendered with the correct style
    expect(
      find.text('Change Password'),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.text('Change Password'),
        matching: find.byType(Text),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.text('Change Password'),
        matching: find.byKey(const Key('changePassAlertDialogKey')),
      ),
      findsOneWidget,
    );
    /*
    expect(
      find.text('Change Password').evaluate().first.widget.style?.color,
      equals(Colors.black), // Change to the correct color value
    );
    expect(
      find.text('Change Password').evaluate().first.widget.style?.fontSize,
      equals(25), // Change to the correct font size value
    );
     */
    // Ensure the Password and Confirm Password fields are rendered
    expect(
      find.byKey(const Key('passwordCustomTextFieldKey')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('confirmPasswordCustomTextFieldKey')),
      findsOneWidget,
    );

    // Ensure the Password Strength indicator is rendered
    expect(
      find.byType(PasswordStrengthIndicator),
      findsOneWidget,
    );

    // Ensure the Change and Close buttons are rendered
    expect(
      find.widgetWithText(CustomButton, 'Change'),
      findsOneWidget,
    );
    expect(
      find.widgetWithText(CustomButton, 'Close'),
      findsOneWidget,
    );

    // Ensure the AlertDialog has the correct shape and elevation
    expect(
      find.byType(AlertDialog),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.byType(RoundedRectangleBorder),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.byType(SingleChildScrollView),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.byType(Container),
      ),
      findsOneWidget,
    );
  });
}



/*
class MockAuthService extends Mock {}

void main() {
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
  });

  testWidgets('ChangePasswordDialog UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangePasswordDialog(),
      ),
    );

    // Ensure the ChangePasswordDialog UI is rendered
    expect(find.text('Change Password'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(PasswordStrengthIndicator), findsOneWidget);
    expect(find.byType(CustomButton), findsNWidgets(2));
  });

  testWidgets('ChangePasswordDialog Validation Test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangePasswordDialog(),
      ),
    );

    // Fill in the password and confirm password fields
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'), 'StrongPassword123');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Confirm Password'),
        'StrongPassword123');

    // Tap the Change button
    await tester.tap(find.widgetWithText(CustomButton, 'Change'));

    // Rebuild the widget after the state has changed
    await tester.pump();

    // Ensure the validation is successful
    //verify(mockAuthService.updatePassword('StrongPassword123')).called(1);
  });

/*
void main() {
  testWidgets('ChangePasswordDialog Widget Test', (WidgetTester tester) async {
    // Initialize the GetxController before running the tests
    Get.testMode = true;
    TestWidgetsFlutterBinding.ensureInitialized();

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: ChangePasswordDialog(),
        ),
      ),
    );

    // Verify that the ChangePasswordDialog widget is displayed
    expect(find.byType(ChangePasswordDialog), findsOneWidget);

    // Verify that the AlertDialog widget is displayed
    expect(find.byType(AlertDialog), findsOneWidget);

    // Verify that the title is displayed
    expect(find.text('Change Password'), findsOneWidget);

    // Verify that the password fields are displayed
    expect(find.byKey(const Key('passwordCustomTextFieldKey')), findsOneWidget);
    expect(find.byKey(const Key('confirmPasswordCustomTextFieldKey')),
        findsOneWidget);

    // Verify that the buttons are displayed
    expect(find.text('Change'), findsOneWidget);
    expect(find.text('Close'), findsOneWidget);
  });

  testWidgets('ChangePasswordDialog password visibility toggle test',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: ChangePasswordDialog(),
        ),
      ),
    );

    // Verify that the password is initially hidden
    expect(find.byIcon(Icons.visibility_off), findsNWidgets(2));

    // Tap the visibility toggle button for the password field
    await tester.tap(find.byKey(const Key('passwordVisibilityToggle')).first);
    await tester.pump();

    // Verify that the password is now visible
    expect(find.byIcon(Icons.visibility), findsOneWidget);
  });

  testWidgets('ChangePasswordDialog form submission test',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: ChangePasswordDialog(),
        ),
      ),
    );

    // Enter text into the password fields
    await tester.enterText(
        find.byKey(const Key('passwordCustomTextFieldKey')), 'Test123!');
    await tester.enterText(
        find.byKey(const Key('confirmPasswordCustomTextFieldKey')), 'Test123!');

    // Tap the 'Change' button to submit the form
    await tester.tap(find.text('Change'));
    await tester.pump();

    // Verify that the form submission was successful
    // This will depend on your implementation
    // For example, you might navigate to a new screen upon successful submission
    // expect(find.byType(NewScreen), findsOneWidget);
  });

  testWidgets('ChangePasswordDialog password visibility toggle test',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: ChangePasswordDialog(),
        ),
      ),
    );

    // Verify that the password is initially hidden
    expect(find.byIcon(Icons.visibility_off), findsNWidgets(2));

    // Tap the visibility toggle button for the password field
    await tester.tap(find.byKey(const Key('passwordVisibilityToggle')).first);
    await tester.pump();

    // Verify that the password is now visible
    expect(find.byIcon(Icons.visibility), findsOneWidget);
  });

  testWidgets('ChangePasswordDialog form submission test',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: ChangePasswordDialog(),
        ),
      ),
    );

    // Enter text into the password fields
    await tester.enterText(
        find.byKey(const Key('passwordCustomTextFieldKey')), 'Test123!');
    await tester.enterText(
        find.byKey(const Key('confirmPasswordCustomTextFieldKey')), 'Test123!');

    // Tap the 'Change' button to submit the form
    await tester.tap(find.text('Change'));
    await tester.pump();

    // Verify that the form submission was successful
    // This will depend on your implementation
    // For example, you might navigate to a new screen upon successful submission
    // expect(find.byType(NewScreen), findsOneWidget);
  });
  
}
*/ */  */
