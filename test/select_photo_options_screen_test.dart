import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:trip_tales/src/pages/register.dart';
import 'package:trip_tales/src/screen/select_photo_options_screen.dart';
import 'package:trip_tales/src/widgets/text_field.dart';

void main() {
  /*
  testWidgets('Select Photo Options Screen name', (WidgetTester tester) async {
    await tester.pumpWidget(Container(
        key: const Key('set_photo_options_screen_ContainerKey'),
        body: SelectPhotoOptionsScreen(
          onTap: (ImageSource source) {},
        )));
    final nameTextFieldFinder = find.byKey(const Key('nameCustomTextFieldKey'));
    expect(nameTextFieldFinder, findsOneWidget);
  });

  testWidgets('Select Photo Options Screen surname',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SelectPhotoOptionsScreen()));
    final surnameTextFieldFinder =
        find.byKey(const Key('surnameCustomTextFieldKey'));
    expect(surnameTextFieldFinder, findsOneWidget);
  });
  testWidgets('Select Photo Options Screen email', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SelectPhotoOptionsScreen()));

    final emailTextFieldFinder =
        find.byKey(const Key('emailCustomTextFieldKey'));
    expect(emailTextFieldFinder, findsOneWidget);

    await tester.enterText(emailTextFieldFinder, '');
    // Test typing in Email and Password fields
    await tester.enterText(emailTextFieldFinder, 'example@example.com');
    expect(find.text('example@example.com'), findsOneWidget);

    await tester.pump();
  });

  testWidgets('Select Photo Options Screen birth date',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SelectPhotoOptionsScreen()));
    final dateBirthTextFieldFinder =
        find.byKey(const Key('birthDateCustomTextFieldKey'));
    expect(dateBirthTextFieldFinder, findsOneWidget);
    await tester.pump();
  });

  testWidgets('Select Photo Options Screen password',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SelectPhotoOptionsScreen()));

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

  testWidgets('Select Photo Options Screen confirm password',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SelectPhotoOptionsScreen()));

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
  */
}
