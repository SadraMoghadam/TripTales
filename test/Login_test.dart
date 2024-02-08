import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:trip_tales/src/controllers/auth_controller.dart';
import 'package:trip_tales/src/controllers/media_controller.dart';
import 'package:trip_tales/src/pages/Login.dart';
import 'package:trip_tales/src/utils/app_manager.dart';

class MockAuthController extends GetxController
    with Mock
    implements AuthController {}

void main() {
  late MockAuthController authController;

  setUp(() {
    authController = MockAuthController();
    Get.put<AuthController>(authController);
  });

  testWidgets('LoginPage layout', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Test if the Scaffold is rendered
    expect(find.byType(Scaffold), findsOneWidget);

    // Test if the SingleChildScrollView is rendered
    expect(find.byType(SingleChildScrollView), findsOneWidget);

    // Check if main widgets are present
    expect(find.byType(Container), findsNWidgets(7));
    expect(find.byType(Column), findsNWidgets(6));
    expect(find.byType(Flexible), findsNWidgets(8));
    expect(find.byType(TextButton), findsNWidgets(2));
  });

  testWidgets('LoginPage email', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    final emailTextFieldFinder = find.byKey(const Key('emailCustomTextField'));
    expect(emailTextFieldFinder, findsOneWidget);

    // Enter text into the email form field
    await tester.enterText(emailTextFieldFinder, 'example@example.com');
    await tester.pump(); // Trigger a rebuild

    // Verify the text in the field
    expect(find.text('example@example.com'), findsOneWidget);

    // Clear the text field
    await tester.enterText(emailTextFieldFinder, '');
    await tester.pump(); // Trigger a rebuild

    // Trigger validation
    await tester.pumpAndSettle();

    // Verify "Enter your email" error is displayed
    expect(find.text('Enter your email'), findsOneWidget);

    // Enter text into the email form field again
    await tester.enterText(emailTextFieldFinder, 'anotherexample@example.com');
    await tester.pump(); // Trigger a rebuild

    // Verify the new text in the field
    expect(find.text('anotherexample@example.com'), findsOneWidget);

    // Trigger validation
    await tester.pumpAndSettle();
  });

  testWidgets('LoginPage insert password in empty field',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));
    final passwordTextFieldFinder =
        find.byKey(const Key('passwordCustomTextField'));
    expect(passwordTextFieldFinder, findsOneWidget);

    // Enter a text into the password field
    await tester.enterText(passwordTextFieldFinder, 'firstpassword');
    // clean the text from the password field
    await tester.enterText(passwordTextFieldFinder, '');
    // trigger validation
    await tester.pump();
    // verify "Enter your password" error is displayed
    expect(find.text('Enter your password'), findsOneWidget);
    // Enter text into password form field again
    await tester.enterText(passwordTextFieldFinder, 'newpassword');
    // Trigger validation
    await tester.pump();
    expect(find.text('Enter your password'), findsOneWidget);

    //expect(find.text('Password Strength: Strong'), findsOneWidget);
    expect(find.byKey(const Key('passwordStrengthKey')), findsOneWidget);

    await tester.enterText(passwordTextFieldFinder, 'Test123@');
    expect(find.text('Test123@'), findsOneWidget);
  });

  testWidgets('LoginPage visibility icons', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));
    // Assuming the visibility icon changes when tapped, test for updated visibility
    expect(find.byIcon(Icons.visibility), findsNothing);
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
  });

  testWidgets('LoginPage login button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));
    // Test if Login and Create Account buttons exist
    final loginButtonFinder = find.byKey(const Key('loginButtonKey'));
    expect(loginButtonFinder, findsOneWidget);
  });

  testWidgets('LoginPage create account button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));
    final createAccountButtonFinder =
        find.byKey(const Key('createAccountButtonKey'));

    expect(createAccountButtonFinder, findsOneWidget);
  });
}
