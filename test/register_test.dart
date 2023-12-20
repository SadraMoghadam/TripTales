import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:trip_tales/src/pages/register.dart';
import 'package:trip_tales/src/widgets/text_field.dart';

void main() {
  testWidgets('Register Page layout', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));

    // Test if the Scaffold is rendered
    expect(find.byType(Scaffold), findsOneWidget);

    // Test if the SingleChildScrollView is rendered
    expect(find.byType(SingleChildScrollView), findsOneWidget);

    // Check if main widgets are present
    expect(find.byType(Container), findsNWidgets(5));
    expect(find.byType(Column), findsNWidgets(4));
    expect(find.byType(CustomTextField), findsNWidgets(6));
    expect(find.byType(Stack), findsOneWidget);
    expect(find.byType(SizedBox), findsNWidgets(20));
    // expect(find.byType(SetPhotoScreen), findsNWidgets(2));
  });

  /*
  testWidgets(
    'RegisterPage Widget Test',
    (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: RegisterPage()));

      expect(find.byType(Scaffold), findsOneWidget);

      expect(find.text('Create your account for free'), findsOneWidget);

      // Fill in the text fields and test validation
      final nameTextFieldFinder =
          find.byKey(const Key('nameCustomTextFieldKey'));
      await tester.enterText(nameTextFieldFinder, 'Mario');
      expect(find.text('Mario'), findsOneWidget);

      final surnameTextFieldFinder =
          find.byKey(const Key('surnameCustomTextFieldKey'));
      await tester.enterText(surnameTextFieldFinder, 'Rossi');
      expect(find.text('Rossi'), findsOneWidget);

      // Test the date picker functionality
      final dateTextFieldFinder =
          find.byKey(const Key('emailCustomTextFieldKey'));
      await tester.tap(dateTextFieldFinder);
      await tester.pumpAndSettle();

      testWidgets('Date Picker Interaction Test', (WidgetTester tester) async {
        expect(find.text('Select date'), findsOneWidget);

        // Tap the TextField to trigger the onTap callback
        await tester.tap(find.byType(CustomTextField));
        await tester.pump();

        // Replace this with your actual date selection logic
        DateTime _selectedDate = DateTime.now();

        // Verify the hintText changes after date selection
        expect(find.text(DateFormat('yyyy-MM-dd').format(_selectedDate)),
            findsOneWidget);

        // Simulate tap on the CustomTextField to open the date picker
        await tester.tap(find.byType(CustomTextField));

        // Wait for the UI to update after the tap
        await tester.pump();

        // Simulate selecting a date in the date picker
        // Replace this with the code to simulate date selection

        // Assert that the selected date updates _selectedDate variable and reflects in UI
        // Replace this with the assertion code
      });

      // You can simulate the date picker interaction if needed

      // Password fields testing
      final passwordTextFieldFinder = find.byKey(ValueKey('passwordField'));
      await tester.enterText(passwordTextFieldFinder, 'Test@123');
      expect(find.text('Test@123'), findsOneWidget);

      final confirmPasswordTextFieldFinder =
          find.byKey(ValueKey('confirmPasswordField'));
      await tester.enterText(confirmPasswordTextFieldFinder, 'Test@123');
      expect(find.text('Test@123'), findsOneWidget);

      // Test the password visibility toggles
      final passwordVisibilityButtonFinder =
          find.byKey(ValueKey('visibilityPasswordButton'));
      await tester.tap(passwordVisibilityButtonFinder);
      await tester.pump();
      // Validate the visibility change

      final confirmPasswordVisibilityButtonFinder =
          find.byKey(ValueKey('visibilityConfirmPasswordButton'));
      await tester.tap(confirmPasswordVisibilityButtonFinder);
      await tester.pump();
      // Validate the visibility change

      // Test password strength indicator
      // Trigger the password strength calculation and test indicator display

      // Test form submission and navigation
      final createAccountButtonFinder = find.text('Create Account');
      //await tester.tap(createAccountButtonFinder);
      //await tester.pumpAndSettle(); // Wait for navigation

      // Validate if navigation to the login page occurs
      //expect(find.text('Login Page'), findsOneWidget);

      // Test navigation to the login page from the "Already have an account?" button
      final alreadyHaveAccountButtonFinder =
          find.text('Already have an account?');
      //await tester.tap(alreadyHaveAccountButtonFinder);
      //await tester.pumpAndSettle(); // Wait for navigation

      // Validate if navigation to the login page occurs
      //expect(find.text('Login Page'), findsOneWidget);
    },
  );*/

  testWidgets('Register Page Create an account for free',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));
    final textFieldFinder = find.text('Create your account for free');
    expect(textFieldFinder, findsOneWidget);
  });

  testWidgets('Register Page name', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));
    final nameTextFieldFinder = find.byKey(const Key('nameCustomTextFieldKey'));
    expect(nameTextFieldFinder, findsOneWidget);
  });

  testWidgets('Register Page surname', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));
    final surnameTextFieldFinder =
        find.byKey(const Key('surnameCustomTextFieldKey'));
    expect(surnameTextFieldFinder, findsOneWidget);
  });

  testWidgets('Register Page email', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));

    final emailTextFieldFinder =
        find.byKey(const Key('emailCustomTextFieldKey'));
    expect(emailTextFieldFinder, findsOneWidget);

    await tester.enterText(emailTextFieldFinder, '');
    // Test typing in Email and Password fields
    await tester.enterText(emailTextFieldFinder, 'example@example.com');
    expect(find.text('example@example.com'), findsOneWidget);

    await tester.pump();
  });

  testWidgets('Register Page birth date', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));
    final dateBirthTextFieldFinder =
        find.byKey(const Key('birthDateCustomTextFieldKey'));
    expect(dateBirthTextFieldFinder, findsOneWidget);
    await tester.pump();
  });

  testWidgets('Register Page password', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));

    final passwordTextFieldFinder =
        find.byKey(const Key('passwordCustomTextFieldKey'));
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
  });

  testWidgets('Register Page confirm password', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));

    final passwordTextFieldFinder =
        find.byKey(const Key('confirmPasswordCustomTextFieldKey'));
    expect(passwordTextFieldFinder, findsOneWidget);

    // Enter some text into the password form field
    await tester.enterText(passwordTextFieldFinder, 'somepassword');
    // clean the text from the password field
    await tester.enterText(passwordTextFieldFinder, '');
    // trigger validation
    await tester.pump();
    // verify "Enter your password" error is displayed
    expect(find.text('Enter your password again'), findsOneWidget);
    // Enter text into password form field again
    await tester.enterText(passwordTextFieldFinder, 'newpassword');
    // Trigger validation
    await tester.pump();
  });

  testWidgets('Register Page password strength', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));
    final textFieldFinder = find.text('Password Strength');
    expect(textFieldFinder, findsOneWidget);
  });

  testWidgets('Register Page create account', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));
    final createAccountButtonFinder =
        find.byKey(const Key('createAccountCustomButtonKey'));
    expect(createAccountButtonFinder, findsOneWidget);
  });

  testWidgets('Register Page login', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));
    final loginTextFinder = find.byKey(const Key('loginTextKey'));
    expect(loginTextFinder, findsOneWidget);
  });
}
