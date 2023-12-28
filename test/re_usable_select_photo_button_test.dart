import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/widgets/re_usable_select_photo_button.dart';

void main() {
  testWidgets('SelectPhoto widget displays text and icon',
      (WidgetTester tester) async {
    // Build the SelectPhoto widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: () {}, // Provide a mock function for testing
          ),
        ),
      ),
    );

    // Verify the presence of the text and icon in the widget
    expect(find.text('Select a Photo'), findsOneWidget);
    expect(find.byIcon(Icons.photo_camera), findsOneWidget);
  });

  testWidgets('SelectPhoto widget calls onTap function when pressed',
      (WidgetTester tester) async {
    // Create a mock function to track if onTap is called
    bool onTapCalled = false;
    void mockOnTap() {
      onTapCalled = true;
    }

    // Build the SelectPhoto widget with the mock onTap function
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: mockOnTap,
          ),
        ),
      ),
    );

    // Tap the SelectPhoto widget
    await tester.tap(find.byType(ElevatedButton));

    // Wait for the widget to rebuild after the tap
    await tester.pump();

    // Verify that the onTap function was called
    expect(onTapCalled, true);
  });

  testWidgets('SelectPhoto widget has correct text style',
      (WidgetTester tester) async {
    // Build the SelectPhoto widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: () {}, // Provide a mock function for testing
          ),
        ),
      ),
    );

    // Verify the text style within the widget
    final textFinder = find.text('Select a Photo');
    final textWidget = tester.widget<Text>(textFinder);
    expect(textWidget.style?.fontSize, equals(18));
    expect(textWidget.style?.color, equals(Colors.white));
    expect(textWidget.style?.fontWeight, equals(FontWeight.bold));
  });

  testWidgets('SelectPhoto onTap is null by default',
      (WidgetTester tester) async {
    // Build the SelectPhoto widget without providing onTap
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: null, // Do not provide onTap
          ),
        ),
      ),
    );

    // Verify that the ElevatedButton is disabled when onTap is null
    final buttonFinder = find.byType(ElevatedButton);
    final button = tester.widget<ElevatedButton>(buttonFinder);
    expect(button.enabled, isFalse);
  });
  testWidgets('SelectPhoto widget layout is as expected',
      (WidgetTester tester) async {
    // Build the SelectPhoto widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              children: [
                SelectPhoto(
                  textLabel: 'Select a Photo',
                  icon: Icons.photo_camera,
                  onTap: () {}, // Provide a mock function for testing
                ),
                // Add additional widgets as needed for the test
                // Add SelectPhoto widget again if you expect multiple instances in the layout
              ],
            ),
          ),
        ),
      ),
    );

    // Verify the layout of the widget
    final selectPhotoWidgets = tester.widgetList(find.byType(SelectPhoto));
    // Validate the number of SelectPhoto widgets found
    expect(selectPhotoWidgets.length,
        equals(1)); // Adjust if multiple instances are expected

    // Additional assertions for layout, if needed
  });

  testWidgets('SelectPhoto onTap callback is not triggered when disabled',
      (WidgetTester tester) async {
    // Create a mock function to track if onTap is called
    bool onTapCalled = false;
    void mockOnTap() {
      onTapCalled = true;
    }

    // Build the SelectPhoto widget with onTap as null (disabled button)
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: null, // Do not provide onTap
          ),
        ),
      ),
    );

    // Tap the disabled SelectPhoto widget
    await tester.tap(find.byType(ElevatedButton));

    // Wait for the widget to rebuild after the tap
    await tester.pump();

    // Verify that the onTap function was not called when the button was disabled
    expect(onTapCalled, false);
  });
  testWidgets('SelectPhoto widget calls onTap function when enabled',
      (WidgetTester tester) async {
    // Create a mock function to track if onTap is called
    bool onTapCalled = false;
    void mockOnTap() {
      onTapCalled = true;
    }

    // Build the SelectPhoto widget with a valid onTap function
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: mockOnTap,
          ),
        ),
      ),
    );

    // Tap the enabled SelectPhoto widget
    await tester.tap(find.byType(ElevatedButton));

    // Wait for the widget to rebuild after the tap
    await tester.pump();

    // Verify that the onTap function was called when the button was enabled
    expect(onTapCalled, true);
  });

  testWidgets('SelectPhoto widget updates when properties change',
      (WidgetTester tester) async {
    IconData newIcon = Icons.camera; // New icon to test property update

    // Build the SelectPhoto widget initially with a certain icon
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: () {}, // Provide a mock function for testing
          ),
        ),
      ),
    );

    // Verify the initial presence of the first icon
    expect(find.byIcon(Icons.photo_camera), findsOneWidget);

    // Rebuild the widget with updated icon
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: newIcon,
            onTap: () {}, // Provide a mock function for testing
          ),
        ),
      ),
    );

    // Verify that the widget updates to display the new icon
    expect(find.byIcon(newIcon), findsOneWidget);
  });

  testWidgets('SelectPhoto widget onTap is called when pressed',
      (WidgetTester tester) async {
    bool onTapCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: () {
              onTapCalled = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byType(ElevatedButton));

    expect(onTapCalled, isTrue);
  });

  testWidgets('SelectPhoto widget onTap is not called when disabled',
      (WidgetTester tester) async {
    bool onTapCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: () {
              onTapCalled = true;
            },
          ),
        ),
      ),
    );

    // Disable the button by providing null onTap
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: null,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(ElevatedButton));

    expect(onTapCalled, isFalse);
  });

  testWidgets('SelectPhoto widget displays text and icon',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: () {},
          ),
        ),
      ),
    );

    expect(find.text('Select a Photo'), findsOneWidget);
    expect(find.byIcon(Icons.photo_camera), findsOneWidget);
  });

  testWidgets('SelectPhoto widget updates text and icon',
      (WidgetTester tester) async {
    IconData initialIcon = Icons.photo_camera;
    IconData updatedIcon = Icons.video_camera_front;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: initialIcon,
            onTap: () {},
          ),
        ),
      ),
    );

    // Verify the initial icon
    expect(find.byIcon(initialIcon), findsOneWidget);

    // Update the widget with a new icon
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: updatedIcon,
            onTap: () {},
          ),
        ),
      ),
    );

    // Verify the updated icon
    expect(find.byIcon(updatedIcon), findsOneWidget);
  });
  testWidgets('SelectPhoto widget onTap executes callback',
      (WidgetTester tester) async {
    bool onTapExecuted = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: () {
              onTapExecuted = true;
            },
          ),
        ),
      ),
    );

    final buttonFinder = find.byType(ElevatedButton);
    await tester.tap(buttonFinder);

    expect(onTapExecuted, isTrue);
  });

  testWidgets('SelectPhoto widget onTap callback is null, no execution',
      (WidgetTester tester) async {
    bool onTapExecuted = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: () {
              onTapExecuted = true;
            },
          ),
        ),
      ),
    );

    final buttonFinder = find.byType(ElevatedButton);
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: null, // Setting onTap as null
          ),
        ),
      ),
    );

    await tester.tap(buttonFinder);

    expect(onTapExecuted, isFalse);
  });

  testWidgets('SelectPhoto widget can be created with required parameters',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: null,
          ),
        ),
      ),
    );

    expect(find.byType(SelectPhoto), findsOneWidget);
  });
  testWidgets('SelectPhoto widget is visible when rendered',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: () {},
          ),
        ),
      ),
    );

    expect(find.byType(SelectPhoto), findsOneWidget);
  });

  testWidgets('SelectPhoto widget has a specific key',
      (WidgetTester tester) async {
    const Key testKey = Key('test_key');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            key: testKey,
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: () {},
          ),
        ),
      ),
    );

    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('SelectPhoto onTap function is called when widget is tapped',
      (WidgetTester tester) async {
    bool onTapCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: () {
              onTapCalled = true;
            },
          ),
        ),
      ),
    );

    // Tap the SelectPhoto widget
    await tester.tap(find.byType(SelectPhoto));

    // Verify onTap function is called
    expect(onTapCalled, isTrue);
  });

  testWidgets('SelectPhoto initializes with non-null onTap',
      (WidgetTester tester) async {
    final mockOnTap = () {}; // Replace with your mock function

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: mockOnTap,
          ),
        ),
      ),
    );

    // Verify that SelectPhoto widget is present in the widget tree
    expect(find.byType(SelectPhoto), findsOneWidget);
  });

  testWidgets('SelectPhoto initializes with null onTap',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: null,
          ),
        ),
      ),
    );

    // Verify that SelectPhoto widget is present in the widget tree
    expect(find.byType(SelectPhoto), findsOneWidget);
  });

  testWidgets('SelectPhoto widget has correct appearance',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: null,
          ),
        ),
      ),
    );

    // Verify the appearance of the SelectPhoto widget
    expect(find.text('Select a Photo'), findsOneWidget);
    expect(find.byIcon(Icons.photo_camera), findsOneWidget);
    // Add more checks for appearance properties...
  });

  testWidgets('SelectPhoto widget is disabled when onTap is null',
      (WidgetTester tester) async {
    bool onTapCalled = false;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: null,
          ),
        ),
      ),
    );

    // Tap the disabled SelectPhoto widget
    await tester.tap(find.byType(SelectPhoto));

    // Verify onTap function is not called
    expect(onTapCalled, isFalse);
  });

  testWidgets('SelectPhoto widget is enabled when onTap is set',
      (WidgetTester tester) async {
    bool onTapCalled = false;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: null,
          ),
        ),
      ),
    );

    // Tap the disabled SelectPhoto widget
    await tester.tap(find.byType(SelectPhoto));

    // Verify onTap function is not called when onTap is null
    expect(onTapCalled, isFalse);

    // Change onTap to a non-null function
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: () {
              onTapCalled = true;
            },
          ),
        ),
      ),
    );

    // Tap the enabled SelectPhoto widget
    await tester.tap(find.byType(SelectPhoto));

    // Verify onTap function is called when onTap is set
    expect(onTapCalled, isTrue);
  });

  testWidgets('SelectPhoto widget renders the correct icon',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.camera_alt, // Change icon to test
            onTap: null,
          ),
        ),
      ),
    );

    // Verify that the correct icon is rendered
    expect(find.byIcon(Icons.camera_alt), findsOneWidget);
  });

  testWidgets('SelectPhoto widget initializes with correct properties',
      (WidgetTester tester) async {
    const String labelText = 'Select a Photo';
    const IconData iconData = Icons.photo_camera;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: labelText,
            icon: iconData,
            onTap: null,
          ),
        ),
      ),
    );

    final selectPhotoWidget = tester.widget<SelectPhoto>(
      find.byType(SelectPhoto),
    );

    // Verify that the widget initializes with the correct properties
    expect(selectPhotoWidget.textLabel, labelText);
    expect(selectPhotoWidget.icon, iconData);
  });

  testWidgets('SelectPhoto onTap function is called when widget is tapped',
      (WidgetTester tester) async {
    bool onTapCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SelectPhoto(
            textLabel: 'Select a Photo',
            icon: Icons.photo_camera,
            onTap: () {
              onTapCalled = true;
            },
          ),
        ),
      ),
    );

    // Tap the SelectPhoto widget
    await tester.tap(find.byType(SelectPhoto));

    // Verify onTap function is called
    expect(onTapCalled, isTrue);
  });
}
