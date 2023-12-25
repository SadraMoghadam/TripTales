import 'package:flutter/material.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:lottie/lottie.dart';
import 'package:trip_tales/src/constants/memory_card_type.dart';
import 'package:trip_tales/src/pages/create_image_page.dart';
import 'package:trip_tales/src/pages/create_text_page.dart';

import '../pages/create_video_page.dart';

class ButtonSlider extends StatefulWidget {
  final Function callback;

  const ButtonSlider({super.key, required this.callback});

  @override
  _ButtonSlider createState() => _ButtonSlider();
}

class _ButtonSlider extends State<ButtonSlider> with TickerProviderStateMixin {
  bool isMenuOpen = false;
  static const String buttonText = 'Add Memory';
  late final AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  void onImageButtonClick() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CreateImagePage();
        }).then((value) => setState(() {
          widget.callback();
        }));
  }

  void onVideoButtonClick() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CreateVideoPage();
        }).then((value) => setState(() {
          widget.callback();
        }));
  }

  void onTextButtonClick() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CreateTextPage();
        }).then((value) => setState(() {
          widget.callback();
        }));
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 10));
    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          buildButton(MemoryCardType.text, Icons.text_snippet_rounded,
              const Offset(0.0, -3.6)),
          buildButton(MemoryCardType.video, Icons.video_library_rounded,
              const Offset(0.0, -2.45)),
          buildButton(
              MemoryCardType.image, Icons.image, const Offset(0.0, -1.3)),
          Positioned(
            bottom: 0,
            right: 0,
            child: AnimatedContainer(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              duration: const Duration(seconds: 0),
              child: GestureDetector(
                key: const ValueKey<int>(0),
                onTap: () {
                  setState(() {
                    isMenuOpen = !isMenuOpen;
                  });
                  if (isMenuOpen) {
                    _controller.animateTo(0.5,
                        duration: Duration(milliseconds: 500));
                  } else {
                    _controller.animateTo(0,
                        duration: Duration(milliseconds: 500));
                  }
                },
                child: Lottie.asset(
                  "assets/animations/add_button_circle.json",
                  width: 100,
                  height: 100,
                  controller: _controller,
                  onLoaded: (composition) {
                    _controller.duration = composition.duration;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(MemoryCardType type, IconData icon, Offset finalPosition) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 0.0),
          end: finalPosition,
        ).animate(_controller),
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(23),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            shape: BoxShape.circle,
            color: AppColors.main2,
          ),
          child: GestureDetector(
            onTap: () {
              if (type == MemoryCardType.image) {
                onImageButtonClick();
              } else if (type == MemoryCardType.video) {
                onVideoButtonClick();
              } else if (type == MemoryCardType.text) {
                onTextButtonClick();
              }
            },
            child: Icon(
              icon,
              size: 30,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
