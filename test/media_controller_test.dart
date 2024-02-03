import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trip_tales/src/controllers/media_controller.dart';

void main() {
  group('MediaController Tests', () {
    late MediaController mediaController;

    setUp(() {
      mediaController = MediaController();
    });

    test('setImage - Success', () {
      final File testFile = File('test_image.jpg');

      mediaController.setImage(testFile);

      expect(mediaController.image.value, equals(testFile));
    });

    test('getImage - Success', () {
      final File testFile = File('test_image.jpg');
      mediaController.setImage(testFile);

      final result = mediaController.getImage();

      expect(result, equals(testFile));
    });

    test('getImage - Null when no image set', () {
      final result = mediaController.getImage();

      expect(result, isNull);
    });

    test('setVideo - Success', () {
      final XFile testVideoFile = XFile('test_video.mp4');

      mediaController.setVideo(testVideoFile);

      expect(mediaController.video.value, equals(testVideoFile));
    });

    test('getVideo - Success', () {
      final XFile testVideoFile = XFile('test_video.mp4');
      mediaController.setVideo(testVideoFile);

      final result = mediaController.getVideo();

      expect(result, equals(testVideoFile));
    });

    test('getVideo - Null when no video set', () {
      final result = mediaController.getVideo();

      expect(result, isNull);
    });
  });
}
