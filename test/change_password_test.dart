import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:trip_tales/src/widgets/change_password.dart';

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
