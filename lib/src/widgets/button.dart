import 'package:flutter/material.dart';

import '../constants/color.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final double fontSize;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final VoidCallback onPressed;
  final double borderRadius;
  final double padding;
  final IconData? icon;
  final bool isLoading;
  final bool isDisabled;

  CustomButton({
    required this.text,
    required this.onPressed,
    this.height = 20,
    this.width = 200,
    this.fontSize = 18.0,
    this.backgroundColor = AppColors.main2,
    this.textColor = AppColors.text1,
    this.borderRadius = 8.0,
    this.padding = 12.0,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    if (height == 0 || width == 0) {
      return ElevatedButton(
        onPressed: isDisabled || isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          onPrimary: textColor,
          shadowColor: Colors.grey,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: buildButtonChild(),
      );
    } else {
      return ElevatedButton(
        onPressed: isDisabled || isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          onPrimary: textColor,
          shadowColor: Colors.grey,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          minimumSize: Size(width, height),
        ),
        child: buildButtonChild(),
      );
    }
  }

  Widget buildButtonChild() {
    if (isLoading) {
      return SizedBox(
        width: 20.0,
        height: 20.0,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
          strokeWidth: 2.0,
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Icon(
                icon,
                size: 24.0,
              ),
            if (icon != null) SizedBox(width: 8.0),
            Text(
              text,
              style: TextStyle(
                fontSize: this.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }
  }
}
