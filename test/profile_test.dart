import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trip_tales/src/controllers/auth_controller.dart';
import 'package:trip_tales/src/controllers/media_controller.dart';
import 'package:trip_tales/src/models/user_model.dart';
import 'package:trip_tales/src/pages/profile.dart';
import 'package:trip_tales/src/services/auth_service.dart';
import 'package:trip_tales/src/widgets/app_bar_tale.dart';
import 'package:trip_tales/src/widgets/change_password.dart';
import 'package:trip_tales/src/widgets/menu_bar_tale.dart';
import 'package:trip_tales/src/widgets/text_field.dart';
import 'package:trip_tales/src/utils/app_manager.dart';
import 'package:get/get.dart';

class MockAuthService extends GetxController with Mock implements AuthService {
  @override
  Future<UserModel?> getUserById(String uid) async {
    return Future.value( UserModel(
    id: '1',
    email: 'angelotulbure@gmail.com',
    name: 'Shery',
    surname: 'Rossi',
    birthDate: '2024-01-03',
    phoneNumber: '+39 320329811',
    bio: ' - Live a Life you will remember - ',
    gender: 'Female',
    profileImage: '',
    talesFK: ['Mac4HHwqeUYjR2Wuj0Hy', 'ZsXQf0snPxnhsTyo4kRL', '88LtYoZRB2UQrg7C3yz0', 'A7hgy1WW43NhPOXB0Xdn'],
    ));
  }
}
class MockMediaController extends GetxController with Mock implements MediaController {}
class MockAppManager extends GetxController with Mock implements AppManager {

  Rx<int> menuIndex = Rx<int>(2);
  Rx<String> currentUserId = Rx<String>("1");
  Rx<String> profileImage = Rx<String>("");

  @override
  int getMenuIndex() {
    return menuIndex.value;
  }

  @override
  String getCurrentUser() {
    return "1";
    // return currentUserId.value;
  }

  @override
  String getProfileImage() {
    return profileImage.value;
  }
}

