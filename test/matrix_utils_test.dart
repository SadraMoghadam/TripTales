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

  test('Test jsonToMatrix4', () {
    final json = {
      'm11': 1.0,
      'm12': 0.0,
      'm13': 0.0,
      'm14': 0.0,
      'm21': 0.0,
      'm22': 1.0,
      'm23': 0.0,
      'm24': 0.0,
      'm31': 0.0,
      'm32': 0.0,
      'm33': 1.0,
      'm34': 0.0,
      'm41': 0.0,
      'm42': 0.0,
      'm43': 0.0,
      'm44': 1.0,
    };
    final matrix = CustomMatrixUtils.jsonToMatrix4(json);

    expect(matrix, isNotNull);
    expect(matrix, isA<Matrix4>());
    expect(matrix.storage[0], 1.0);
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

  test('Test jsonToMatrix4 with missing values', () {
    final json = {
      'm11': 1.0,
      'm12': 0.0, // missing value
      'm13': 0.0,
      'm14': 0.0,
      'm21': 0.0,
      'm22': 1.0,
      'm23': 0.0,
      'm24': 0.0,
      'm31': 0.0,
      'm32': 0.0,
      'm33': 1.0,
      'm34': 0.0,
      'm41': 0.0,
      'm42': 0.0,
      'm43': 0.0,
      'm44': 1.0,
    };
    final matrix = CustomMatrixUtils.jsonToMatrix4(json);

    // expect(matrix, isNotNull);
    // expect(matrix, isA<Matrix4>());
    expect(matrix.storage[0], 1.0);
    expect(matrix.storage[1], 0.0);
    expect(matrix.storage[2], 0.0);
    expect(matrix.storage[3], 0.0);
    expect(matrix.storage[4], 0.0);
    expect(matrix.storage[5], 1.0);
    expect(matrix.storage[6], 0.0);
    expect(matrix.storage[7], 0.0);
    expect(matrix.storage[8], 0.0);
    expect(matrix.storage[9], 0.0);
    expect(matrix.storage[10], 1.0);
    expect(matrix.storage[11], 0.0);
    expect(matrix.storage[12], 0.0);
    expect(matrix.storage[13], 0.0);
    expect(matrix.storage[14], 0.0);
    expect(matrix.storage[15], 1.0);
  });

  test('Valid Map to Matrix4 Conversion', () {
    Map<String, dynamic> json = {
      'm11': 1.0,
      'm12': 2.0,
      'm13': 3.0,
      'm14': 4.0,
      'm21': 5.0,
      'm22': 6.0,
      'm23': 7.0,
      'm24': 8.0,
      'm31': 9.0,
      'm32': 10.0,
      'm33': 11.0,
      'm34': 12.0,
      'm41': 13.0,
      'm42': 14.0,
      'm43': 15.0,
      'm44': 16.0,
    };

    Matrix4 result = CustomMatrixUtils.jsonToMatrix4(json);

    expect(
        result,
        equals(Matrix4(
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
        )));
  });

  test('Map with Null Values to Matrix4 Conversion', () {
    Map<String, dynamic> json = {
      'm11': null,
      'm12': null,
      'm13': null,
      'm14': null,
      'm21': null,
      'm22': null,
      'm23': null,
      'm24': null,
      'm31': null,
      'm32': null,
      'm33': null,
      'm34': null,
      'm41': null,
      'm42': null,
      'm43': null,
      'm44': null,
    };

    Matrix4 result = CustomMatrixUtils.jsonToMatrix4(json);

    expect(
        result,
        equals(Matrix4(
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
        )));
  });

  test('Map with Mixed Null and Numeric Values to Matrix4 Conversion', () {
    Map<String, dynamic> json = {
      'm11': null,
      'm22': 2.5,
      'm33': null,
      'm44': 4.0,
    };

    Matrix4 result = CustomMatrixUtils.jsonToMatrix4(json);

    expect(
        result,
        equals(Matrix4(
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
        )));
  });

  test('Map with Missing Values to Matrix4 Conversion', () {
    Map<String, dynamic> json = {
      'm11': 1.0,
      'm12': 2.0,
      'm21': 5.0,
      'm22': 6.0,
      'm23': 7.0,
      // Missing values should default to 0.0
    };

    Matrix4 result = CustomMatrixUtils.jsonToMatrix4(json);

    expect(
        result,
        equals(Matrix4(
          1.0,
          2.0,
          0.0,
          0.0,
          5.0,
          6.0,
          7.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
        )));
  });

  test('Map with Non-numeric Values to Matrix4 Conversion', () {
    Map<String, dynamic> json = {
      'm11': 'text', // Invalid value, should default to 0.0
      'm22': true, // Invalid value, should default to 0.0
      'm33': 3.14, // Valid value, should be preserved
    };

    Matrix4 result = CustomMatrixUtils.jsonToMatrix4(json);

    expect(
        result,
        equals(Matrix4(
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          3.14,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
        )));
  });
}
