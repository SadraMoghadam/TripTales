import 'package:flutter/material.dart';
import 'package:trip_tales/src/utils/text_utils.dart';

import '../constants/color.dart';
import '../constants/memory_card_type.dart';
import '../utils/matrix_utils.dart';

class CardModel {
  // final String id;
  late final int order;
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
    };
  }
}







//
// class ImageCardModel extends CardModel {
//   final String name;
//   final String path;
//   ImageCardModel({
//     required super.id,
//     required super.order,
//     required super.type,
//     required super.transform,
//     this.path = "",
//     this.name = "image",
//   });
//
//
// }
//
//
// class VideoCardModel extends CardModel {
//   final String name;
//   final String path;
//   VideoCardModel({
//     required super.id,
//     required super.order,
//     required super.type,
//     required super.transform,
//     this.path = "",
//     this.name = "image",
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       'order': order,
//       'type': type.name,
//       'transform': CustomMatrixUtils.matrix4ToJson(transform),
//       'path': name,
//       'name': name,
//     };
//   }
// }
