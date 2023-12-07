import 'package:flutter/material.dart';
import 'package:trip_tales/src/constants/color.dart';

class ButtonSlider extends StatefulWidget {
  @override
  _ButtonSlider createState() => _ButtonSlider();
}

class _ButtonSlider extends State<ButtonSlider> {
  bool isMenuOpen = false;
  static const String buttonText = 'Add Memory';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 1),
              child: isMenuOpen
                  ? FloatingActionButton(
                      key: ValueKey<int>(0),
                      backgroundColor: AppColors.main2,
                      onPressed: () {
                        setState(() {
                          isMenuOpen = !isMenuOpen;
                        });
                      },
                      child:
                          const Icon(Icons.add, color: Colors.white, size: 25),
                    )
                  : FloatingActionButton.extended(
                      key: ValueKey<int>(1),
                      backgroundColor: AppColors.main2,
                      onPressed: () {
                        setState(() {
                          isMenuOpen = !isMenuOpen;
                        });
                      },
                      label: Text(isMenuOpen ? '': 'Add Memory'),
                      icon:
                          const Icon(Icons.add, color: Colors.white, size: 25),
                    ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: isMenuOpen ? 200 : 0,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: isMenuOpen
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Menu Item 1'),
                        Text('Menu Item 2'),
                        Text('Menu Item 3'),
                      ],
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
