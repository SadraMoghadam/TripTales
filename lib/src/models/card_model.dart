import 'package:flutter/material.dart';

import '../constants/memory_card_type.dart';
import '../utils/matrix_utils.dart';

class CardModel {
  final String id;
  final int order;
  final MemoryCardType type;
  final Matrix4 transform;
  final Size size;

  CardModel({
    required this.id,
    required this.order,
    required this.type,
    required this.transform,
    this.size = const Size(300, 300),
  });
}

class ImageCardModel extends CardModel {
  final String name;
  final String path;
  ImageCardModel({
    required super.id,
    required super.order,
    required super.type,
    required super.transform,
    this.path = "",
    this.name = "image",
  });

  Map<String, dynamic> toJson() {
    return {
      'order': order,
      'type': type.name,
      'transform': CustomMatrixUtils.matrix4ToJson(transform),
      'path': name,
      'name': name,
    };
  }
}
