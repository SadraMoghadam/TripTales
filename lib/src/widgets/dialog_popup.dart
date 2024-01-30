import 'package:flutter/material.dart';
import '../constants/color.dart';

class DialogPopup {
  final String text;
  final int duration;
  DialogPopup({required this.text, this.duration = 2});

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            text,
            style: const TextStyle(
                color: AppColors.main2,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        );
      },
    );
    Future.delayed(Duration(seconds: duration), () {
      Navigator.of(context).pop();
    });
  }
}
