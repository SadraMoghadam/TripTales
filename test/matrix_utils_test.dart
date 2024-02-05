import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class CustomMatrixUtils {
  static Map<String, dynamic> matrix4ToJson(Matrix4 matrix) {
    List<double> storage = matrix.storage;
    return {
      'storage': storage,
    };
  }

  static Matrix4 jsonToMatrix4(Map<String, dynamic> json) {
    List<double> storage = List<double>.from(json['storage']);
    return Matrix4.fromList(storage);
  }
}

void main() {
  test('Matrix4 to JSON', () {
    final matrix = Matrix4(
      1.0,
      2.0,
      3.0,
      4.0,
      5.0,
      6.0,
      7.0,
      8.0,
      9.0,
      10.0,
      11.0,
      12.0,
      13.0,
      14.0,
      15.0,
      16.0,
    );

    final jsonResult = CustomMatrixUtils.matrix4ToJson(matrix);

    expect(jsonResult['storage'], equals(matrix.storage));
  });

  test('JSON to Matrix4', () {
    final json = {
      'storage': [
        1.0,
        2.0,
        3.0,
        4.0,
        5.0,
        6.0,
        7.0,
        8.0,
        9.0,
        10.0,
        11.0,
        12.0,
        13.0,
        14.0,
        15.0,
        16.0,
      ],
    };

    final matrixResult = CustomMatrixUtils.jsonToMatrix4(json);

    // expect(matrixResult.storage, equals(List<double>.from(json['storage'])));
  });
  test('Matrix4 to JSON', () {
    final matrix = Matrix4(
      1.0,
      2.0,
      3.0,
      4.0,
      5.0,
      6.0,
      7.0,
      8.0,
      9.0,
      10.0,
      11.0,
      12.0,
      13.0,
      14.0,
      15.0,
      16.0,
    );

    final jsonResult = CustomMatrixUtils.matrix4ToJson(matrix);

    expect(jsonResult['storage'], equals(matrix.storage));
  });

  test('JSON to Matrix4', () {
    final json = {
      'storage': [
        1.0,
        2.0,
        3.0,
        4.0,
        5.0,
        6.0,
        7.0,
        8.0,
        9.0,
        10.0,
        11.0,
        12.0,
        13.0,
        14.0,
        15.0,
        16.0,
      ],
    };

    final matrixResult = CustomMatrixUtils.jsonToMatrix4(json);

    expect(matrixResult.storage, equals(List<double>.from(json['storage']!)));
  });

  test('Matrix4 to JSON', () {
    final matrix = Matrix4(
      1.0,
      2.0,
      3.0,
      4.0,
      5.0,
      6.0,
      7.0,
      8.0,
      9.0,
      10.0,
      11.0,
      12.0,
      13.0,
      14.0,
      15.0,
      16.0,
    );

    final jsonResult = CustomMatrixUtils.matrix4ToJson(matrix);

    expect(jsonResult['m11'], equals(null));
    expect(jsonResult['m22'], equals(null));
    expect(jsonResult['m33'], equals(null));
    expect(jsonResult['m44'], equals(null));
  });
  test('Test matrix4ToJson', () {
    final matrix = Matrix4.identity();
    final json = CustomMatrixUtils.matrix4ToJson(matrix);

    expect(json, isNotNull);
    expect(json, isA<Map<String, dynamic>>());
    expect(json.length, 1);
    expect(json['m11'], null);
  });

  test('Test matrix4ToJson with non-identity matrix', () {
    final matrix =
        Matrix4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
    final json = CustomMatrixUtils.matrix4ToJson(matrix);

    expect(json, isNotNull);
    expect(json, isA<Map<String, dynamic>>());
    expect(json.length, 1);
    expect(json['m11'], null);
    expect(json['m12'], null);
    expect(json['m13'], null);
    expect(json['m14'], null);
    expect(json['m21'], null);
    expect(json['m22'], null);
    expect(json['m23'], null);
    expect(json['m24'], null);
    expect(json['m31'], null);
    expect(json['m32'], null);
    expect(json['m33'], null);
    expect(json['m34'], null);
    expect(json['m41'], null);
    expect(json['m42'], null);
    expect(json['m43'], null);
    expect(json['m44'], null);
  });
}
