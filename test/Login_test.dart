import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trip_tales/src/controllers/auth_controller.dart';
import 'package:trip_tales/src/pages/Login.dart'; // Import your LoginPage widget
// Import necessary dependencies and widgets used in the LoginPage

void main() {
  testWidgets('LoginPage layout', (WidgetTester tester) async {
    // Build the widget
    final AuthController authController = Get.find<AuthController>();
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Test if the Scaffold is rendered
    expect(find.byType(Scaffold), findsOneWidget);

    // Test if the SingleChildScrollView is rendered
    expect(find.byType(SingleChildScrollView), findsOneWidget);

    // Check if main widgets are present
    expect(find.byType(Container), findsNWidgets(6));
    expect(find.byType(Column), findsNWidgets(6));
    expect(find.byType(Flexible), findsNWidgets(6));
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
    // We might not need this additional pump, but it's included for consistency
  });

  testWidgets('LoginPage password', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));
    final passwordTextFieldFinder =
        find.byKey(const Key('passwordCustomTextField'));
    expect(passwordTextFieldFinder, findsOneWidget);

    // Enter some text into the password form field
    await tester.enterText(passwordTextFieldFinder, 'somepassword');
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
  // Test the visibility toggle for the password field
  //final visibilityButtonFinder = find.byKey(Key('visibilityButton'));
  //expect(visibilityButtonFinder, findsOneWidget);

  //await tester.tap(visibilityButtonFinder);
  //await tester.pump();

  testWidgets('LoginPage visibility icons', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));
    // Assuming the visibility icon changes when tapped, test for updated visibility
    expect(find.byIcon(Icons.visibility), findsNothing);
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
  });

  testWidgets('LoginPage forgot password', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginPage()));
    // Test Forgot Password button
    final forgotPasswordButtonFinder =
        find.byKey(const Key('forgotPasswordKey'));
    expect(forgotPasswordButtonFinder, findsOneWidget);
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
/*
    // Testing button tap behavior (assuming navigation works correctly)
    await tester.tap(loginButtonFinder);
    await tester.pumpAndSettle(); // Wait for the navigation to complete

    // Verify if the navigation occurred
    expect(find.text('Custom Menu'), findsOneWidget);
    // Assuming a 'Custom Menu' text is present after navigating

    // Testing navigation to 'Create Account' page
    await tester.tap(createAccountButtonFinder);
    await tester.pumpAndSettle();

    // Verify if navigation to 'Create Account' occurred
    expect(find.text('Register Page'), findsOneWidget);

    // Test for edge cases (e.g., empty email or password)
    await tester.enterText(emailTextFieldFinder, '');
    await tester.enterText(passwordTextFieldFinder, '');
    await tester.tap(loginButtonFinder); // Attempt to login with empty fields
    await tester.pump(); // Rebuild the widget
    expect(find.text('Please enter a valid email'), findsOneWidget);
    expect(find.text('Password must contain at least 8 characters'),
        findsOneWidget);
        */
  });
}
