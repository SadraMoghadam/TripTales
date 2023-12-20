import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/pages/profile.dart';
import 'package:trip_tales/src/screen/set_photo_screen.dart';
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

  testWidgets('Profile Page email', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));

    final editButtonFinder = find.byKey(const Key('editSaveCustomButtonKey'));
    expect(editButtonFinder, findsOneWidget);
    await tester.tap(editButtonFinder);

    final emailTextFieldFinder =
        find.byKey(const Key('emailCustomTextFieldKey'));
    expect(emailTextFieldFinder, findsOneWidget);

    await tester.enterText(emailTextFieldFinder, '');
    // Test typing in Email and Password fields
    await tester.enterText(emailTextFieldFinder, 'example@example.com');
    expect(find.text('example@example.com'), findsOneWidget);

    await tester.pump();
  });

  testWidgets('Profile Page name', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));
    final editButtonFinder = find.byKey(const Key('editSaveCustomButtonKey'));
    expect(editButtonFinder, findsOneWidget);
    await tester.tap(editButtonFinder);
    final nameTextFieldFinder = find.byKey(const Key('nameCustomTextFieldKey'));
    expect(nameTextFieldFinder, findsOneWidget);
    await tester.pump();
  });

  testWidgets('Profile Page surname', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));
    final editButtonFinder = find.byKey(const Key('editSaveCustomButtonKey'));
    expect(editButtonFinder, findsOneWidget);
    await tester.tap(editButtonFinder);
    final surnameTextFieldFinder =
        find.byKey(const Key('surnameCustomTextFieldKey'));
    expect(surnameTextFieldFinder, findsOneWidget);
    await tester.pump();
  });

  testWidgets('Profile Page birth date', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));
    final editButtonFinder = find.byKey(const Key('editSaveCustomButtonKey'));
    expect(editButtonFinder, findsOneWidget);
    await tester.tap(editButtonFinder);
    final dateBirthTextFieldFinder =
        find.byKey(const Key('birthDateCustomTextFieldKey'));
    expect(dateBirthTextFieldFinder, findsOneWidget);
    await tester.pump();
  });

  testWidgets('Profile Page password', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));
    final editButtonFinder = find.byKey(const Key('editSaveCustomButtonKey'));
    expect(editButtonFinder, findsOneWidget);
    await tester.tap(editButtonFinder);

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

  testWidgets('Profile Page phone number', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));
    final editButtonFinder = find.byKey(const Key('editSaveCustomButtonKey'));
    expect(editButtonFinder, findsOneWidget);
    await tester.tap(editButtonFinder);
    final phoneTextFieldFinder =
        find.byKey(const Key('phoneNumberCustomTextFieldKey'));
    expect(phoneTextFieldFinder, findsOneWidget);
    await tester.pump();
  });

  testWidgets('Profile Page gender', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));
    final editButtonFinder = find.byKey(const Key('editSaveCustomButtonKey'));
    expect(editButtonFinder, findsOneWidget);
    await tester.tap(editButtonFinder);
    final genderTextFieldFinder =
        find.byKey(const Key('genderCustomTextFieldKey'));
    expect(genderTextFieldFinder, findsOneWidget);
    await tester.pump();
  });

  testWidgets('Profile Page bio', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfilePage()));
    final editButtonFinder = find.byKey(const Key('editSaveCustomButtonKey'));
    expect(editButtonFinder, findsOneWidget);
    await tester.tap(editButtonFinder);
    final bioTextFieldFinder = find.byKey(const Key('bioCustomTextFieldKey'));
    expect(bioTextFieldFinder, findsOneWidget);
    await tester.pump();
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
