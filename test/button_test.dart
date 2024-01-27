import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/widgets/button.dart';

void main() {
  testWidgets('Button text and onPressed callback',
      (WidgetTester tester) async {
    bool onPressedCalled = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CustomButton(
            text: 'Test Button',
            onPressed: () {
              onPressedCalled = true;
            },
          ),
        ),
      ),
    );

    expect(find.text('Test Button'), findsOneWidget);

    await tester.tap(find.text('Test Button'));
    await tester.pump();

    expect(onPressedCalled, isTrue);
  });

  testWidgets('Button disabled state', (WidgetTester tester) async {
    bool onPressedCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CustomButton(
            text: 'Disabled Button',
            onPressed: () {
              onPressedCalled = true;
            },
            isDisabled: true,
          ),
        ),
      ),
    );

    // Find the ElevatedButton widget
    final buttonFinder = find.byType(ElevatedButton);
    expect(buttonFinder, findsOneWidget);

    // Verify the button is disabled
    final buttonWidget = tester.widget<ElevatedButton>(buttonFinder);
    expect(buttonWidget.enabled, isFalse);

    // Attempt to tap the disabled button
    await tester.tap(buttonFinder);
    await tester.pump();

    // Verify onPressed is not called when the button is disabled
    expect(onPressedCalled, isFalse);
  });

  testWidgets('Button loading state', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CustomButton(
            text: 'Loading Button',
            onPressed: () {},
            isLoading: true,
          ),
        ),
      ),
    );

    final progressIndicatorFinder = find.byType(CircularProgressIndicator);
    expect(progressIndicatorFinder, findsOneWidget);

    final buttonTextFinder = find.text('Loading Button');
    expect(buttonTextFinder,
        findsNothing); // Text should be replaced by CircularProgressIndicator
  });
  testWidgets('Button customization', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CustomButton(
            text: 'Custom Button',
            onPressed: () {},
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 20.0,
            borderRadius: 15.0,
          ),
        ),
      ),
    );

    final customButtonFinder = find.byType(CustomButton);
    expect(customButtonFinder, findsOneWidget);

    final customButtonWidget = tester.widget<CustomButton>(customButtonFinder);

    expect(customButtonWidget.backgroundColor, Colors.blue);
    expect(customButtonWidget.textColor, Colors.white);
    expect(customButtonWidget.fontSize, 20.0);
    expect(customButtonWidget.borderRadius, 15.0);
  });

  testWidgets('Button with zero height and width', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CustomButton(
            text: 'Zero Size Button',
            onPressed: () {},
            height: 0,
            width: 0,
          ),
        ),
      ),
    );

    final buttonFinder = find.byType(CustomButton);
    expect(buttonFinder, findsOneWidget);

    final buttonWidget = tester.widget<CustomButton>(buttonFinder);
    expect(buttonWidget.height, 0);
    expect(buttonWidget.width, 0);
  });

  testWidgets('Button border radius', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CustomButton(
            text: 'Rounded Button',
            onPressed: () {},
            borderRadius: 20.0,
          ),
        ),
      ),
    );

    final buttonFinder = find.byType(CustomButton);
    expect(buttonFinder, findsOneWidget);

    final customButtonWidget = tester.widget<CustomButton>(buttonFinder);
    expect(
      customButtonWidget.borderRadius,
      20.0,
    );
  });

  testWidgets('Button with icon', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CustomButton(
            text: 'Icon Button',
            onPressed: () {},
            icon: Icons.access_alarm,
          ),
        ),
      ),
    );

    final iconFinder = find.byIcon(Icons.access_alarm);
    expect(iconFinder, findsOneWidget);
  });

  testWidgets('Button disabling and interaction', (WidgetTester tester) async {
    bool onPressedCalled = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CustomButton(
            text: 'Disabled Button',
            onPressed: () {
              onPressedCalled = true;
            },
            isDisabled: true,
          ),
        ),
      ),
    );

    final buttonFinder = find.text('Disabled Button');
    await tester.tap(buttonFinder);
    await tester.pump();

    expect(onPressedCalled,
        isFalse); // onPressed should not be called when the button is disabled
  });

  testWidgets('Button appearance during loading state',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CustomButton(
            text: 'Loading State Button',
            onPressed: () {},
            isLoading: true,
          ),
        ),
      ),
    );

    final progressIndicatorFinder = find.byType(CircularProgressIndicator);
    final textFinder = find.text('Loading State Button');

    expect(progressIndicatorFinder, findsOneWidget);
    expect(textFinder, findsNothing);
  });

  testWidgets('Button with custom key', (WidgetTester tester) async {
    final customKey = Key('test_button');
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CustomButton(
            key: customKey,
            text: 'Custom Key Button',
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.byKey(customKey), findsOneWidget);
  });

  testWidgets('Button with custom key', (WidgetTester tester) async {
    final customKey = Key('test_button');
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CustomButton(
            key: customKey,
            text: 'Custom Key Button',
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.byKey(customKey), findsOneWidget);
  });

  testWidgets('Button visibility based on condition',
      (WidgetTester tester) async {
    // Show the button
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CustomButton(
            text: 'Visible Button',
            onPressed: () {},
            isDisabled: false, // Ensure the button is not disabled
          ),
        ),
      ),
    );

    expect(find.text('Visible Button'), findsOneWidget);

    // Hide the button conditionally
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Visibility(
            visible: false, // Set visibility to false to hide the button
            child: CustomButton(
              text: 'Visible Button',
              onPressed: () {},
              isDisabled: true, // Set the button as disabled if required
            ),
          ),
        ),
      ),
    );

    expect(find.text('Visible Button'),
        findsNothing); // Button should not be visible
  });

  testWidgets('Button without icon', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CustomButton(
            text: 'Button Without Icon',
            onPressed: () {},
          ),
        ),
      ),
    );

    final iconFinder = find.byIcon(Icons.ac_unit);
    expect(iconFinder, findsNothing); // Icon should not be present
  });

  testWidgets('Button with large text', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CustomButton(
            text: 'Large Text Button',
            onPressed: () {},
            fontSize: 30.0,
          ),
        ),
      ),
    );

    final textFinder = find.text('Large Text Button');
    final textWidget = tester.widget<Text>(textFinder);

    expect(textWidget.style?.fontSize, 30.0); // Verify text size
  });
}
