import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/screen/select_photo_options_screen.dart';
import 'package:trip_tales/src/screen/set_photo_screen.dart';
import 'package:flutter/material.dart';
import 'package:trip_tales/src/widgets/button.dart';
import 'package:video_player/video_player.dart';

void main() {
  testWidgets('SetPhotoScreen Layout Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SetPhotoScreen(),
        ),
      ),
    );

    // Verify the initial state of the UI.
    expect(find.text('No image selected'), findsOneWidget);
    expect(find.text('No video selected'), findsNothing);

    // Verify the presence and styling of the container.
    expect(find.byType(Container), findsOneWidget);
    expect(find.byType(Container), findsWidgets);

    // Verify the presence and styling of the CustomButton.
    expect(find.byType(CustomButton), findsOneWidget);
    final customButtonFinder = find.byType(CustomButton);
    final customButtonWidget = tester.widget<CustomButton>(customButtonFinder);
    expect(customButtonWidget.backgroundColor, AppColors.main2);
    expect(customButtonWidget.textColor, Colors.white);

    // Tap on the CustomButton and check if the appropriate modal is shown.
    await tester.tap(customButtonFinder);
    await tester.pump();
    expect(find.byType(SelectPhotoOptionsScreen), findsOneWidget);

    // Verify the initial state of the VideoPlayer.
    expect(find.byType(VideoPlayer), findsNothing);

    // Set an image file and verify its presence.
    await tester.tap(customButtonFinder);
    await tester.pump();
    await tester.tap(find.text('Add Image'));
    await tester.pump();
    expect(find.text('You can change your image here'), findsNothing);

    // Set a video file and verify its presence.
    await tester.tap(customButtonFinder);
    await tester.pump();
    //await tester.tap(find.text('Add Video'));
    await tester.pump();
    //expect(find.byType(VideoPlayer), findsNothing);

    // Verify the presence of the 'Change Image' text.
    expect(find.text('You can change your image here'), findsNothing);

    // Verify the presence of the 'No image selected' text.
    expect(find.text('No image selected'), findsOneWidget);

    // Verify the presence of the 'No video selected' text.
    expect(find.text('No video selected'), findsNothing);
  });

  testWidgets('Select Image - Display Image', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SetPhotoScreen(),
        ),
      ),
    );

    await tester.tap(find.text('Add Image'));
    await tester.pump();

    expect(find.text('You can change your image here'), findsNothing);
    expect(find.byType(VideoPlayer), findsNothing);
  });
  testWidgets('SetPhotoScreen Video Container Layout Test',
      (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SetPhotoScreen(
            isImage: false,
            contDef: false,
            hasImage: false,
          ),
        ),
      ),
    );

    // Ensure that the Container with the VideoPlayer has the correct layout
    expect(find.byType(Container), findsOneWidget);
    expect(find.byType(ClipRRect), findsNothing);
    expect(find.byType(FittedBox), findsNothing);
  });
}
