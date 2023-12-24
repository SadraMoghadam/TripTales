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
  late Size size;
  final String imagePath;
  final String videoPath;
  Matrix4 initTransform;

  final String text;
  final Color textColor;
  final Color textBackgroundColor;
  final TextDecoration textDecoration;
  final FontStyle fontStyle;
  final FontWeight fontWeight;
  final double fontSize;

  // var currentSize;

  var lockLocations = [0, 90];
  double maxRotation = math.pi / 2.0;

  MemoryCard({super.key,
    required this.cardKey,
    required this.order,
    required this.type,
    // required this.onSizeChanged,
    required this.initTransform,
    this.size = const Size(300, 300),
    this.imagePath = 'assets/images/canvas1.jpg',
    this.videoPath = 'assets/videos/1.mp4',
    this.text = '',
    this.textColor = AppColors.text1,
    this.textBackgroundColor = AppColors.main2,
    this.textDecoration = TextDecoration.none,
    this.fontStyle = FontStyle.normal,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 16,
  });

  @override
  State<MemoryCard> createState() => _MemoryCardState();
}

class _MemoryCardState extends State<MemoryCard> {
  late VideoPlayerController _videoController;
  late Future<void> _initializeVideoPlayerFuture;
  Size currentSize = Size(300, 300);
  double maxScale = 2;
  double minScale = 0.75;
  double maxSize = 1000;
  double minSize = 50;
  late Matrix4 transform;
  var position;
  var rotation;
  late Size imageActualSize;
  late Size videoActualSize;
  // late List<GlobalKey> _widgetKeyList;

  // late ImageInfo _imageInfo;
  final Completer<ImageInfo> _imageInfoCompleter = Completer<ImageInfo>();

  @override
  void initState() {
    // _widgetKeyList = List.generate(3,
    //         (index) => GlobalObjectKey<FormState>(index*1000 + widget.cardKey.hashCode.hashCode));
    if (widget.type == MemoryCardType.video) {
      print("------------------${widget.videoPath}");
      _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.videoPath));
      // _videoController = VideoPlayerController.asset(widget.videoPath);
      // _videoController = VideoPlayerController.network('assets/videos/1.mp4');
      _initializeVideoPlayerFuture = _videoController.initialize();
    }
    if (widget.type == MemoryCardType.image) {
      loadImageInfo(widget.imagePath);
    }
    // else if (widget.type == MemoryCardType.video) {
    //   loadImageInfo(widget.videoPath);
    // }
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
      // print("fjsbeueyb");
      newContainerSize = maxSize;
    } else if (newContainerSize < minSize) {
      // print("uyiuiyfjsbeueyb");
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
  void _getWidgetInfo(GlobalKey key) {
    final RenderBox renderBox =
    key.currentContext?.findRenderObject() as RenderBox;
    key.currentContext?.size;

    final Size size = renderBox.size;
    print('Size: ${size.width}, ${size.height}');

    // final Offset offset = renderBox.localToGlobal(Offset.zero);
    // print('Offset: ${offset.dx}, ${offset.dy}');
    // print(
    //     'Position: ${(offset.dx + size.width) / 2}, ${(offset.dy + size.height) / 2}');
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
        // updateContainerSize(sm);
        // onSizeChanged(currentSize);
        position = m.getTranslation();
        rotation = rm.getRotation();

        // if (scale > maxScale) {
        //   m.scale(maxScale / scale);
        // }else if (scale < minScale) {
        //   m.scale(minScale / scale);
        // }
        // _getWidgetInfo(_widgetKeyList[0]);

        // if (position[0] < 0) {
        //   m.setTranslationRaw(0, position[1], position[2]);
        // } else if (position[0] > device.width - 50) {
        //   m.setTranslationRaw(device.width - 50, position[1], position[2]);
        // } else if (position[1] < 0) {
        //   m.setTranslationRaw(position[0], 0, position[2]);
        // }
        if (position[1] < 0) {
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
            if (imageInfo.image.width > imageInfo.image.height) {
              imageActualSize = Size(
                  widget.size.width,
                  widget.size.width *
                      imageInfo.image.height /
                      imageInfo.image.width);
            } else if (imageInfo.image.width < imageInfo.image.height) {
              imageActualSize = Size(
                  widget.size.height *
                      imageInfo.image.width /
                      imageInfo.image.height,
                  widget.size.height);
            }
            else {
              imageActualSize = Size(widget.size.width, widget.size.height);
            }
            return Container(
              // key: _widgetKeyList[0],
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
                child: const CircularProgressIndicator(
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
                        _videoController.value.size.height) {
                      videoActualSize = Size(
                          widget.size.width,
                          widget.size.width *
                              _videoController.value.size.height /
                              _videoController.value.size.width);
                    } else if (_videoController.value.size.width <
                        _videoController.value.size.height) {
                      videoActualSize = Size(
                          widget.size.height *
                              _videoController.value.size.width /
                              _videoController.value.size.height,
                          widget.size.height);
                    }
                    else {
                      videoActualSize =
                          Size(widget.size.width, widget.size.height);
                    }
                    return Stack(
                      children: [
                        Container(
                          // key: _widgetKeyList[1],
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
                        child: const CircularProgressIndicator(
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
        // key: _widgetKeyList[2],
      transform: transform,
        child: FittedBox(
          fit: BoxFit.fill,
          child:
          Text(
            widget.text,
            style: TextStyle(
                fontSize: widget.fontSize,
                fontWeight: widget.fontWeight,
                color: widget.textColor,
                backgroundColor: widget.textBackgroundColor,
                decoration: widget.textDecoration,
                fontStyle: widget.fontStyle,
            ),
          ),)
    );
  }

  Size getContainerSize() {
    RenderBox renderBox =
        widget.cardKey.currentContext!.findRenderObject() as RenderBox;
    return renderBox.size;
  }
}
