/*
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:trip_tales/src/screen/select_photo_options_screen.dart';
import 'package:trip_tales/src/screen/set_photo_screen.dart';

@GenerateMocks([ImagePicker])
void main() {
  testWidgets('SetPhotoScreen shows no image selected initially',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SetPhotoScreen(isImage: true),
    ));

    expect(find.text('No image selected'), findsOneWidget);
  });

  testWidgets(
      'SelectPhotoOptionsScreen shows browse gallery and use camera options',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SelectPhotoOptionsScreen(
        onTap: (_) {},
      ),
    ));

    expect(find.byIcon(Icons.image), findsOneWidget);
    expect(find.text('Browse Gallery'), findsOneWidget);
    expect(find.byIcon(Icons.camera_alt_outlined), findsOneWidget);
    expect(find.text('Use Camera'), findsOneWidget);
  });

  testWidgets('SelectPhotoOptionsScreen onTap callback works',
      (WidgetTester tester) async {
    ImageSource? selectedSource;

    await tester.pumpWidget(MaterialApp(
      home: SelectPhotoOptionsScreen(
        onTap: (source) {
          selectedSource = source;
        },
      ),
    ));

    await tester.tap(find.text('Browse Gallery'));
    expect(selectedSource, ImageSource.gallery);

    await tester.tap(find.text('Use Camera'));
    expect(selectedSource, ImageSource.camera);
  });

  testWidgets('SetPhotoScreen displays no video selected',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SetPhotoScreen(isImage: false),
    ));

    expect(find.text('No video selected'), findsOneWidget);
  });

  testWidgets('SetPhotoScreen shows add image button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SetPhotoScreen(isImage: true),
    ));

    expect(find.text('Add Image'), findsOneWidget);
  });

  testWidgets(
      'SetPhotoScreen invokes select photo options when tapping add image button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SetPhotoScreen(isImage: true),
    ));

    await tester.tap(find.text('Add Image'));
    await tester.pump();

    expect(find.byType(SelectPhotoOptionsScreen), findsOneWidget);
  });

  testWidgets(
      'SelectPhotoOptionsScreen shows browse gallery and use camera options',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SelectPhotoOptionsScreen(
        onTap: (_) {},
      ),
    ));

    expect(find.byIcon(Icons.image), findsOneWidget);
    expect(find.text('Browse Gallery'), findsOneWidget);
    expect(find.byIcon(Icons.camera_alt_outlined), findsOneWidget);
    expect(find.text('Use Camera'), findsOneWidget);
  });

  testWidgets('SelectPhotoOptionsScreen onTap callback works',
      (WidgetTester tester) async {
    ImageSource? selectedSource;

    await tester.pumpWidget(MaterialApp(
      home: SelectPhotoOptionsScreen(
        onTap: (source) {
          selectedSource = source;
        },
      ),
    ));

    await tester.tap(find.text('Browse Gallery'));
    expect(selectedSource, ImageSource.gallery);

    await tester.tap(find.text('Use Camera'));
    expect(selectedSource, ImageSource.camera);
  });

  testWidgets('SetPhotoScreen displays no image selected',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SetPhotoScreen(isImage: true),
    ));

    expect(find.text('No image selected'), findsOneWidget);
  });

  testWidgets('SetPhotoScreen shows add video button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SetPhotoScreen(isImage: false),
    ));

    expect(find.text('Add Video'), findsOneWidget);
  });

  // Test video selection and functionality.
  testWidgets(
      'SetPhotoScreen invokes select video options when tapping add video button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SetPhotoScreen(isImage: false),
    ));

    await tester.tap(find.text('Add Video'));
    await tester.pump();

    expect(find.byType(SelectPhotoOptionsScreen), findsOneWidget);
  });

  testWidgets(
      'SelectPhotoOptionsScreen shows browse gallery and use camera options',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SelectPhotoOptionsScreen(
        onTap: (_) {},
      ),
    ));

    expect(find.byIcon(Icons.image), findsOneWidget);
    expect(find.text('Browse Gallery'), findsOneWidget);
    expect(find.byIcon(Icons.camera_alt_outlined), findsOneWidget);
    expect(find.text('Use Camera'), findsOneWidget);
  });

  testWidgets('SelectPhotoOptionsScreen onTap callback works',
      (WidgetTester tester) async {
    ImageSource? selectedSource;

    await tester.pumpWidget(MaterialApp(
      home: SelectPhotoOptionsScreen(
        onTap: (source) {
          selectedSource = source;
        },
      ),
    ));

    await tester.tap(find.text('Browse Gallery'));
    expect(selectedSource, ImageSource.gallery);

    await tester.tap(find.text('Use Camera'));
    expect(selectedSource, ImageSource.camera);
  });

  testWidgets('SetPhotoScreen displays no video selected',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SetPhotoScreen(isImage: false),
    ));

    expect(find.text('No video selected'), findsOneWidget);
  });

  testWidgets('SetPhotoScreen adds image correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SetPhotoScreen(isImage: true),
    ));

    expect(find.text('No image selected'), findsOneWidget);

    await tester.tap(find.text('Add Image'));
    await tester.pump();

    // Simulate picking an image (e.g., from gallery)
    // Ensure image is added correctly
    // Validate the updated UI based on the selected image
  });

  testWidgets(
      'SelectPhotoOptionsScreen onTap navigates to SetPhotoScreen with camera option',
      (WidgetTester tester) async {
    // Create a GlobalKey to access the NavigatorState
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    // Build the widget tree with MaterialApp containing a Navigator
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        home: SelectPhotoOptionsScreen(
          onTap: (source) {
            if (source == ImageSource.camera) {
              // Navigate to SetPhotoScreen upon tapping the "Use Camera" option
              navigatorKey.currentState!.push(MaterialPageRoute(
                builder: (context) => const SetPhotoScreen(isImage: true),
              ));
            }
          },
        ),
      ),
    );

    // Tap the "Use Camera" option
    await tester.tap(find.text('Use Camera'));
    await tester.pumpAndSettle();

    // Verify that SetPhotoScreen is navigated to
    expect(find.byType(SetPhotoScreen), findsOneWidget);
    // Add more assertions or validations for the SetPhotoScreen if needed
  });

  testWidgets('SetPhotoScreen displays no image selected initially',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SetPhotoScreen(isImage: true),
    ));

    expect(find.text('No image selected'), findsOneWidget);
  });

  testWidgets('SetPhotoScreen adds image from camera',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SetPhotoScreen(isImage: true),
    ));

    await tester.tap(find.text('Add Image'));
    await tester.pump();

    // Simulate picking an image from camera
    // Ensure image is added correctly
    // Validate the updated UI based on the selected image
  });

  testWidgets(
      'SelectPhotoOptionsScreen displays browse gallery and use camera options',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SelectPhotoOptionsScreen(
        onTap: (_) {},
      ),
    ));

    expect(find.text('Browse Gallery'), findsOneWidget);
    expect(find.text('Use Camera'), findsOneWidget);
  });

  testWidgets('SetPhotoScreen adds video from camera',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SetPhotoScreen(isImage: false),
    ));

    await tester.tap(find.text('Add Video'));
    await tester.pump();

    // Simulate picking a video from camera
    // Ensure video is added correctly
    // Validate the updated UI based on the selected video
  });

  testWidgets(
      'SelectPhotoOptionsScreen displays browse gallery and use camera options',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SelectPhotoOptionsScreen(
        onTap: (_) {},
      ),
    ));

    expect(find.text('Browse Gallery'), findsOneWidget);
    expect(find.text('Use Camera'), findsOneWidget);
  });
  testWidgets('SetPhotoScreen initializes with image',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SetPhotoScreen(),
    ));

    expect(find.text('No image selected'), findsOneWidget);
    // Validate default text when no image is selected
  });

  testWidgets('SetPhotoScreen adds image from gallery',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SetPhotoScreen(),
    ));

    await tester.tap(find.text('Add Image'));
    await tester.pump();

    // Simulate picking an image from the gallery
    // Ensure image is added correctly
    // Validate the updated UI based on the selected image
  });

  testWidgets('SelectPhotoOptionsScreen displays gallery and camera options',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SelectPhotoOptionsScreen(
        onTap: (_) {},
      ),
    ));

    expect(find.text('Browse Gallery'), findsOneWidget);
    expect(find.text('Use Camera'), findsOneWidget);
  });

  testWidgets('SetPhotoScreen displays "Add Image" button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SetPhotoScreen(),
    ));

    expect(find.text('Add Image'), findsOneWidget);
    // Validate that the "Add Image" button is displayed
  });

  testWidgets('SetPhotoScreen adds video correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SetPhotoScreen(isImage: false),
    ));

    // Trigger the video selection process
    // Validate that the video is added and displayed
    // Confirm that the video can be played
  });
}
*/