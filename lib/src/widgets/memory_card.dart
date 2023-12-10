import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:trip_tales/src/constants/color.dart';

import '../constants/memory_card_type.dart';
import '../utils/device_info.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

class MemoryCard extends StatelessWidget {

  final GlobalKey cardKey;
  final MemoryCardType type;
  final Size size;
  final String imagePath;
  final String videoPath;
  var position;
  var rotation;

  double maxScale = 2;
  double minScale = 0.75;
  var lockLocations = [0, 90];
  double maxRotation = math.pi / 2.0;

  MemoryCard({
    required this.cardKey,
    required this.type,
    required this.size,
    this.position = const (0, 0, 0),
    this.rotation,
    this.imagePath = 'assets/images/canvas1.jpg',
    this.videoPath = 'assets/images/canvas1.jpg',
  });

  @override


  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return MatrixGestureDetector(
      key: cardKey,
      onMatrixUpdate: (m, tm, sm, rm) {
        notifier.value = m;
        double scale = m.getMaxScaleOnAxis();
        position = m.getTranslation();
        rotation = rm.getRotation();

        if (scale > maxScale) {
          m.scale(maxScale / scale);
        }else if (scale < minScale) {
          m.scale(minScale / scale);
        }

        if (position[0] < 0) {
          m.setTranslationRaw(0, position[1], position[2]);
        } else if (position[0] > device.width - size.width) {
          m.setTranslationRaw(device.width - size.width, position[1], position[2]);
        } else if (position[1] < 0) {
          m.setTranslationRaw(position[0], 0, position[2]);
        }

        // if (position[0] < 0) {
        //   m.setTranslationRaw(0, position[1], position[2]);
        // } else if (position[0] > device.width - size.width) {
        //   m.setTranslationRaw(device.width - size.width, position[1], position[2]);
        // } else if (position[1] < 0) {
        //   m.setTranslationRaw(position[0], 0, position[2]);
        // }

        print(m.getMaxScaleOnAxis());
        print("---------");
        print(m.getTranslation());
        print("+++++++++");
        print(rotation);
        print("%%%%%%%%%");
      },
      child: AnimatedBuilder(
        animation: notifier,
        builder: (ctx, child) {
          return Container(
            height: device.height * 10,
            width: device.width,
            child: Transform(
              transform: notifier.value,
              child: Stack(
                children: <Widget>[
                  if (type == MemoryCardType.image)
                    ImageMemory()
                  else if (type == MemoryCardType.video)
                    VideoMemory()
                  else
                    TextMemory()
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget ImageMemory() {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.main1),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              imagePath,
            ),
          )),
    );
  }

  Widget VideoMemory() {
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.red,
    );
  }

  Widget TextMemory() {
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.green,
    );
  }

  Size getContainerSize() {
    RenderBox renderBox = cardKey.currentContext!.findRenderObject() as RenderBox;
    return renderBox.size;
  }

}
