import 'package:flutter/material.dart';
import '../constants/color.dart';

class CustomCanvas extends StatefulWidget {
  final String talePath;
  final String taleName;
  final VoidCallback onTap;
  final bool
      isSelected; // New parameter to determine if this widget is selected

  const CustomCanvas({
    Key? key,
    required this.talePath,
    required this.taleName,
    required this.onTap,
    this.isSelected = false, // Default value is false
  }) : super(key: key);

  @override
  _CustomCanvasState createState() => _CustomCanvasState();
}

class _CustomCanvasState extends State<CustomCanvas> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: 180,
        height: 270,
        child: AnimatedContainer(
          duration:
              const Duration(milliseconds: 15), // Adjust duration as needed
          curve: Curves.bounceInOut,
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            // borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                widget.talePath,
              ),
            ),
            border: Border.all(
              color: widget.isSelected
                  ? AppColors.main2
                  : AppColors.main1, // Change border color when selected
              width: widget.isSelected
                  ? 3.0
                  : 2.0, // Change border width when selected
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          /*child: Column(
          children: [
            Image.asset(
              widget.talePath,
              height: 230,
              width: 165,
              fit: BoxFit.cover,
            ),
            Text(
              widget.taleName,
              style: const TextStyle(color: ctext2, fontSize: 17),
            ),
          ],
        ),
        */
          child: Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 5),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                widget.taleName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1), // Specify shadow offset
                      blurRadius: 15.0, // Specify shadow blur radius
                      color: AppColors.text1, // Specify shadow color
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



/*
import 'package:flutter/material.dart';
import '../constants/color.dart';

class CustomCanvas extends StatefulWidget {
  final String talePath;
  final String taleName;
  // final bool isSelected;

  CustomCanvas({
    Key? key,
    required this.talePath,
    required this.taleName,
    // this.isSelected = false,
  }) : super(key: key);

  @override
  _CustomCanvasState createState() => _CustomCanvasState();
}

class _CustomCanvasState extends State<CustomCanvas> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(context, '/myTalesPage'),
      child: SizedBox(
        width: 180,
        height: 270,
        child: Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.only(bottom: 5, top: 5, left: 5, right: 5),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.main1),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  widget.talePath,
                ),
              )),
          child: Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 5),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                widget.taleName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 0), // Specify shadow offset
                      blurRadius: 10.0, // Specify shadow blur radius
                      color: AppColors.text1, // Specify shadow color
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      //  ),
    );
  }
}
*/