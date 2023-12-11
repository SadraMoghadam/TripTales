import 'dart:async';

import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:video_player/video_player.dart';

import '../constants/memory_card_type.dart';
import '../utils/device_info.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

class MemoryCard extends StatefulWidget {
  // final Function(Size) onSizeChanged;
  final GlobalKey cardKey;
  final MemoryCardType type;
  final int order;
  Size size;
  final String imagePath;
  final String videoPath;
  Matrix4 initTransform;

  // var currentSize;

  var lockLocations = [0, 90];
  double maxRotation = math.pi / 2.0;

  MemoryCard({
    required this.cardKey,
    required this.order,
    required this.type,
    required this.size,
    // required this.onSizeChanged,
    required this.initTransform,
    this.imagePath = 'assets/images/canvas1.jpg',
    this.videoPath = 'assets/videos/1.mp4',
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
  double maxSize = 1000;
  double minSize = 50;
  late Matrix4 transform;
  var position;
  var rotation;
  late Size imageActualSize;
  late Size videoActualSize;

  // late ImageInfo _imageInfo;
  final Completer<ImageInfo> _imageInfoCompleter = Completer<ImageInfo>();

  @override
  void initState() {
    if (widget.type == MemoryCardType.video) {
      _videoController = VideoPlayerController.networkUrl(Uri.parse(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
      ));
      // _videoController = VideoPlayerController.asset(widget.videoPath);
      // _videoController = VideoPlayerController.network('assets/videos/1.mp4');
      _initializeVideoPlayerFuture = _videoController.initialize();
    }
    if (widget.type == MemoryCardType.image) {
      loadImageInfo(widget.imagePath);
    }
    super.initState();
    currentSize = widget.size;
    transform = widget.initTransform;
  }

  @override
  void dispose() {
    if (widget.type == MemoryCardType.video) {
      _videoController.dispose();
    }
    super.dispose();
  }

  void updateContainerSize(Matrix4 scaleMatrix) {
    // Extract the scale values from the matrix
    final double scaleX = scaleMatrix.getRow(0).length2;
    final double scaleY = scaleMatrix.getRow(1).length2;

    // Calculate the new container size based on scaling
    double newContainerSize = widget.size.height;

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

  Future<void> loadImageInfo(String imageUrl) async {
    final ImageStream imageStream =
        Image.network(imageUrl).image.resolve(ImageConfiguration.empty);
    final ImageStreamListener listener =
        ImageStreamListener((ImageInfo info, bool _) {
      _imageInfoCompleter.complete(info);
    });

    imageStream.addListener(listener);
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
        transform = m;
        double scale = m.getMaxScaleOnAxis();
        updateContainerSize(sm);
        // onSizeChanged(currentSize);
        position = m.getTranslation();
        rotation = rm.getRotation();

        // if (scale > maxScale) {
        //   m.scale(maxScale / scale);
        // }else if (scale < minScale) {
        //   m.scale(minScale / scale);
        // }

        if (position[0] < 0) {
          m.setTranslationRaw(0, position[1], position[2]);
        } else if (position[0] > device.width) {
          m.setTranslationRaw(device.width, position[1], position[2]);
        } else if (position[1] < 0) {
          m.setTranslationRaw(position[0], 0, position[2]);
        }

        setState(() {
          position = m.getTranslation();
          rotation = rm.getRotation();
          widget.initTransform = m;
        });

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
      transform: transform,
      decoration: const BoxDecoration(
        // color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: FutureBuilder<ImageInfo>(
        future: _imageInfoCompleter.future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final imageInfo = snapshot.data!;
            if (imageInfo.image.width > imageInfo.image.height)
              imageActualSize = Size(
                  widget.size.width,
                  widget.size.width *
                      imageInfo.image.height /
                      imageInfo.image.width);
            else if (imageInfo.image.width < imageInfo.image.height)
              imageActualSize = Size(
                  widget.size.height *
                      imageInfo.image.width /
                      imageInfo.image.height,
                  widget.size.height);
            else
              imageActualSize = Size(widget.size.width, widget.size.height);
            return Container(
              width: imageActualSize.width,
              height: imageActualSize.height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(widget.imagePath, fit: BoxFit.cover),
              ),
            );
          } else {
            return Center(
              child: Container(
                height: widget.size.height / 3,
                width: widget.size.height / 3,
                child: CircularProgressIndicator(
                  color: AppColors.main3,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget videoMemory() {
    return Container(
      transform: transform,
      child: GestureDetector(
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
              // decoration: const BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
              // ),
              child: FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (_videoController.value.size.width >
                        _videoController.value.size.height)
                      videoActualSize = Size(
                          widget.size.width,
                          widget.size.width *
                              _videoController.value.size.height /
                              _videoController.value.size.width);
                    else if (_videoController.value.size.width <
                        _videoController.value.size.height)
                      videoActualSize = Size(
                          widget.size.height *
                              _videoController.value.size.width /
                              _videoController.value.size.height,
                          widget.size.height);
                    else
                      videoActualSize =
                          Size(widget.size.width, widget.size.height);
                    return Stack(
                      children: [
                        Container(
                          height: videoActualSize.height,
                          width: videoActualSize.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: VideoPlayer(_videoController),
                          ),
                        ),
                        Container(
                          height: videoActualSize.height,
                          width: videoActualSize.width,
                          alignment: Alignment.center,
                          child: Icon(
                            size: widget.size.height / 4,
                            color: AppColors.main2,
                            _videoController.value.isPlaying
                                ? null
                                : Icons.play_circle_outline,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Container(
                        height: widget.size.height / 3,
                        width: widget.size.height / 3,
                        child: CircularProgressIndicator(
                          color: AppColors.main3,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textMemory() {
    return Container(
      transform: transform,
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
