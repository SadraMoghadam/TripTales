import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/models/tale_model.dart';

void main() {
  group('TaleModel Tests', () {
    test('Create TaleModel instance with all values', () {
      final tale = TaleModel(
        id: '1',
        name: 'Sample Tale',
        imagePath: 'images/sample.jpg',
        canvas: 'Sample Canvas',
        liked: true,
        cardsFK: ['1', '2'],
      );

      expect(tale.id, '1');
      expect(tale.name, 'Sample Tale');
      expect(tale.imagePath, 'images/sample.jpg');
      expect(tale.canvas, 'Sample Canvas');
      expect(tale.liked, true);
      expect(tale.cardsFK, ['1', '2']);
    });

    test('Create TaleModel instance with default values', () {
      final tale = TaleModel(
        name: 'Default Tale',
        imagePath: 'images/default.jpg',
        canvas: 'Default Canvas',
      );

      expect(tale.id, null);
      expect(tale.name, 'Default Tale');
      expect(tale.imagePath, 'images/default.jpg');
      expect(tale.canvas, 'Default Canvas');
      expect(tale.liked, false);
      expect(tale.cardsFK, null);
    });

    test('ToJson Method', () {
      final tale = TaleModel(
        id: '1',
        name: 'Sample Tale',
        imagePath: 'images/sample.jpg',
        canvas: 'Sample Canvas',
        liked: true,
        cardsFK: ['1', '2'],
      );

      final json = tale.toJson();

      expect(json['id'], '1');
      expect(json['name'], 'Sample Tale');
      expect(json['imagePath'], 'images/sample.jpg');
      expect(json['canvas'], 'Sample Canvas');
      expect(json['liked'], true);
      expect(json['cardsFK'], ['1', '2']);
    });

    test('ToJson Method with null values', () {
      final tale = TaleModel(
        name: 'Default Tale',
        imagePath: 'images/default.jpg',
        canvas: 'Default Canvas',
      );

      final json = tale.toJson();

      expect(json['id'], null);
      expect(json['name'], 'Default Tale');
      expect(json['imagePath'], 'images/default.jpg');
      expect(json['canvas'], 'Default Canvas');
      expect(json['liked'], false);
      expect(json['cardsFK'], null);
    });

    test('Equality Test', () {
      final tale1 = TaleModel(
        id: '1',
        name: 'Sample Tale',
        imagePath: 'images/sample.jpg',
        canvas: 'Sample Canvas',
        liked: true,
        cardsFK: ['1', '2'],
      );

      final tale2 = TaleModel(
        id: '1',
        name: 'Sample Tale',
        imagePath: 'images/sample.jpg',
        canvas: 'Sample Canvas',
        liked: true,
        cardsFK: ['1', '2'],
      );

      final tale3 = TaleModel(
        id: '2',
        name: 'Another Tale',
        imagePath: 'images/another.jpg',
        canvas: 'Another Canvas',
        liked: false,
        cardsFK: ['3', '4'],
      );

      expect(tale1, isNot(equals(tale2)));
      expect(tale1, isNot(equals(tale3)));
    });

    test('Create TaleModel instance with empty cardsFK list', () {
      final tale = TaleModel(
        name: 'Empty CardsFK Tale',
        imagePath: 'images/empty_cards.jpg',
        canvas: 'Empty CardsFK Canvas',
        cardsFK: [],
      );

      expect(tale.cardsFK, isEmpty);
    });

    test('Create TaleModel instance with null cardsFK list', () {
      final tale = TaleModel(
        name: 'Null CardsFK Tale',
        imagePath: 'images/null_cards.jpg',
        canvas: 'Null CardsFK Canvas',
        cardsFK: null,
      );

      expect(tale.cardsFK, null);
    });

    test('ToJson Method with default values', () {
      final tale = TaleModel(
        name: 'Default Tale',
        imagePath: 'images/default.jpg',
        canvas: 'Default Canvas',
      );

      final json = tale.toJson();

      expect(json['id'], null);
      expect(json['name'], 'Default Tale');
      expect(json['imagePath'], 'images/default.jpg');
      expect(json['canvas'], 'Default Canvas');
      expect(json['liked'], false);
      expect(json['cardsFK'], null);
    });

    test('ToJson Method with liked set to false', () {
      final tale = TaleModel(
        name: 'Unliked Tale',
        imagePath: 'images/unliked.jpg',
        canvas: 'Unliked Canvas',
        liked: false,
      );

      final json = tale.toJson();

      expect(json['id'], null);
      expect(json['name'], 'Unliked Tale');
      expect(json['imagePath'], 'images/unliked.jpg');
      expect(json['canvas'], 'Unliked Canvas');
      expect(json['liked'], false);
      expect(json['cardsFK'], null);
    });

    test('Create TaleModel instance with long name', () {
      final tale = TaleModel(
        name: 'A very long tale name that exceeds the normal limit for a tale',
        imagePath: 'images/long_name.jpg',
        canvas: 'Long Name Canvas',
      );

      expect(tale.name,
          'A very long tale name that exceeds the normal limit for a tale');
    });

    test('Equality Test with null cardsFK', () {
      final tale1 = TaleModel(
        name: 'Tale with Null CardsFK',
        imagePath: 'images/null_cards.jpg',
        canvas: 'Null CardsFK Canvas',
        cardsFK: null,
      );

      final tale2 = TaleModel(
        name: 'Another Tale with Null CardsFK',
        imagePath: 'images/another_null_cards.jpg',
        canvas: 'Another Null CardsFK Canvas',
        cardsFK: null,
      );

      expect(tale1, isNot(equals(tale2)));
    });

    test('ToJson Method with empty name', () {
      final tale = TaleModel(
        name: '',
        imagePath: 'images/empty_name.jpg',
        canvas: 'Empty Name Canvas',
      );

      final json = tale.toJson();

      expect(json['id'], null);
      expect(json['name'], '');
      expect(json['imagePath'], 'images/empty_name.jpg');
      expect(json['canvas'], 'Empty Name Canvas');
      expect(json['liked'], false);
      expect(json['cardsFK'], null);
    });

    test('Equality Test with default and non-default values', () {
      final tale1 = TaleModel(
        name: 'Default Tale',
        imagePath: 'images/default.jpg',
        canvas: 'Default Canvas',
      );

      final tale2 = TaleModel(
        id: '1',
        name: 'Sample Tale',
        imagePath: 'images/sample.jpg',
        canvas: 'Sample Canvas',
        liked: true,
        cardsFK: ['1', '2'],
      );

      expect(tale1, isNot(equals(tale2)));
    });
  });
}
