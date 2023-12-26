import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/pages/profile.dart';
import 'package:trip_tales/src/widgets/app_bar_tale.dart';
import 'package:trip_tales/src/widgets/text_field.dart'; // Import your ProfilePage widget
// Import necessary dependencies and widgets used in the ProfilePage

void main() {
  testWidgets('ProfilePage layout', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));

    // Test if the Scaffold is rendered
    expect(find.byType(Scaffold), findsNWidgets(2));

    // Test if the SingleChildScrollView is rendered
    expect(find.byType(SingleChildScrollView), findsOneWidget);

    // Check if main widgets are present
    expect(find.byType(Container), findsNWidgets(3));
    expect(find.byType(Column), findsNWidgets(2));
    expect(find.byType(Flexible), findsOneWidget);
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(CustomTextField), findsNWidgets(8));
    expect(find.byType(Stack), findsNWidgets(3));
    expect(find.byType(Positioned), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byType(SizedBox), findsNWidgets(38));
    // expect(find.byType(SetPhotoScreen), findsNWidgets(2));
  });

/*
  testWidgets('Profile AlertDialog', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));
    final alertDialogFinder = find.byKey(const Key('alertDialogKey'));
    expect(alertDialogFinder, findsOneWidget);
  });
*/

  testWidgets('Profile Page name', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));

    // Wait for the UI to settle/render completely
    await tester.pumpAndSettle();

    final editButtonFinder = find.byKey(const Key('editSaveCustomButtonKey'));
    expect(editButtonFinder, findsOneWidget);

    // Scroll to the button if it's not visible
    await tester.ensureVisible(editButtonFinder);
    await tester.pumpAndSettle();

    // Tap the edit button
    await tester.tap(editButtonFinder);
    await tester.pumpAndSettle(); // Wait for animations/transitions to complete

    final nameTextFieldFinder = find.byKey(const Key('nameCustomTextFieldKey'));
    expect(nameTextFieldFinder, findsOneWidget);

    // Enter text into the name form field
    await tester.enterText(nameTextFieldFinder, 'aName');
    await tester.pump(); // Trigger a rebuild

    // Verify the text in the field
    expect(find.text('aName'), findsOneWidget);

    // Clear the text field
    await tester.enterText(nameTextFieldFinder, '');
    await tester.pump(); // Trigger a rebuild

    // Trigger validation
    await tester.pumpAndSettle();

    // Verify "Enter your name" error is displayed
    expect(find.text('Enter your name'), findsOneWidget);

    // Enter text into the name form field again
    await tester.enterText(nameTextFieldFinder, 'anothername');
    await tester.pump(); // Trigger a rebuild

    // Verify the new text in the field
    expect(find.text('anothername'), findsOneWidget);

    // Trigger validation
    await tester.pumpAndSettle();
    // We might not need this additional pump, but it's included for consistency
  });

  testWidgets('Profile Page surname', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));

    // Wait for the UI to settle/render completely
    await tester.pumpAndSettle();

    final editButtonFinder = find.byKey(const Key('editSaveCustomButtonKey'));
    expect(editButtonFinder, findsOneWidget);

    // Scroll to the button if it's not visible
    await tester.ensureVisible(editButtonFinder);
    await tester.pumpAndSettle();

    // Tap the edit button
    await tester.tap(editButtonFinder);
    await tester.pumpAndSettle(); // Wait for animations/transitions to complete

    final surnameTextFieldFinder =
        find.byKey(const Key('surnameCustomTextFieldKey'));
    expect(surnameTextFieldFinder, findsOneWidget);

    // Enter text into the surname form field
    await tester.enterText(surnameTextFieldFinder, 'aSurname');
    await tester.pump(); // Trigger a rebuild

    // Verify the text in the field
    expect(find.text('aSurname'), findsOneWidget);

    // Clear the text field
    await tester.enterText(surnameTextFieldFinder, '');
    await tester.pump(); // Trigger a rebuild

    // Trigger validation
    await tester.pumpAndSettle();

    // Verify "Enter your surname" error is displayed
    expect(find.text('Enter your surname'), findsOneWidget);

    // Enter text into the surname form field again
    await tester.enterText(surnameTextFieldFinder, 'anotherSurname');
    await tester.pump(); // Trigger a rebuild

    // Verify the new text in the field
    expect(find.text('anotherSurname'), findsOneWidget);

    // Trigger validation
    await tester.pumpAndSettle();
    // We might not need this additional pump, but it's included for consistency
  });

  testWidgets('Profile Page birth date', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));

    // Wait for the UI to settle/render completely
    await tester.pumpAndSettle();

    final editButtonFinder = find.byKey(const Key('editSaveCustomButtonKey'));
    expect(editButtonFinder, findsOneWidget);

    // Scroll to the button if it's not visible
    await tester.ensureVisible(editButtonFinder);
    await tester.pumpAndSettle();

    // Tap the edit button
    await tester.tap(editButtonFinder);
    await tester.pumpAndSettle(); // Wait for animations/transitions to complete
    final dateBirthTextFieldFinder =
        find.byKey(const Key('birthDateCustomTextFieldKey'));
    expect(dateBirthTextFieldFinder, findsOneWidget);
    await tester.pump();
  });

  testWidgets('Profile Page email', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));

    // Wait for the UI to settle/render completely
    await tester.pumpAndSettle();

    final editButtonFinder = find.byKey(const Key('editSaveCustomButtonKey'));
    expect(editButtonFinder, findsOneWidget);

    // Scroll to the button if it's not visible
    await tester.ensureVisible(editButtonFinder);
    await tester.pumpAndSettle();

    // Tap the edit button
    await tester.tap(editButtonFinder);
    await tester.pumpAndSettle(); // Wait for animations/transitions to complete

    final emailTextFieldFinder =
        find.byKey(const Key('emailCustomTextFieldKey'));
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

  testWidgets('Profile Page password', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));

    // Wait for the UI to settle/render completely
    await tester.pumpAndSettle();

    final editButtonFinder = find.byKey(const Key('editSaveCustomButtonKey'));
    expect(editButtonFinder, findsOneWidget);

    // Scroll to the button if it's not visible
    await tester.ensureVisible(editButtonFinder);
    await tester.pumpAndSettle();

    // Tap the edit button
    await tester.tap(editButtonFinder);
    await tester.pumpAndSettle(); // Wait for animations/transitions to complete

    final passwordTextFieldFinder =
        find.byKey(const Key('passwordCustomTextFieldKey'));
    expect(passwordTextFieldFinder, findsOneWidget);

    // Enter text into the password form field
    await tester.enterText(passwordTextFieldFinder, 'somepassword');
    await tester.pump(); // Trigger a rebuild

    // Verify the text in the field
    expect(find.text('somepassword'), findsOneWidget);

    // Clear the text field
    await tester.enterText(passwordTextFieldFinder, '');
    await tester.pump(); // Trigger a rebuild

    // Trigger validation
    await tester.pumpAndSettle();

    // Verify "Enter your password" error is displayed
    expect(find.text('Enter your password'), findsOneWidget);

    // Enter text into the password form field again
    await tester.enterText(passwordTextFieldFinder, 'anotherpassword');
    await tester.pump(); // Trigger a rebuild

    // Verify the new text in the field
    expect(find.text('anotherpassword'), findsOneWidget);

    // Trigger validation
    await tester.pumpAndSettle();
    // We might not need this additional pump, but it's included for consistency
  });

  testWidgets('Profile Page phone number', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));

    // Wait for the UI to settle/render completely
    await tester.pumpAndSettle();

    final editButtonFinder = find.byKey(const Key('editSaveCustomButtonKey'));
    expect(editButtonFinder, findsOneWidget);

    // Scroll to the button if it's not visible
    await tester.ensureVisible(editButtonFinder);
    await tester.pumpAndSettle();

    // Tap the edit button
    await tester.tap(editButtonFinder);
    await tester.pumpAndSettle(); // Wait for animations/transitions to complete

    final phoneTextFieldFinder =
        find.byKey(const Key('phoneNumberCustomTextFieldKey'));
    expect(phoneTextFieldFinder, findsOneWidget);

    // Enter text into the phone number form field
    await tester.enterText(phoneTextFieldFinder, '+393208264550');
    await tester.pump(); // Trigger a rebuild

    // Verify the text in the field
    expect(find.text('+393208264550'), findsOneWidget);

    // Clear the text field
    await tester.enterText(phoneTextFieldFinder, '');
    await tester.pump(); // Trigger a rebuild

    // Trigger validation
    await tester.pumpAndSettle();

    // Verify "Enter your phone number" error is displayed
    expect(find.text('Enter your phone number'), findsOneWidget);

    // Enter text into the phone number form field again
    await tester.enterText(phoneTextFieldFinder, '+345210324990');
    await tester.pump(); // Trigger a rebuild

    // Verify the new text in the field
    expect(find.text('+345210324990'), findsOneWidget);

    // Trigger validation
    await tester.pumpAndSettle();
    // We might not need this additional pump, but it's included for consistency
  });

  testWidgets('Profile Page gender', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));

    // Wait for the UI to settle/render completely
    await tester.pumpAndSettle();

    final editButtonFinder = find.byKey(const Key('editSaveCustomButtonKey'));
    expect(editButtonFinder, findsOneWidget);

    // Scroll to the button if it's not visible
    await tester.ensureVisible(editButtonFinder);
    await tester.pumpAndSettle();

    // Tap the edit button
    await tester.tap(editButtonFinder);
    await tester.pumpAndSettle(); // Wait for animations/transitions to complete

    final genderTextFieldFinder =
        find.byKey(const Key('genderCustomTextFieldKey'));
    expect(genderTextFieldFinder, findsOneWidget);

    // Enter text into the gender form field
    await tester.enterText(genderTextFieldFinder, 'Male');
    await tester.pump(); // Trigger a rebuild

    // Verify the text in the field
    expect(find.text('Male'), findsOneWidget);

    // Clear the text field
    await tester.enterText(genderTextFieldFinder, '');
    await tester.pump(); // Trigger a rebuild

    // Trigger validation
    await tester.pumpAndSettle();

    // Verify "Enter your gender" error is displayed
    expect(find.text('Enter your gender'), findsOneWidget);

    // Enter text into the gender form field again
    await tester.enterText(genderTextFieldFinder, 'Female');
    await tester.pump(); // Trigger a rebuild

    // Verify the new text in the field
    expect(find.text('Female'), findsOneWidget);

    // Trigger validation
    await tester.pumpAndSettle();
    // We might not need this additional pump, but it's included for consistency
  });

  testWidgets('Profile Page bio', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));

    // Wait for the UI to settle/render completely
    await tester.pumpAndSettle();

    final editButtonFinder = find.byKey(const Key('editSaveCustomButtonKey'));
    expect(editButtonFinder, findsOneWidget);

    // Scroll to the button if it's not visible
    await tester.ensureVisible(editButtonFinder);
    await tester.pumpAndSettle();

    // Tap the edit button
    await tester.tap(editButtonFinder);
    await tester.pumpAndSettle(); // Wait for animations/transitions to complete

    final bioTextFieldFinder = find.byKey(const Key('bioCustomTextFieldKey'));
    expect(bioTextFieldFinder, findsOneWidget);

    // Enter text into the bio form field
    await tester.enterText(
        bioTextFieldFinder, 'A text bio profile description');
    await tester.pump(); // Trigger a rebuild

    // Verify the text in the field
    expect(find.text('A text bio profile description'), findsOneWidget);

    // Clear the text field
    await tester.enterText(bioTextFieldFinder, '');
    await tester.pump(); // Trigger a rebuild

    // Trigger validation
    await tester.pumpAndSettle();

    // Verify "Enter your bio" error is displayed
    expect(find.text('Enter your bio'), findsOneWidget);

    // Enter text into the gender form field again
    await tester.enterText(
        bioTextFieldFinder, 'Another text bio profile description');
    await tester.pump(); // Trigger a rebuild

    // Verify the new text in the field
    expect(find.text('Another text bio profile description'), findsOneWidget);

    // Trigger validation
    await tester.pumpAndSettle();
    // We might not need this additional pump, but it's included for consistency
  });
