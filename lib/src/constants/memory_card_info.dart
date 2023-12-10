import 'package:flutter/material.dart';
import 'memory_card_type.dart';

class MemoryCardInfo {

  final GlobalKey cardKey;
  final MemoryCardType type;
  final Size size;
  final String imagePath;
  final String videoPath;
  var position;
  var rotation;

  MemoryCardInfo({
    required this.size,
    required this.cardKey,
    required this.type,
    this.position = const (0, 0, 0),
    this.rotation,
    this.imagePath = 'assets/images/canvas1.jpg',
    this.videoPath = 'assets/images/canvas1.jpg',
  });
}