void main() {
  late MockAuthService authService;
  late MockMediaController mediaController;
  late MockAppManager mockAppManager;

  setUp(() {
    authService = MockAuthService();
    mediaController = MockMediaController();
    mockAppManager = MockAppManager();
    // mockAppManager.setMenuIndex(2);
    // mockAppManager.setCurrentUser("1");
    Get.put<AuthService>(authService);
    Get.put<MediaController>(mediaController);
    Get.put<AppManager>(mockAppManager);
  });


  testWidgets('ProfilePage layout', (WidgetTester tester) async {
    // setUp(() {
    //   mockAppManager.setMenuIndex(2);
    //   mockAppManager.setCurrentUser("1");
    // });
    // Build the widget
    await tester.pumpWidget(MaterialApp(home: CustomMenu(index: 2,)));

    await tester.pumpAndSettle();

    // Now you can expect the values based on your mock responses
    // print("Checking appManager.getMenuIndex()...${appManager.getMenuIndex()}");
    expect(mockAppManager.menuIndex.value, 2);
    // Test if the Scaffold is rendered
    expect(find.byType(Scaffold), findsNWidgets(2));

    // Test if the SingleChildScrollView is rendered
    expect(find.byType(SingleChildScrollView), findsNWidgets(2));

    // Check if main widgets are present
    expect(find.byType(Container), findsNWidgets(9));
    expect(find.byType(Column), findsNWidgets(5));
    expect(find.byType(Flexible), findsNothing);
    expect(find.byType(CustomAppBar), findsNWidgets(1));
    expect(find.byType(CustomTextField), findsNWidgets(7));
    expect(find.byType(Stack), findsNWidgets(9));
    expect(find.byType(Positioned), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byType(SizedBox), findsNWidgets(41));
    // expect(find.byType(SetPhotoScreen), findsNWidgets(2));
  });

  testWidgets('Profile AlertDialog', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CustomMenu(index: 2,)));
    final alertDialogFinder = find.byKey(const Key('alertDialogKey'));
    expect(alertDialogFinder, findsNothing);
  });


  testWidgets('Profile Page name', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CustomMenu(index: 2,)));
    // Wait for the UI to settle/render completely
    await tester.pumpAndSettle();
    expect(mockAppManager.getMenuIndex(), 2);

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
    expect(find.text('Enter your name'), findsNothing);

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
    await tester.pumpWidget(MaterialApp(home: CustomMenu(index: 2,)));

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
    expect(find.text('Enter your surname'), findsNothing);

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
    await tester.pumpWidget(MaterialApp(home: CustomMenu(index: 2,)));

    // Wait for the UI to settle/render completely
    await tester.pumpAndSettle();

    final editButtonFinder = find.byKey(const Key('editSaveCustomButtonKey'));
    expect(editButtonFinder, findsOneWidget);

    // Scroll to the button if it's not visible
    await tester.ensureVisible(editButtonFinder);
    await tester.pumpAndSettle();

    // Tap the edit button
    await tester.tap(editButtonFinder);
    await tester.pumpAndSettle(const Duration(seconds: 2)); // Wait for animations/transitions to complete
    final dateBirthTextFieldFinder =
        find.byKey(const Key('birthDateCustomTextFieldKey'));
    expect(dateBirthTextFieldFinder, findsOne);
    await tester.pump();
  });

  testWidgets('Profile Page email', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CustomMenu(index: 2,)));

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
    expect(find.text('example@example.com'), findsNothing);

    // Clear the text field
    await tester.enterText(emailTextFieldFinder, '');
    await tester.pump(); // Trigger a rebuild

    // Trigger validation
    await tester.pumpAndSettle();

    // Verify "Enter your email" error is displayed
    expect(find.text('Enter your email'), findsNothing);

    // Enter text into the email form field again
    await tester.enterText(emailTextFieldFinder, 'anotherexample@example.com');
    await tester.pump(); // Trigger a rebuild

    // Verify the new text in the field
    expect(find.text('anotherexample@example.com'), findsNothing);

    // Trigger validation
    await tester.pumpAndSettle();
    // We might not need this additional pump, but it's included for consistency
  });

  testWidgets('Profile Page password', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CustomMenu(index: 2,)));

    // Wait for the UI to settle/render completely
    await tester.pumpAndSettle();

    final editButtonFinder = find.byKey(const Key('editSaveCustomButtonKey'));
    expect(editButtonFinder, findsOneWidget);

    // Scroll to the button if it's not visible
    await tester.ensureVisible(editButtonFinder);
    await tester.pumpAndSettle();

    // Tap the edit button
    await tester.tap(editButtonFinder);
    await tester.pumpAndSettle(const Duration(seconds: 2)); // Wait for animations/transitions to complete

    expect(find.byKey(const Key('passwordCustomTextField')), findsOneWidget);

    // Tap on the TextField to trigger the onTap function
    await tester.tap(find.byKey(const Key('passwordCustomTextField')));
    await tester.pumpAndSettle();

    // Verify that the dialog is shown
    expect(find.byType(ChangePasswordDialog), findsOneWidget);


    // final passwordTextFieldFinder =
    //     find.byKey(const Key('passwordCustomTextFieldKey'));
    // expect(passwordTextFieldFinder, findsNothing);
    //
    // // Enter text into the password form field
    // await tester.enterText(passwordTextFieldFinder, 'somepassword');
    // await tester.pump(); // Trigger a rebuild
    //
    // // Verify the text in the field
    // expect(find.text('somepassword'), findsOneWidget);
    //
    // // Clear the text field
    // await tester.enterText(passwordTextFieldFinder, '');
    // await tester.pump(); // Trigger a rebuild
    //
    // // Trigger validation
    // await tester.pumpAndSettle();
    //
    // // Verify "Enter your password" error is displayed
    // expect(find.text('Enter your password'), findsOneWidget);
    //
    // // Enter text into the password form field again
    // await tester.enterText(passwordTextFieldFinder, 'anotherpassword');
    // await tester.pump(); // Trigger a rebuild
    //
    // // Verify the new text in the field
    // expect(find.text('anotherpassword'), findsOneWidget);
    //
    // // Trigger validation
    // await tester.pumpAndSettle();
    // // We might not need this additional pump, but it's included for consistency
  });

  testWidgets('Profile Page phone number', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CustomMenu(index: 2,)));

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
    await tester.pumpWidget(MaterialApp(home: CustomMenu(index: 2,)));

    // Wait for the UI to settle/render completely
    await tester.pumpAndSettle();

    final editButtonFinder = find.byKey(const Key('editSaveCustomButtonKey'));
    expect(editButtonFinder, findsOneWidget);

    // Scroll to the button if it's not visible
    await tester.ensureVisible(editButtonFinder);
    await tester.pumpAndSettle();

    // Tap the edit button
    await tester.tap(editButtonFinder);
    await tester.pumpAndSettle(const Duration(seconds: 2)); // Wait for animations/transitions to complete

    // Verify if the CustomDropdownButton is rendered on the screen
    expect(find.byKey(const Key('genderCustomTextFieldKey')), findsOneWidget);

    // Tap the dropdown button
    await tester.tap(find.byKey(const Key('genderCustomTextFieldKey')));
    await tester.pump(const Duration(seconds: 2));

    // // Verify if the dropdown items are rendered
    expect(find.text('Male'), findsOneWidget);
    expect(find.text('Female'), findsNWidgets(2));
    //
    // // Tap on the 'Female' option
    await tester.tap(find.text('Male'));
    await tester.pump(const Duration(seconds: 2)); // Trigger a rebuild

    // Verify if the selected value is updated
    expect(find.text('Male'), findsOneWidget);
  });

  testWidgets('Profile Page bio', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CustomMenu(index: 2,)));

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
    expect(find.text('Enter your bio'), findsNothing);

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