/*
  testWidgets('ProfilePage edit button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));
    // Test Forgot Password button
    final editButtonFinder = find.byKey(const Key('editSaveCustomButtonKey'));
    expect(editButtonFinder, findsOneWidget);
  });

  // Test the visibility toggle for the password field
  //final visibilityButtonFinder = find.byKey(Key('visibilityButton'));
  //expect(visibilityButtonFinder, findsOneWidget);

  //await tester.tap(visibilityButtonFinder);
  //await tester.pump();
/*
  testWidgets('Profile Page visibility icons', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));
    // Assuming the visibility icon changes when tapped, test for updated visibility
    //expect(find.byIcon(Icons.visibility), findsNothing);
    final visibilityButtonFinder = find.byKey(Key('visibilityButton'));
    expect(visibilityButtonFinder, findsOneWidget);

    //await tester.tap(visibilityButtonFinder);
    //await tester.pump();
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
  });

/*
  testWidgets('Profile Page visibility icons', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));
    // Assuming the visibility icon changes when tapped, test for updated visibility
    expect(find.byIcon(Icons.visibility), findsNothing);
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
  });
*/

/*
  testWidgets('Profile Page close button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));
    // Test if close button exists
    final loginButtonFinder = find.byKey(const Key('closeCustomButtonKey'));
    expect(loginButtonFinder, findsOneWidget);
  });
*/

/*
  testWidgets('ProfilePage delete button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));
    final deleteCustomButtonFinder =
        find.byKey(const Key('deleteCustomButtonKey'));
    expect(deleteCustomButtonFinder, findsOneWidget);
  });*/  */ */
}
