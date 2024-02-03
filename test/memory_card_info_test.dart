import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:trip_tales/src/constants/memory_card_info.dart';
import 'package:trip_tales/src/constants/memory_card_type.dart';

void main() {
  test('MemoryCardInfo Initialization Test', () {
    // Create a MemoryCardInfo instance
    MemoryCardInfo memoryCardInfo = MemoryCardInfo(
      size: Size(100, 150),
      cardKey: GlobalKey(),
      type: MemoryCardType.image,
      position: Offset(10, 20),
      rotation: 30,
      imagePath: 'assets/images/test_image.jpg',
      videoPath: 'assets/videos/test_video.mp4',
    );

    // Test the properties of the MemoryCardInfo instance
    expect(memoryCardInfo.size, equals(Size(100, 150)));
    expect(memoryCardInfo.cardKey, isA<GlobalKey>());
    expect(memoryCardInfo.type, equals(MemoryCardType.image));
    expect(memoryCardInfo.position, equals(Offset(10, 20)));
    expect(memoryCardInfo.rotation, equals(30));
    expect(memoryCardInfo.imagePath, equals('assets/images/test_image.jpg'));
    expect(memoryCardInfo.videoPath, equals('assets/videos/test_video.mp4'));
  });

  test('MemoryCardInfo Default Values Test', () {
    // Create a MemoryCardInfo instance with default values
    MemoryCardInfo memoryCardInfo = MemoryCardInfo(
      size: Size(50, 75),
      position: Offset(0, 0),
      cardKey: GlobalKey(),
      type: MemoryCardType.video,
    );

    // Test the default values
    expect(memoryCardInfo.position, equals(const Offset(0, 0)));
    expect(memoryCardInfo.rotation, isNull);
    expect(memoryCardInfo.imagePath, equals('assets/images/canvas1.jpg'));
    expect(memoryCardInfo.videoPath, equals('assets/images/canvas1.jpg'));
  });

  test('MemoryCardInfo Initialization Test', () {
    // Create a MemoryCardInfo instance
    MemoryCardInfo memoryCardInfo = MemoryCardInfo(
      size: Size(100, 150),
      cardKey: GlobalKey(),
      type: MemoryCardType.image,
      position: Offset(10, 20),
      rotation: 30,
      imagePath: 'assets/images/test_image.jpg',
      videoPath: 'assets/videos/test_video.mp4',
    );

    // Test the properties of the MemoryCardInfo instance
    expect(memoryCardInfo.size, equals(Size(100, 150)));
    expect(memoryCardInfo.cardKey, isA<GlobalKey>());
    expect(memoryCardInfo.type, equals(MemoryCardType.image));
    expect(memoryCardInfo.position, equals(Offset(10, 20)));
    expect(memoryCardInfo.rotation, equals(30));
    expect(memoryCardInfo.imagePath, equals('assets/images/test_image.jpg'));
    expect(memoryCardInfo.videoPath, equals('assets/videos/test_video.mp4'));
  });

  test('MemoryCardInfo Initialization Test 2', () {
    // Create a MemoryCardInfo instance
    MemoryCardInfo memoryCardInfo = MemoryCardInfo(
      size: Size(200, 250),
      cardKey: GlobalKey(),
      type: MemoryCardType.image,
      position: Offset(10, 20),
      rotation: 30,
      imagePath: 'assets/images/test_image.jpg',
      videoPath: 'assets/videos/test_video.mp4',
    );

    // Test the properties of the MemoryCardInfo instance
    expect(memoryCardInfo.size, equals(Size(200, 250)));
    expect(memoryCardInfo.cardKey, isA<GlobalKey>());
    expect(memoryCardInfo.type, equals(MemoryCardType.image));
    expect(memoryCardInfo.position, equals(Offset(10, 20)));
    expect(memoryCardInfo.rotation, equals(30));
    expect(memoryCardInfo.imagePath, equals('assets/images/test_image.jpg'));
    expect(memoryCardInfo.videoPath, equals('assets/videos/test_video.mp4'));
  });

  test('MemoryCardInfo Default Values Test', () {
    // Create a MemoryCardInfo instance with default values
    MemoryCardInfo memoryCardInfo = MemoryCardInfo(
      size: Size(50, 75),
      cardKey: GlobalKey(),
      position: Offset(0, 0),
      type: MemoryCardType.video,
    );

    // Test the default values
    expect(memoryCardInfo.position, equals(const Offset(0, 0)));
    expect(memoryCardInfo.rotation, isNull);
    expect(memoryCardInfo.imagePath, equals('assets/images/canvas1.jpg'));
    expect(memoryCardInfo.videoPath, equals('assets/images/canvas1.jpg'));
  });

  test('MemoryCardInfo Update Properties Test', () {
    // Create a MemoryCardInfo instance
    MemoryCardInfo memoryCardInfo = MemoryCardInfo(
      size: Size(80, 120),
      cardKey: GlobalKey(),
      type: MemoryCardType.video,
      position: Offset(5, 10),
      rotation: 45,
      imagePath: 'assets/images/test_image.jpg',
      videoPath: 'assets/videos/test_video.mp4',
    );

    // Update properties
    memoryCardInfo.position = Offset(15, 25);
    memoryCardInfo.rotation = 60;
    // memoryCardInfo.imagePath = 'assets/images/updated_image.jpg';
    //  memoryCardInfo.videoPath = 'assets/videos/updated_video.mp4';

    // Test the updated properties
    expect(memoryCardInfo.position, equals(Offset(15, 25)));
    expect(memoryCardInfo.rotation, equals(60));
    //expect(memoryCardInfo.imagePath, equals('assets/images/updated_image.jpg'));
    //expect(memoryCardInfo.videoPath, equals('assets/videos/updated_video.mp4'));
  });
}
