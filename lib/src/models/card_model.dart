import 'package:flutter/material.dart';
import 'package:trip_tales/src/utils/text_utils.dart';

import '../constants/color.dart';
import '../constants/memory_card_type.dart';
import '../utils/matrix_utils.dart';

class CardModel {
  // final String id;
  late int order;
  final MemoryCardType type;
  Matrix4 transform;
  final Size size;
  final String name;
  late final String path;

  final String text;
  final Color textColor;
  final Color textBackgroundColor;
  final TextDecoration textDecoration;
  final FontStyle fontStyle;
  final FontWeight fontWeight;
  final double fontSize;
  final double? locationLatitude;
  final double? locationLongitude;

  CardModel({
    // required this.id,
    required this.order,
    required this.type,
    required this.transform,
    this.size = const Size(300, 300),
    this.path = "",
    this.name = "image",

    this.text = '',
    this.textColor = AppColors.text1,
    this.textBackgroundColor = AppColors.main2,
    this.textDecoration = TextDecoration.none,
    this.fontStyle = FontStyle.normal,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 16,
    this.locationLatitude,
    this.locationLongitude,
  });

  void setOrder(int order){
    this.order = order;
  }

  void setTransform(Matrix4 transform){
    this.transform = transform;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'order': order,
      'type': type.name,
      'transform': CustomMatrixUtils.matrix4ToJson(transform),
      'path': name,
      'size': size.height,
      // 'text': '',
      // 'textColor': '',
      // 'textBackgroundColor': '',
      // 'textDecoration': '',
      // 'fontStyle': '',
      // 'fontWeight': '',
      // 'fontSize': '',
      'locationLatitude': locationLatitude,
      'locationLongitude': locationLongitude,
    };
  }

  Map<String, dynamic> toJsonTextCard() {
    return {
      'name': name,
      'order': order,
      'type': type.name,
      'transform': CustomMatrixUtils.matrix4ToJson(transform),
      // 'path': '',
      // 'size': 300,
      'text': text,
      'textColor': TextUtils.colorToText(textColor),
      'textBackgroundColor': TextUtils.colorToText(textBackgroundColor),
      'textDecoration': TextUtils.decorationToText(textDecoration),
      'fontStyle': fontStyle.name,
      'fontWeight': TextUtils.fontWeightToText(fontWeight),
      'fontSize': fontSize,
      'locationLatitude': locationLatitude,
      'locationLongitude': locationLongitude,
    };
  }
}