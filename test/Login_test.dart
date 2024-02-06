import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:trip_tales/src/controllers/auth_controller.dart';
import 'package:trip_tales/src/controllers/media_controller.dart';
import 'package:trip_tales/src/pages/Login.dart';
import 'package:trip_tales/src/utils/app_manager.dart';

class MockAuthController extends GetxController with Mock implements AuthController {}

void main() {
  late MockAuthController authController;

  setUp(() {
    authController = MockAuthController();
    Get.put<AuthController>(authController);
  });

  // testWidgets('LoginPage Form Validation', (WidgetTester tester) async {
  //   // Mock the authentication result
  //   when(authController.signInWithEmailAndPassword(
  //     "sadra_h_m@outlook.com",
  //     "Scorpion33033",
  //   )).thenAnswer((_) async => Future<int>.value(200));
  //
  //   await tester.pumpWidget(
  //     MaterialApp(
  //       home: LoginPage(),
  //     ),
  //   );
  //
  //   // Tap the login button without entering any credentials
  //   await tester.tap(find.byKey(const Key('loginButtonKey')));
  //   await tester.pump();
  //
  //   // Verify that the form validation error messages are shown
  //   expect(find.text('Email is required'), findsOneWidget);
  //   expect(find.text('Password is required'), findsOneWidget);
  //
  //   // Enter valid email and password
  //   await tester.enterText(find.byKey(const Key('emailCustomTextField')), 'test@example.com');
  //   await tester.enterText(find.byKey(const Key('passwordCustomTextField')), 'password123');
  //
  //   // Tap the login button again
  //   await tester.tap(find.byKey(const Key('loginButtonKey')));
  //
  //   // Wait for the async operation to complete
  //   await tester.pump();
  //
  //   // Verify that the form validation error messages are not shown
  //   expect(find.text('Email is required'), findsNothing);
  //   expect(find.text('Password is required'), findsNothing);
  //
  //   // Verify that the signInWithEmailAndPassword method is called
  //   verify(authController.signInWithEmailAndPassword('test@example.com', 'password123')).called(1);
  // });

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

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:trip_tales/src/controllers/auth_controller.dart';
// import 'package:trip_tales/src/pages/Login.dart';
// import 'package:mockito/mockito.dart';
//
// class MockAuthController extends Mock implements AuthController {}
// void main() {
//   late AuthController authController;
//   late MockAuthController? mockAuthController;
//   setUp(() {
//     authController = Get.put<AuthController>(MockAuthController());
//   });
//
//   testWidgets('LoginPage layout', (WidgetTester tester) async {
//     // Build the widget
//     await tester.pumpWidget(MaterialApp(home: LoginPage()));
//
//     // Test if the Scaffold is rendered
//     expect(find.byType(Scaffold), findsOneWidget);
//
//     // Test if the SingleChildScrollView is rendered
//     expect(find.byType(SingleChildScrollView), findsOneWidget);
//
//     // Check if main widgets are present
//     expect(find.byType(Container), findsNWidgets(6));
//     expect(find.byType(Column), findsNWidgets(6));
//     expect(find.byType(Flexible), findsNWidgets(6));
//     expect(find.byType(TextButton), findsNWidgets(2));
//   });
//
//   testWidgets('LoginPage email', (WidgetTester tester) async {
//     await tester.pumpWidget(MaterialApp(home: LoginPage()));
//
//     final emailTextFieldFinder = find.byKey(const Key('emailCustomTextField'));
//     expect(emailTextFieldFinder, findsOneWidget);
//
//     // Enter text into the email form field
//     await tester.enterText(emailTextFieldFinder, 'example@example.com');
//     await tester.pump(); // Trigger a rebuild
//
//     // Verify the text in the field
//     expect(find.text('example@example.com'), findsOneWidget);
//
//     // Clear the text field
//     await tester.enterText(emailTextFieldFinder, '');
//     await tester.pump(); // Trigger a rebuild
//
//     // Trigger validation
//     await tester.pumpAndSettle();
//
//     // Verify "Enter your email" error is displayed
//     expect(find.text('Enter your email'), findsOneWidget);
//
//     // Enter text into the email form field again
//     await tester.enterText(emailTextFieldFinder, 'anotherexample@example.com');
//     await tester.pump(); // Trigger a rebuild
//
//     // Verify the new text in the field
//     expect(find.text('anotherexample@example.com'), findsOneWidget);
//
//     // Trigger validation
//     await tester.pumpAndSettle();
//     // We might not need this additional pump, but it's included for consistency
//   });
//
//   testWidgets('LoginPage password', (WidgetTester tester) async {
//     await tester.pumpWidget(MaterialApp(home: LoginPage()));
//     final passwordTextFieldFinder =
//         find.byKey(const Key('passwordCustomTextField'));
//     expect(passwordTextFieldFinder, findsOneWidget);
//
//     // Enter some text into the password form field
//     await tester.enterText(passwordTextFieldFinder, 'somepassword');
//     // clean the text from the password field
//     await tester.enterText(passwordTextFieldFinder, '');
//     // trigger validation
//     await tester.pump();
//     // verify "Enter your password" error is displayed
//     expect(find.text('Enter your password'), findsOneWidget);
//     // Enter text into password form field again
//     await tester.enterText(passwordTextFieldFinder, 'newpassword');
//     // Trigger validation
//     await tester.pump();
//     expect(find.text('Enter your password'), findsOneWidget);
//
//     //expect(find.text('Password Strength: Strong'), findsOneWidget);
//     expect(find.byKey(const Key('passwordStrengthKey')), findsOneWidget);
//
//     await tester.enterText(passwordTextFieldFinder, 'Test123@');
//     expect(find.text('Test123@'), findsOneWidget);
//   });
//   // Test the visibility toggle for the password field
//   //final visibilityButtonFinder = find.byKey(Key('visibilityButton'));
//   //expect(visibilityButtonFinder, findsOneWidget);
//
//   //await tester.tap(visibilityButtonFinder);
//   //await tester.pump();
//
//   testWidgets('LoginPage visibility icons', (WidgetTester tester) async {
//     await tester.pumpWidget(MaterialApp(home: LoginPage()));
//     // Assuming the visibility icon changes when tapped, test for updated visibility
//     expect(find.byIcon(Icons.visibility), findsNothing);
//     expect(find.byIcon(Icons.visibility_off), findsOneWidget);
//   });
//
//   testWidgets('LoginPage forgot password', (WidgetTester tester) async {
//     await tester.pumpWidget(MaterialApp(home: LoginPage()));
//     // Test Forgot Password button
//     final forgotPasswordButtonFinder =
//         find.byKey(const Key('forgotPasswordKey'));
//     expect(forgotPasswordButtonFinder, findsOneWidget);
//   });
//
//   testWidgets('LoginPage login button', (WidgetTester tester) async {
//     await tester.pumpWidget(MaterialApp(home: LoginPage()));
//     // Test if Login and Create Account buttons exist
//     final loginButtonFinder = find.byKey(const Key('loginButtonKey'));
//     expect(loginButtonFinder, findsOneWidget);
//   });
//
//   testWidgets('LoginPage create account button', (WidgetTester tester) async {
//     await tester.pumpWidget(MaterialApp(home: LoginPage()));
//     final createAccountButtonFinder =
//         find.byKey(const Key('createAccountButtonKey'));
//
//     expect(createAccountButtonFinder, findsOneWidget);
// /*
//     // Testing button tap behavior (assuming navigation works correctly)
//     await tester.tap(loginButtonFinder);
//     await tester.pumpAndSettle(); // Wait for the navigation to complete
//
//     // Verify if the navigation occurred
//     expect(find.text('Custom Menu'), findsOneWidget);
//     // Assuming a 'Custom Menu' text is present after navigating
//
//     // Testing navigation to 'Create Account' page
//     await tester.tap(createAccountButtonFinder);
//     await tester.pumpAndSettle();
//
//     // Verify if navigation to 'Create Account' occurred
//     expect(find.text('Register Page'), findsOneWidget);
//
//     // Test for edge cases (e.g., empty email or password)
//     await tester.enterText(emailTextFieldFinder, '');
//     await tester.enterText(passwordTextFieldFinder, '');
//     await tester.tap(loginButtonFinder); // Attempt to login with empty fields
//     await tester.pump(); // Rebuild the widget
//     expect(find.text('Please enter a valid email'), findsOneWidget);
//     expect(find.text('Password must contain at least 8 characters'),
//         findsOneWidget);
//         */
//   });
// }
