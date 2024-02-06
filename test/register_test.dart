import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mockito/mockito.dart';
import 'package:trip_tales/src/controllers/auth_controller.dart';
import 'package:trip_tales/src/pages/register.dart';
import 'package:trip_tales/src/widgets/text_field.dart';

class MockAuthController extends GetxController
    with Mock
    implements AuthController {}

void main() {
  late MockAuthController authController;

  setUp(() {
    authController = MockAuthController();
    Get.put<AuthController>(authController);
  });

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
    expect(find.byType(SizedBox), findsNWidgets(21));
    // expect(find.byType(SetPhotoScreen), findsNWidgets(2));
  });

  testWidgets('Register Page create an account text',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));
    final loginTextFinder = find.text('Create your account for free');
    expect(loginTextFinder, findsOneWidget);
  });

  testWidgets('Register Page name', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));
    final nameTextFieldFinder = find.byKey(const Key('nameCustomTextFieldKey'));
    expect(nameTextFieldFinder, findsOneWidget);

    // Enter some text into the name form field
    await tester.enterText(nameTextFieldFinder, 'aName');
    expect(find.text('aName'), findsOneWidget);
    // clean the text from the name field
    await tester.enterText(nameTextFieldFinder, '');
    // Trigger validation
    await tester.pump();
    // verify "Enter your name" error is displayed
    expect(find.text('Enter your name'), findsOneWidget);
    // Enter another text into name form field again
    await tester.enterText(nameTextFieldFinder, 'anothername');
    expect(find.text('anothername'), findsOneWidget);
    // Trigger validation
    await tester.pump();
    expect(find.text('Enter your name'), findsOneWidget);
  });

  testWidgets('Register Page surname', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));
    final surnameTextFieldFinder =
        find.byKey(const Key('surnameCustomTextFieldKey'));
    expect(surnameTextFieldFinder, findsOneWidget);

    // Enter some text into the surname form field
    await tester.enterText(surnameTextFieldFinder, 'aSurname');
    expect(find.text('aSurname'), findsOneWidget);
    // clean the text from the surname field
    await tester.enterText(surnameTextFieldFinder, '');
    // Trigger validation
    await tester.pump();
    // verify "Enter your surname" error is displayed
    expect(find.text('Enter your surname'), findsOneWidget);
    // Enter another text into name form field again
    await tester.enterText(surnameTextFieldFinder, 'anotherSurname');
    expect(find.text('anotherSurname'), findsOneWidget);
    // Trigger validation
    await tester.pump();
    expect(find.text('Enter your surname'), findsOneWidget);
  });

  testWidgets('Register Page email', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));

    final emailTextFieldFinder =
        find.byKey(const Key('emailCustomTextFieldKey'));
    expect(emailTextFieldFinder, findsOneWidget);

    await tester.enterText(emailTextFieldFinder, '');
    // Test typing in Email field
    await tester.enterText(emailTextFieldFinder, 'example@example.com');
    expect(find.text('example@example.com'), findsOneWidget);
    await tester.pump();
    // clean the text from the email field
    await tester.enterText(emailTextFieldFinder, '');
    // Trigger validation
    await tester.pump();
    // verify "Enter your email" error is displayed
    expect(find.text('Enter your email'), findsOneWidget);
    // Enter another text into email form field again
    await tester.enterText(emailTextFieldFinder, 'anotheremail@example.com');
    expect(find.text('anotheremail@example.com'), findsOneWidget);
    // Trigger validation
    await tester.pump();
    //find hint email text form
    expect(find.text('Enter your email'), findsOneWidget);
  });

/*
  testWidgets('Register Page birth date', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));

    final dateBirthTextFieldFinder =
        find.byKey(const Key('dateBirthCustomTextFieldKey'));
    expect(dateBirthTextFieldFinder, findsOneWidget);

    // Simulate tapping on the birth date text field
    await tester.tap(dateBirthTextFieldFinder);
    await tester.pumpAndSettle(); // Wait for any subsequent widgets to load

    // Check for any widget that appears after tapping the date field
    expect(find.byType(_selectDate(context)), findsOneWidget);
  });
  */

  testWidgets('Register Page password', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));

    final passwordTextFieldFinder =
        find.byKey(const Key('passwordCustomTextFieldKey'));
    expect(passwordTextFieldFinder, findsOneWidget);

    // Enter some text into the password form field
    await tester.enterText(passwordTextFieldFinder, 'somepassword');
    // expect to see the text field in the password form field
    expect(find.text('somepassword'), findsOneWidget);
    // clean the text from the password field
    await tester.enterText(passwordTextFieldFinder, '');
    // trigger validation
    await tester.pump();
    // verify "Enter your password" error is displayed
    expect(find.text('Enter your password'), findsOneWidget);
    // Enter text into password form field again
    await tester.enterText(passwordTextFieldFinder, 'newpassword');
    // expect to see the text field in the password form field
    expect(find.text('newpassword'), findsOneWidget);
    // Trigger validation
    await tester.pump();
  });

  testWidgets('Register Page confirm password', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));

    final passwordTextFieldFinder =
        find.byKey(const Key('confirmPasswordCustomTextFieldKey'));
    expect(passwordTextFieldFinder, findsOneWidget);

    // Enter some text into the confirm password form field
    await tester.enterText(passwordTextFieldFinder, 'somepassword');
    // expect to see the text field in the password form field
    expect(find.text('somepassword'), findsOneWidget);
    // clean the text from the password field
    await tester.enterText(passwordTextFieldFinder, '');
    // trigger validation
    await tester.pump();
    // verify "Enter your password" error is displayed
    expect(find.text('Enter your password again'), findsOneWidget);
    // Enter text into password form field again
    await tester.enterText(passwordTextFieldFinder, 'newpassword');
    // expect to see the text field in the password form field
    expect(find.text('newpassword'), findsOneWidget);
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

  testWidgets('Register Page already have an account',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RegisterPage()));
    final loginTextFinder = find.text('Already have an account?');
    expect(loginTextFinder, findsOneWidget);
  });
}
