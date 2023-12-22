import 'dart:convert';
import 'package:flutter/material.dart';

class CustomMatrixUtils {
  static Map<String, dynamic> matrix4ToJson(Matrix4 matrix) {
    List<double> storage = matrix.storage;
    return {
      'm11': storage[0],
      'm12': storage[1],
      'm13': storage[2],
      'm14': storage[3],
      'm21': storage[4],
      'm22': storage[5],
      'm23': storage[6],
      'm24': storage[7],
      'm31': storage[8],
      'm32': storage[9],
      'm33': storage[10],
      'm34': storage[11],
      'm41': storage[12],
      'm42': storage[13],
      'm43': storage[14],
      'm44': storage[15],
    };
  }

  static Matrix4 jsonToMatrix4(Map<String, dynamic> json) {
    return Matrix4(
      json['m11'] ?? 0.0,
      json['m12'] ?? 0.0,
      json['m13'] ?? 0.0,
      json['m14'] ?? 0.0,
      json['m21'] ?? 0.0,
      json['m22'] ?? 0.0,
      json['m23'] ?? 0.0,
      json['m24'] ?? 0.0,
      json['m31'] ?? 0.0,
      json['m32'] ?? 0.0,
      json['m33'] ?? 0.0,
      json['m34'] ?? 0.0,
      json['m41'] ?? 0.0,
      json['m42'] ?? 0.0,
      json['m43'] ?? 0.0,
      json['m44'] ?? 0.0,
    );
  }
}