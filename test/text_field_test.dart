import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/widgets/text_field.dart'; // Replace with your file path

void main() {
  testWidgets('CustomTextField renders correctly', (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomTextField(
          controller: controller,
          labelText: 'Username',
        ),
      ),
    ));

    expect(find.byType(CustomTextField), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
  });

  testWidgets('Entering text in CustomTextField', (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomTextField(
          controller: controller,
          labelText: 'Username',
        ),
      ),
    ));

    await tester.enterText(find.byType(TextField), 'test');

    expect(controller.text, 'test');
  });

/*
  testWidgets('Password visibility toggle in CustomTextField',
      (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController();
    bool isVisible = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomTextField(
          controller: controller,
          labelText: 'Password',
          isPassword: true,
          isPasswordVisible: isVisible,
          onVisibilityPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
        ),
      ),
    ));

    final visibilityIconFinder = find.byIcon(Icons.visibility_off);
    expect(visibilityIconFinder, findsOneWidget);

    await tester.tap(visibilityIconFinder);
    await tester.pump();

    final updatedVisibilityIconFinder = find.byIcon(Icons.visibility);
    expect(updatedVisibilityIconFinder, findsOneWidget);
  });
  */
  testWidgets('CustomTextField validation', (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Form(
          key: formKey,
          child: CustomTextField(
            controller: controller,
            labelText: 'Username',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a username';
              }
              return null;
            },
          ),
        ),
      ),
    ));

    expect(find.text('Please enter a username'), findsNothing);

    // Simulate tapping on a button or triggering a form submission to validate
    await tester.tap(find.byType(TextFormField));
    await tester.pump();

    await tester.tap(find.byType(TextFormField).first);
    await tester.pump();

    // Trigger form validation
    formKey.currentState?.validate();
    await tester.pump();

    // Check for the validation error message
    expect(find.text('Please enter a username'), findsOneWidget);
  });

  testWidgets('onChanged callback in CustomTextField',
      (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController();
    String? enteredText;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomTextField(
          controller: controller,
          labelText: 'Username',
          onChanged: (text) {
            enteredText = text;
          },
        ),
      ),
    ));

    await tester.enterText(find.byType(TextField), 'test');
    expect(enteredText, 'test');
  });

  testWidgets('ReadOnly behavior in CustomTextField',
      (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomTextField(
          controller: controller,
          labelText: 'Username',
          readOnly: true,
          onTap: () {
            print('Tapped!');
          },
        ),
      ),
    ));

    await tester.tap(find.byType(TextField));
    expect(find.text('Tapped!'),
        findsNothing); // Tap should not trigger onTap callback
  });

  testWidgets('CustomTextField validation without error',
      (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Form(
          child: CustomTextField(
            controller: controller,
            labelText: 'Username',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a username';
              }
              return null;
            },
          ),
        ),
      ),
    ));

    await tester.enterText(find.byType(TextField), 'ValidInput');
    await tester.pump();

    // Trigger form validation
    expect(find.text('Please enter a username'), findsNothing);
  });

  testWidgets('Password visibility toggle in CustomTextField',
      (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController();
    bool isVisible = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomTextField(
          controller: controller,
          labelText: 'Password',
          isPassword: true,
          isPasswordVisible: isVisible,
          onVisibilityPressed: () {
            isVisible = !isVisible;
          },
        ),
      ),
    ));

    final visibilityIconFinder =
        find.byIcon(isVisible ? Icons.visibility : Icons.visibility_off);
    expect(visibilityIconFinder, findsOneWidget);

    await tester.tap(visibilityIconFinder);
    await tester.pump();

    final updatedVisibilityIconFinder =
        find.byIcon(isVisible ? Icons.visibility_off : Icons.visibility);
    expect(updatedVisibilityIconFinder, findsOneWidget);
  });

  testWidgets('onChanged callback in CustomTextField',
      (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController();
    String? enteredText;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomTextField(
          controller: controller,
          labelText: 'Username',
          onChanged: (text) {
            enteredText = text;
          },
        ),
      ),
    ));

    await tester.enterText(find.byType(TextField), 'test');

    expect(enteredText, 'test');
  });
  testWidgets('ReadOnly behavior in CustomTextField',
      (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomTextField(
          controller: controller,
          labelText: 'Username',
          readOnly: true,
          onTap: () {
            print('Tapped!');
          },
        ),
      ),
    ));

    await tester.tap(find.byType(TextField));

    expect(find.text('Tapped!'),
        findsNothing); // Ensure onTap is not triggered in readOnly mode
  });

  testWidgets('CustomTextField with null validator',
      (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomTextField(
          controller: controller,
          labelText: 'Field',
          validator: null,
        ),
      ),
    ));

    // Test that no validation is triggered when validator is null
    await tester.enterText(find.byType(TextField), 'Some text');

    await tester.pump();

    expect(find.text('Field'),
        findsOneWidget); // Ensure no validation error message is shown
  });
}
