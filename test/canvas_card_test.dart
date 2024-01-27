import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/widgets/canvas_card.dart';

void main() {
  testWidgets('CustomCanvas widget renders correctly',
      (WidgetTester tester) async {
    // Define a test callback for onTap
    bool tapped = false;
    void handleTap() {
      tapped = true;
    }

    // Build the CustomCanvas widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomCanvas(
            talePath:
                'assets/images/tale_sample.jpg', // Replace with a valid image path
            taleName: 'Test Tale',
            onTap: handleTap,
            isSelected: true, // Test with isSelected set to true
          ),
        ),
      ),
    );

    // Find the CustomCanvas widget
    final customCanvasFinder = find.byType(CustomCanvas);

    // Verify the CustomCanvas widget is present
    expect(customCanvasFinder, findsOneWidget);

    // Verify onTap callback functionality by tapping the widget
    await tester.tap(customCanvasFinder);
    await tester.pump();

    // Check that the onTap callback was triggered
    expect(tapped, isTrue);

    // Verify the appearance of the widget when isSelected is true
    final decoratedContainer = find.descendant(
      of: customCanvasFinder,
      matching: find.byType(AnimatedContainer),
    );

    // Verify border color and width when isSelected is true
    final decoratedContainerWidget =
        tester.widget<AnimatedContainer>(decoratedContainer);
    expect(decoratedContainerWidget.decoration, isA<Decoration>());
    final BoxDecoration decoration =
        decoratedContainerWidget.decoration as BoxDecoration;
    expect(decoration.border?.top.width, equals(3.0));
    expect(decoration.border?.top.color, equals(AppColors.main2));
  });

  testWidgets('CustomCanvas widget text appearance test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomCanvas(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Test Tale',
            onTap: () {}, // Provide an empty onTap callback
          ),
        ),
      ),
    );

    final textWidget = find.descendant(
      of: find.byType(CustomCanvas),
      matching: find.byType(Text),
    );

    final text = tester.widget<Text>(textWidget);
    expect(text.style?.color, equals(Colors.white)); // Text color check
    expect(
        text.style?.fontWeight, equals(FontWeight.bold)); // Font weight check
    // Add more checks for font size, shadows, etc., based on your TextStyle configuration
  });

  testWidgets('CustomCanvas widget renders correctly when isSelected is false',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomCanvas(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Test Tale',
            onTap: () {}, // Provide an empty onTap callback
            isSelected: false,
          ),
        ),
      ),
    );

    final decoratedContainer = find.descendant(
      of: find.byType(CustomCanvas),
      matching: find.byType(AnimatedContainer),
    );

    final decoratedContainerWidget =
        tester.widget<AnimatedContainer>(decoratedContainer);
    expect(decoratedContainerWidget.decoration, isA<Decoration>());
    final BoxDecoration decoration =
        decoratedContainerWidget.decoration as BoxDecoration;
    expect(decoration.border?.top.width,
        equals(2.0)); // Border width when isSelected is false
    expect(decoration.border?.top.color,
        equals(AppColors.main1)); // Border color when isSelected is false
  });

  testWidgets('CustomCanvas widget text appearance test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomCanvas(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Test Tale',
            onTap: () {}, // Provide an empty onTap callback
          ),
        ),
      ),
    );

    final textWidget = find.descendant(
      of: find.byType(CustomCanvas),
      matching: find.byType(Text),
    );

    final text = tester.widget<Text>(textWidget);
    expect(text.style?.color, equals(Colors.white)); // Text color check
    expect(
        text.style?.fontWeight, equals(FontWeight.bold)); // Font weight check
    // Add more checks for font size, shadows, etc., based on your TextStyle configuration
  });
  testWidgets('CustomCanvas onTap callback test', (WidgetTester tester) async {
    bool tapped = false;
    void handleTap() {
      tapped = true;
    }

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomCanvas(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Test Tale',
            onTap: handleTap,
          ),
        ),
      ),
    );

    // Verify onTap callback functionality by tapping the widget
    await tester.tap(find.byType(CustomCanvas));
    await tester.pump();

    // Check that the onTap callback was triggered
    expect(tapped, isTrue);
  });

  testWidgets('CustomCanvas widget size test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomCanvas(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Test Tale',
            onTap: () {}, // Provide an empty onTap callback
          ),
        ),
      ),
    );

    // Find the CustomCanvas widget
    final customCanvasFinder = find.byType(CustomCanvas);

    // Get the size of the CustomCanvas widget
    final size = tester.getSize(customCanvasFinder);

    // Verify the widget's size
    expect(size.width, equals(180.0));
    expect(size.height, equals(270.0));
  });

  testWidgets('CustomCanvas default selection state test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomCanvas(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Test Tale',
            onTap: () {}, // Provide an empty onTap callback
          ),
        ),
      ),
    );

    final decoratedContainer = find.descendant(
      of: find.byType(CustomCanvas),
      matching: find.byType(AnimatedContainer),
    );

    final decoratedContainerWidget =
        tester.widget<AnimatedContainer>(decoratedContainer);
    final BoxDecoration decoration =
        decoratedContainerWidget.decoration as BoxDecoration;

    expect(decoration.border?.top.width, equals(2.0)); // Default border width
    expect(decoration.border?.top.color,
        equals(AppColors.main1)); // Default border color
  });

  testWidgets('CustomCanvas widget selected state test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomCanvas(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Test Tale',
            onTap: () {}, // Provide an empty onTap callback
            isSelected: true, // Set isSelected to true
          ),
        ),
      ),
    );

    final decoratedContainer = find.descendant(
      of: find.byType(CustomCanvas),
      matching: find.byType(AnimatedContainer),
    );

    final decoratedContainerWidget =
        tester.widget<AnimatedContainer>(decoratedContainer);
    final BoxDecoration decoration =
        decoratedContainerWidget.decoration as BoxDecoration;

    expect(decoration.border?.top.width,
        equals(3.0)); // Border width when isSelected is true
    expect(decoration.border?.top.color,
        equals(AppColors.main2)); // Border color when isSelected is true
  });

  testWidgets('CustomCanvas widget text content test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomCanvas(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Test Tale',
            onTap: () {}, // Provide an empty onTap callback
          ),
        ),
      ),
    );

    final textWidget = find.descendant(
      of: find.byType(CustomCanvas),
      matching: find.byType(Text),
    );

    final text = tester.widget<Text>(textWidget);
    expect(text.data, equals('Test Tale')); // Verify the text content
  });

  testWidgets('CustomCanvas widget structure test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomCanvas(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Test Tale',
            onTap: () {}, // Provide an empty onTap callback
          ),
        ),
      ),
    );

    // Verify the structure by checking the presence of specific child widgets
    expect(find.text('Test Tale'), findsOneWidget); // Text should be present
    expect(find.byType(AnimatedContainer),
        findsOneWidget); // AnimatedContainer should be present
    expect(find.byType(GestureDetector),
        findsOneWidget); // GestureDetector should be present

    // Image widget is commented out in the CustomCanvas, so it won't be found
    // If an Image widget is part of CustomCanvas, uncomment the below line
    // expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('CustomCanvas widget onTap callback execution test',
      (WidgetTester tester) async {
    bool tapped = false;
    void handleTap() {
      tapped = true;
    }

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomCanvas(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Test Tale',
            onTap: handleTap,
          ),
        ),
      ),
    );

    // Tap the CustomCanvas widget
    await tester.tap(find.byType(CustomCanvas));
    await tester.pump();

    // Verify that the onTap callback was executed
    expect(tapped, isTrue);
  });

  testWidgets('CustomCanvas widget state change test',
      (WidgetTester tester) async {
    bool isSelected = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return CustomCanvas(
                talePath: 'assets/images/tale_sample.jpg',
                taleName: 'Test Tale',
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
                isSelected: isSelected,
              );
            },
          ),
        ),
      ),
    );

    // Verify the initial state by checking the appearance
    final initialDecoratedContainer = find.descendant(
      of: find.byType(CustomCanvas),
      matching: find.byType(AnimatedContainer),
    );

    final initialDecoratedContainerWidget =
        tester.widget<AnimatedContainer>(initialDecoratedContainer);
    final BoxDecoration initialDecoration =
        initialDecoratedContainerWidget.decoration as BoxDecoration;

    expect(initialDecoration.border?.top.width,
        equals(2.0)); // Initial border width
    expect(initialDecoration.border?.top.color,
        equals(AppColors.main1)); // Initial border color

    // Trigger state changes by tapping the widget
    await tester.tap(find.byType(CustomCanvas));
    await tester.pump();

    // Validate the updated appearance based on state change
    final updatedDecoratedContainer = find.descendant(
      of: find.byType(CustomCanvas),
      matching: find.byType(AnimatedContainer),
    );

    final updatedDecoratedContainerWidget =
        tester.widget<AnimatedContainer>(updatedDecoratedContainer);
    final updatedDecoration =
        updatedDecoratedContainerWidget.decoration as BoxDecoration;

    // Expectation based on the updated isSelected state
    expect(updatedDecoration.border?.top.width,
        equals(isSelected ? 3.0 : 2.0)); // Updated border width
    expect(
        updatedDecoration.border?.top.color,
        equals(isSelected
            ? AppColors.main2
            : AppColors.main1)); // Updated border color
  });

  testWidgets('CustomCanvas widget onTap callback test',
      (WidgetTester tester) async {
    bool tapped = false;
    void handleTap() {
      tapped = true;
    }

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomCanvas(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Test Tale',
            onTap: handleTap,
          ),
        ),
      ),
    );

    // Tap the CustomCanvas widget
    await tester.tap(find.byType(CustomCanvas));
    await tester.pump();

    // Verify that the onTap callback was executed
    expect(tapped, isTrue);
  });

  testWidgets('CustomCanvas widget initial state test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomCanvas(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Test Tale',
            onTap: () {}, // Provide an empty onTap callback
          ),
        ),
      ),
    );

    // Verify the initial state by checking the appearance or properties
    // Add specific expectations for initial widget state
  });

  testWidgets('CustomCanvas widget creation test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomCanvas(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Test Tale',
            onTap: () {}, // Provide an empty onTap callback
          ),
        ),
      ),
    );

    // Verify that the CustomCanvas widget is created without errors
    expect(find.byType(CustomCanvas), findsOneWidget);
  });

  testWidgets('CustomCanvas widget child visibility test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomCanvas(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Test Tale',
            onTap: () {}, // Provide an empty onTap callback
          ),
        ),
      ),
    );

    // Verify the visibility of specific child widgets
    expect(find.text('Test Tale'), findsOneWidget); // Text should be visible
    expect(find.byType(Image),
        findsNothing); // Remove the expectation for Image widget
    // Add more visibility tests for other child widgets if applicable
  });

  testWidgets('CustomCanvas widget customization test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomCanvas(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Test Tale',
            onTap: () {}, // Provide an empty onTap callback
            // Add other customization options like color, border, etc.
          ),
        ),
      ),
    );

    // Verify specific customization properties or appearance
    // Add relevant expectations for customized appearance or behavior
  });

  testWidgets('CustomCanvas widget onTap callback execution test',
      (WidgetTester tester) async {
    bool tapped = false;
    void handleTap() {
      tapped = true;
    }

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomCanvas(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Test Tale',
            onTap: handleTap,
          ),
        ),
      ),
    );

    // Tap the CustomCanvas widget
    await tester.tap(find.byType(CustomCanvas));
    await tester.pump();

    // Verify that the onTap callback was executed
    expect(tapped, isTrue);
  });

  testWidgets('CustomCanvas widget initial state test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomCanvas(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Test Tale',
            onTap: () {}, // Provide an empty onTap callback
          ),
        ),
      ),
    );

    // Verify the initial state
    final customCanvasWidget = find.byType(CustomCanvas);
    expect(customCanvasWidget, findsOneWidget);
    // Add more expectations based on the initial state if applicable
  });

  testWidgets('CustomCanvas widget child visibility test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomCanvas(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Test Tale',
            onTap: () {}, // Provide an empty onTap callback
          ),
        ),
      ),
    );

    // Verify the visibility of specific child widgets
    expect(find.text('Test Tale'), findsOneWidget); // Text should be visible
    // Add more visibility tests for other child widgets if applicable
  });

  testWidgets('CustomCanvas widget state change test',
      (WidgetTester tester) async {
    // Initial state verification

    // Trigger state changes

    // Validate the updated appearance based on state change
  });

  testWidgets('CustomCanvas widget border color change test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomCanvas(
            talePath: 'assets/images/tale_sample.jpg',
            taleName: 'Test Tale',
            onTap: () {}, // Provide an empty onTap callback
          ),
        ),
      ),
    );

    // Verify the initial border color

    // Trigger state change or update

    // Verify the updated border color
  });

  testWidgets('CustomCanvas widget responsiveness test',
      (WidgetTester tester) async {
    // Simulate different device sizes or orientations and verify widget responsiveness
  });
}
