import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_tales/src/models/tale_model.dart';
import 'package:trip_tales/src/services/tale_service.dart';
import '../constants/color.dart';
import '../utils/app_manager.dart';

class CustomTale extends StatefulWidget {
  final String talePath;
  final String taleName;
  final int index;
  bool isLiked; // Include isFavorited in CustomTale

  CustomTale({
    Key? key,
    required this.talePath,
    required this.taleName,
    required this.index,
    this.isLiked = false, // Set default to false
  }) : super(key: key);

  @override
  _CustomTaleState createState() => _CustomTaleState();
}

class _CustomTaleState extends State<CustomTale> {
  final Completer<ImageInfo> _imageInfoCompleter = Completer<ImageInfo>();
  final AppManager _appManager = Get.put(AppManager());
  final TaleService _taleService = Get.find<TaleService>();
  Size size = Size(320, 220);

  // late Size imageActualSize;

  @override
  void initState() {
    super.initState();
    loadImageInfo(widget.talePath);
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

  void likeTale() {
    setState(() {
      widget.isLiked = !widget.isLiked;
    });
    _taleService.updateTaleLikeByName(widget.taleName, widget.isLiked);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      /*widget.talePos
          ? AlignmentDirectional.topStart
          : AlignmentDirectional.topEnd,
          */
      child: GestureDetector(
        onTap: () async {
          String taleId = await _taleService.getTaleId(widget.taleName);
          _appManager.setCurrentTale(taleId);
          Navigator.of(context).pushNamed('/talePage');

        },
        child: taleCard(),
      ),
    );
  }

  Widget taleCard() {
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
            // if (imageInfo.image.width > imageInfo.image.height) {
            //   imageActualSize = Size(
            //       size.width,
            //       size.width *
            //           imageInfo.image.height /
            //           imageInfo.image.width);
            // } else if (imageInfo.image.width < imageInfo.image.height) {
            //   imageActualSize = Size(
            //       size.height *
            //           imageInfo.image.width /
            //           imageInfo.image.height,
            //       size.height);
            // } else {
            //   imageActualSize = Size(size.width, size.height);
            // }
            return Container(
                // key: _widgetKeyList[0],
                width: size.width,
                height: size.height,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                          offset: Offset(-8, 8))
                    ],
                    border: Border.all(color: AppColors.main2),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Center(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          widget.talePath, fit: BoxFit.cover,
                          width: double.infinity,
                          // Make the image take the full width
                          height: double.infinity,
                        ),
                      ),
                      likeButton(likeTale),
                      taleName(),
                    ],
                  ),
                ));
          } else {
            return Center(
              child: Container(
                margin: EdgeInsets.all(100),
                height: size.height / 3,
                width: size.height / 3,
                child: const CircularProgressIndicator(
                  color: AppColors.main2,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget likeButton(Function onTap) {
    return Positioned(
      top: 2,
      right: 2,
      child: IconButton(
        icon: Icon(
          widget.isLiked
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded,
          color: widget.isLiked ? AppColors.main3 : AppColors.main2,
        ),
        onPressed: () {
          onTap();
        },
      ),
    );
  }

  Widget taleName() {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(left: 8, top: 9),
      child: Text(
        widget.taleName,
        style: const TextStyle(
          color: AppColors.main2,
          fontWeight: FontWeight.w600,
          fontSize: 22,
          shadows: <Shadow>[
            Shadow(
              offset: Offset(-2.0, 2.0),
              blurRadius: 3.0,
              color: AppColors.main1,
            ),
          ],
        ),

      ),
    );
  }
}
