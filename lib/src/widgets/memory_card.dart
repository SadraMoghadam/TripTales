import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:video_player/video_player.dart';

import '../constants/memory_card_type.dart';
import '../utils/device_info.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

class MemoryCard extends StatefulWidget {
  final Function(Size) onSizeChanged;
  final GlobalKey cardKey;
  final MemoryCardType type;
  final int order;
  Size size;
  final String imagePath;
  final String videoPath;
  var position;
  var rotation;

  // var currentSize;

  var lockLocations = [0, 90];
  double maxRotation = math.pi / 2.0;

  MemoryCard({
    required this.cardKey,
    required this.order,
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
  late VideoPlayerController _videoController;
  late Future<void> _initializeVideoPlayerFuture;
  Size currentSize = Size(200, 200);
  double maxScale = 2;
  double minScale = 0.75;
  double maxSize = 300;
  double minSize = 50;

  @override
  void initState() {
    _videoController = VideoPlayerController.networkUrl(Uri.parse(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    ));
    _initializeVideoPlayerFuture = _videoController.initialize();
    super.initState();
    currentSize = widget.size;
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void updateContainerSize(Matrix4 scaleMatrix) {
    // Extract the scale values from the matrix
    final double scaleX = scaleMatrix.getRow(0).length2;
    final double scaleY = scaleMatrix.getRow(1).length2;

    // Calculate the new container size based on scaling
    double newContainerSize = widget.size.height;
    print(newContainerSize);

    // Apply size limits
    if (newContainerSize > maxSize) {
      print("fjsbeueyb");
      newContainerSize = maxSize;
    } else if (newContainerSize < minSize) {
      print("uyiuiyfjsbeueyb");
      newContainerSize = minSize;
    }
    widget.size = new Size(newContainerSize, newContainerSize);
  }

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
        // updateContainerSize(sm);
        // onSizeChanged(currentSize);
        widget.position = m.getTranslation();
        widget.rotation = rm.getRotation();

        // if (scale > maxScale) {
        //   m.scale(maxScale / scale);
        // }else if (scale < minScale) {
        //   m.scale(minScale / scale);
        // }

        if (widget.position[0] < 0) {
          m.setTranslationRaw(0, widget.position[1], widget.position[2]);
        } else if (widget.position[0] > device.width - 50) {
          m.setTranslationRaw(
              device.width - 50, widget.position[1], widget.position[2]);
        } else if (widget.position[1] < 0) {
          m.setTranslationRaw(widget.position[0], 0, widget.position[2]);
        }

        // setState(() {
        //   widget.size = Size(100, 100);
        //   widget.position = m.getTranslation();
        //   widget.rotation = rm.getRotation();
        // });

        // if (position[0] < 0) {
        //   m.setTranslationRaw(0, position[1], position[2]);
        // } else if (position[0] > device.width - size.width) {
        //   m.setTranslationRaw(device.width - size.width, position[1], position[2]);
        // } else if (position[1] < 0) {
        //   m.setTranslationRaw(position[0], 0, position[2]);
        // }

        // print(m.getMaxScaleOnAxis());
        // print("---------");
        // print(m.getTranslation());
        // print("+++++++++");
        // print(widget.rotation);
        // print("%%%%%%%%%");
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
                    imageMemory()
                  else if (widget.type == MemoryCardType.video)
                    videoMemory()
                  else if (widget.type == MemoryCardType.text)
                    textMemory()
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget imageMemory() {
    return Container(
      height: widget.size.height,
      width: widget.size.width,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.main1, width: 3),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              widget.imagePath,
            ),
          )),
    );
  }

  Widget videoMemory() {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_videoController.value.isPlaying) {
            _videoController.pause();
          } else {
            _videoController.play();
          }
        });

      },
      child: Stack(
        children: [
          Container(
            height: widget.size.height,
            width: widget.size.width,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.main2, width: 3),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: VideoPlayer(_videoController),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          Container(
            height: widget.size.height,
            width: widget.size.width,
            alignment: Alignment.center,

            child: Icon(
              size: widget.size.height / 4,
              color: AppColors.main2,
              _videoController.value.isPlaying ? null : Icons.play_circle_outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget textMemory() {
    return Container(
      height: widget.size.height,
      width: widget.size.width,
      color: Colors.green,
    );
  }

  Size getContainerSize() {
    RenderBox renderBox =
        widget.cardKey.currentContext!.findRenderObject() as RenderBox;
    return renderBox.size;
  }
}