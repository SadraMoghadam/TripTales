import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/models/card_model.dart';
import 'package:trip_tales/src/widgets/delete_item_dialog.dart';
import 'package:video_player/video_player.dart';

import '../constants/memory_card_type.dart';
import '../services/card_service.dart';
import '../utils/device_info.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

class MemoryCard extends StatefulWidget {
  // final Function(Size) onSizeChanged;
  final bool isEditable;
  final Function callback;

  final GlobalKey cardKey;
  final String name;
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
    required this.isEditable,
    required this.callback,
    required this.name,
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
  final CardService _cardService = Get.find<CardService>();
  late Future<void> _initializeVideoPlayerFuture;
  Size currentSize = Size(300, 300);
  double maxScale = 2.7;
  double minScale = 0.3;
  bool start = true;
  int counter = 0;
  int updateCounter = 0;
  int maxThreshold = 5;
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
      // print("------------------${widget.videoPath}");
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

  // void updateContainerSize(Matrix4 scaleMatrix) {
  //   // Extract the scale values from the matrix
  //   // final double scaleX = scaleMatrix.getRow(0).length2;
  //   // final double scaleY = scaleMatrix.getRow(1).length2;
  //
  //   // Calculate the new container size based on scaling
  //   double newContainerSize = widget.size.height;
  //
  //   // Apply size limits
  //   if (newContainerSize > maxSize) {
  //     // print("fjsbeueyb");
  //     newContainerSize = maxSize;
  //   } else if (newContainerSize < minSize) {
  //     // print("uyiuiyfjsbeueyb");
  //     newContainerSize = minSize;
  //   }
  //   widget.size = new Size(newContainerSize, newContainerSize);
  // }

  void deleteCard(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DeleteItemDialog(name: widget.name);
        }).then((value) => setState(() {
      widget.callback();
    }));
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

  void updateTransform(Matrix4 transform, int counter) {
    _cardService.updateCardTransform(widget.name, transform).then((value) {
      if(counter == updateCounter)
        print("SSSSSSSSSSSSSSSSSSSSSSs");
    });
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Matrix4> notifier = ValueNotifier<Matrix4>(Matrix4.identity());
    DeviceInfo device = DeviceInfo();
    device.computeDeviceInfo(context);
    return MatrixGestureDetector(
      key: widget.cardKey,
      shouldRotate: widget.isEditable,
      shouldScale: widget.isEditable,
      shouldTranslate: widget.isEditable,
      onMatrixUpdate: (m, tm, sm, rm) {
        notifier.value = m;
        // double scale = m.getMaxScaleOnAxis();
        // updateContainerSize(sm);
        // onSizeChanged(currentSize);
        // position = notifier.value.getTranslation();
        // if (position[0] < 0) {
        //   notifier.value.setTranslationRaw(0, position[1], position[2]);
        // }

        if(notifier.value.entry(0, 0) > maxScale){
          notifier.value.setEntry(0, 0, maxScale);
          notifier.value.setEntry(1, 1, maxScale);
        }
        else if(notifier.value.entry(0, 0) < minScale){
          notifier.value.setEntry(0, 0, minScale);
          notifier.value.setEntry(1, 1, minScale);
        }
        // if (notifier.value.entry(3, 0) < 0) {
        //     notifier.value.setEntry(3, 0, 0);
        //   }
        // if (notifier.value.entry(3, 0) > 200) {
        //   notifier.value.setEntry(3, 0, 0);
        // }
        counter++;
        setState(() {
          widget.initTransform = notifier.value * transform;
        });
        if(counter % maxThreshold == 0){
          // print("====================\n====================\n====================\n====================\n");
          updateTransform(notifier.value * transform, updateCounter);
          updateCounter++;
          counter = 1;
        }

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
              transform: notifier.value * widget.initTransform,
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
      // transform: transform,
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
              decoration: cardDecorationOnEdit(),
              child: Center(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(widget.imagePath, fit: BoxFit.cover),
                    ),
                    deleteButton(deleteCard),
                  ],
                ),
              )
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
      // transform: transform,
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
                          decoration: cardDecorationOnEdit(),
                          child: Center(
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: VideoPlayer(_videoController),
                                ),
                                deleteButton(deleteCard),
                              ],
                            ),
                          )
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
        // transform: transform,
        decoration: cardDecorationOnEdit(isText: true, backColor: widget.textBackgroundColor),
        child: Stack(
          children: [
            FittedBox(
              fit: BoxFit.fill,
              child:
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  fontWeight: widget.fontWeight,
                  color: widget.textColor,
                  // backgroundColor: widget.textBackgroundColor,
                  decoration: widget.textDecoration,
                  fontStyle: widget.fontStyle,
                ),
              ),),
            deleteButton(deleteCard)
          ],
        )
    );
  }

  Widget deleteButton(Function onTap) {
    return widget.isEditable ? Positioned(
      top: 5,
      right: 5,
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              // boxShadow: const [BoxShadow(color: AppColors.main3, blurRadius: 3, spreadRadius: 1)],
              color: AppColors.main3.withOpacity(0.7)),
          child: const Icon(Icons.close_outlined, size: 17, color: Colors.white60),
        ),
      ),
    ) : Container(width: 0, height: 0,);
  }

  BoxDecoration cardDecorationOnEdit({bool isText = false, backColor = Colors.transparent}){
    return BoxDecoration(
      color: isText ? backColor : Colors.transparent,
      borderRadius: BorderRadius.circular(13.0),
      border: Border.all(
        color: widget.isEditable ? AppColors.main3.withOpacity(0.8) : Colors.transparent, // Set your border color here
        width: 1.0,
      ),
    );
  }

  Size getContainerSize() {
    RenderBox renderBox =
        widget.cardKey.currentContext!.findRenderObject() as RenderBox;
    return renderBox.size;
  }
}
