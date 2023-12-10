import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:trip_tales/src/constants/color.dart';

import '../constants/memory_card_type.dart';
import '../utils/device_info.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

class MemoryCard extends StatefulWidget {

  final Function(Size) onSizeChanged;
  final GlobalKey cardKey;
  final MemoryCardType type;
  late final Size size;
  final String imagePath;
  final String videoPath;
  var position;
  var rotation;
  // var currentSize;

  double maxScale = 2;
  double minScale = 0.75;
  var lockLocations = [0, 90];
  double maxRotation = math.pi / 2.0;

  MemoryCard({
    required this.cardKey,
    required this.type,
    required this.size,
    required this.onSizeChanged,
    this.position = const (0, 0, 0),
    this.rotation,
    this.imagePath = 'assets/images/canvas1.jpg',
    this.videoPath = 'assets/images/canvas1.jpg',
  });
  @override
  State<MemoryCard> createState() => _MemoryCardState();
}

class _MemoryCardState extends State<MemoryCard> {
  @override

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return MatrixGestureDetector(
      key: widget.cardKey,
      onMatrixUpdate: (m, tm, sm, rm) {
        notifier.value = m;
        double scale = m.getMaxScaleOnAxis();
        widget.size = getContainerSize();
        // onSizeChanged(currentSize);
        widget.position = m.getTranslation();
        widget.rotation = rm.getRotation();
        if (widget.size.height > 500) {
          print("sehufbvhsbvfesjh");
          widget.size = Size(500, 500);
        }else if (widget.size.height < 50) {

          print("yotjkitjhty");
          widget.size = Size(50, 50);
        }
        // if (scale > maxScale) {
        //   m.scale(maxScale / scale);
        // }else if (scale < minScale) {
        //   m.scale(minScale / scale);
        // }

        if (widget.position[0] < 0) {
          m.setTranslationRaw(0, widget.position[1], widget.position[2]);
        } else if (widget.position[0] > device.width - 50) {
          m.setTranslationRaw(device.width - 50, widget.position[1], widget.position[2]);
        } else if (widget.position[1] < 0) {
          m.setTranslationRaw(widget.position[0], 0, widget.position[2]);
        }

        setState(() {
          widget.size = getContainerSize();
          widget.position = m.getTranslation();
          widget.rotation = rm.getRotation();
        });

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
        print(widget.rotation);
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
                  if (widget.type == MemoryCardType.image)
                    ImageMemory()
                  else if (widget.type == MemoryCardType.video)
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
      height: widget.size.height,
      width: widget.size.width,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.main1),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              widget.imagePath,
            ),
          )),
    );
  }

  Widget VideoMemory() {
    return Container(
      height: widget.size.height,
      width: widget.size.width,
      color: Colors.red,
    );
  }

  Widget TextMemory() {
    return Container(
      height: widget.size.height,
      width: widget.size.width,
      color: Colors.green,
    );
  }

  Size getContainerSize() {
    RenderBox renderBox = widget.cardKey.currentContext!.findRenderObject() as RenderBox;
    return renderBox.size;
  }
}

