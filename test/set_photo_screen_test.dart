/*
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/screen/set_photo_screen.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:trip_tales/src/widgets/button.dart';

//class MockImagePicker extends Mock implements ImagePicker {
@override
//  Future<XFile?> pickImage({
//   required ImageSource source,
//  double? maxWidth,
//  double? maxHeight,
//   int? imageQuality,
//   CameraDevice preferredCameraDevice = CameraDevice.rear,
//  }) async {
//   return XFile('/path/to/image.png');
// }
//}

void main() {
  MockImagePicker? mockImagePicker;

  setUp(() {
    mockImagePicker = MockImagePicker();
  });

  testWidgets('SetPhotoScreen widget test', (WidgetTester tester) async {
    // Build the SetPhotoScreen widget.
    await tester.pumpWidget(MaterialApp(
      home: SetPhotoScreen(),
    ));

    // Verify that the CustomButton widget is present.
    expect(find.byType(CustomButton), findsOneWidget);

    // Tap the 'Add Image' button and trigger a callback.
    await tester.tap(find.byType(CustomButton));
    await tester.pump();

    // Check if the function to pick an image is called when the button is tapped.
    verify(mockImagePicker!.pickImage(source: ImageSource.gallery)).called(1);
  });

  testWidgets('SetPhotoScreen throws PlatformException',
      (WidgetTester tester) async {
    when(mockImagePicker!.pickImage(source: ImageSource.gallery))
        .thenThrow(PlatformException(code: 'PERMISSION_DENIED'));

    // Build the SetPhotoScreen widget.
    await tester.pumpWidget(MaterialApp(
      home: SetPhotoScreen(),
    ));

    // Tap the 'Add Image' button and trigger a callback.
    await tester.tap(find.byType(CustomButton));
    await tester.pump();

    // Check if the PlatformException was thrown.
    expect(tester.takeException(), isInstanceOf<PlatformException>());
  });
}*/ 
