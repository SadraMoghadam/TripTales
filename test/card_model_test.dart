import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/constants/memory_card_type.dart';
import 'package:trip_tales/src/models/card_model.dart';
import 'package:trip_tales/src/utils/matrix_utils.dart'; // Assuming the file is named card_model.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/models/card_model.dart'; // Assuming the file is named card_model.dart

void main() {
  late CardModel card;

  setUp(() {
    card = CardModel(
        order: 1, type: MemoryCardType.image, transform: Matrix4.identity());
  });

  group('CardModel Tests', () {
    setUp(() {
      card = CardModel(
          order: 1, type: MemoryCardType.image, transform: Matrix4.identity());
    });

    test('Set Transform', () {
      final initialTransform = card.transform;

      card.setTransform(Matrix4.translationValues(10, 20, 30));

      expect(card.transform, Matrix4.translationValues(10, 20, 30));
      expect(card.transform, isNot(equals(initialTransform)));
    });
    test('Default CardModel Values', () {
      expect(card.name, 'image');
      expect(card.transform, Matrix4.identity());
      expect(card.size, Size(300, 300));
      expect(card.path, '');
      expect(card.text, '');
      expect(card.textColor, AppColors.text1);
      expect(card.textBackgroundColor, AppColors.main2);
      expect(card.textDecoration, TextDecoration.none);
      expect(card.fontStyle, FontStyle.normal);
      expect(card.fontWeight, FontWeight.normal);
      expect(card.fontSize, 16);
      //expect(() => card.order, throwsLateInitializationError);
    });

    test('Set Order and Transform', () {
      card.setOrder(2);
      card.setTransform(Matrix4.translationValues(10, 20, 30));

      expect(card.order, 2);
      expect(card.transform, Matrix4.translationValues(10, 20, 30));
    });

    test('ToJson Method', () {
      final json = card.toJson();

      expect(json['name'], 'image');
      expect(json['order'], 1);
      expect(json['type'], 'image');
      expect(json['transform'],
          CustomMatrixUtils.matrix4ToJson(Matrix4.identity()));
      expect(json['path'], 'image');
      expect(json['size'], 300);
    });

    test('ToJsonTextCard Method', () {
      card = CardModel(
          order: 1,
          type: MemoryCardType.text,
          transform: Matrix4.identity(),
          text: 'Hello');
      final json = card.toJsonTextCard();

      expect(json['name'], 'image');
      expect(json['order'], 1);
      expect(json['type'], 'text');
      expect(json['transform'],
          CustomMatrixUtils.matrix4ToJson(Matrix4.identity()));
      expect(json['text'], 'Hello');
      // Add more assertions for other properties related to text cards
    });

    test('ToJson Method for Text Card', () {
      card = CardModel(
        order: 1,
        type: MemoryCardType.text,
        transform: Matrix4.identity(),
        text: 'Hello',
        textColor: Colors.red,
        textBackgroundColor: Colors.blue,
        textDecoration: TextDecoration.underline,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      );

      final json = card.toJson();

      expect(json['name'], 'image');
      expect(json['order'], 1);
      expect(json['type'], 'text');
      expect(json['transform'],
          CustomMatrixUtils.matrix4ToJson(Matrix4.identity()));
      expect(json['text'], 'Hello');
      expect(json['textColor'],
          Colors.red.value); // Verify numeric representation for color
      expect(json['textBackgroundColor'],
          Colors.blue.value); // Verify numeric representation for color
      expect(json['textDecoration'], 'underline');
      expect(json['fontStyle'], 'italic');
      expect(json['fontWeight'], 'bold');
      expect(json['fontSize'], 20);
    });

    test('Set Order and Transform', () {
      card.setOrder(2);
      card.setTransform(Matrix4.translationValues(10, 20, 30));

      expect(card.order, 2);
      expect(card.transform, Matrix4.translationValues(10, 20, 30));
    });

    test('ToJson Method for Image Card', () {
      final json = card.toJson();

      expect(json['name'], 'image');
      expect(json['order'], 1);
      expect(json['type'], 'image');
      expect(json['transform'],
          CustomMatrixUtils.matrix4ToJson(Matrix4.identity()));
      expect(json['path'], 'image');
      expect(json['size'], 300);
    });

    test('ToJson Method for Text Card', () {
      card = CardModel(
        order: 1,
        type: MemoryCardType.text,
        transform: Matrix4.identity(),
        text: 'Hello',
        textColor: Colors.red,
        textBackgroundColor: Colors.blue,
        textDecoration: TextDecoration.underline,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      );

      final json = card.toJson();

      expect(json['name'], 'image');
      expect(json['order'], 1);
      expect(json['type'], 'text');
      expect(json['transform'],
          CustomMatrixUtils.matrix4ToJson(Matrix4.identity()));
      expect(json['text'], 'Hello');
      expect(json['textColor'],
          Colors.red.value); // Verify numeric representation for color
      expect(json['textBackgroundColor'],
          Colors.blue.value); // Verify numeric representation for color
      expect(json['textDecoration'], 'underline');
      expect(json['fontStyle'], 'italic');
      expect(json['fontWeight'], 'bold');
      expect(json['fontSize'], 20);
    });
  });
}
