import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/utils/tuple.dart';

void main() {
  group('Tuple Tests', () {
    test('Creating a Tuple', () {
      final Tuple<int, String> tuple = Tuple(42, 'Hello');

      expect(tuple.item1, equals(42));
      expect(tuple.item2, equals('Hello'));
    });

    test('Creating a Tuple with different types', () {
      final Tuple<double, bool> tuple = Tuple(3.14, true);

      expect(tuple.item1, equals(3.14));
      expect(tuple.item2, equals(true));
    });
    test('Creating a Tuple', () {
      final Tuple<int, String> tuple = Tuple(42, 'Hello');

      expect(tuple.item1, equals(42));
      expect(tuple.item2, equals('Hello'));
    });

    test('Creating a Tuple with different types', () {
      final Tuple<double, bool> tuple = Tuple(3.14, true);

      expect(tuple.item1, equals(3.14));
      expect(tuple.item2, equals(true));
    });

    test('Creating a Tuple with null values', () {
      final Tuple<int?, String?> tuple = Tuple(null, 'World');

      expect(tuple.item1, equals(null));
      expect(tuple.item2, equals('World'));
    });

    test('String Tuple Concatenation', () {
      final Tuple<String, String> tuple1 = Tuple('Hello', ', ');
      final Tuple<String, String> tuple2 = Tuple('World', '!');

      final Tuple<String, String> result =
          Tuple(tuple1.item1 + tuple2.item1, tuple1.item2 + tuple2.item2);

      expect(result.item1, equals('HelloWorld'));
      expect(result.item2, equals(', !'));
    });

    test('Modifying Tuple items', () {
      Tuple<int, String> tuple = Tuple(42, 'Hello');

      tuple = Tuple(tuple.item1 + 10, tuple.item2.toUpperCase());

      expect(tuple.item1, equals(52));
      expect(tuple.item2, equals('HELLO'));
    });

    test('Mapping Tuple Items', () {
      final Tuple<int, String> originalTuple = Tuple(5, 'Flutter');

      final Tuple<String, String> mappedTuple = Tuple(
        originalTuple.item1.toString(),
        originalTuple.item2.toUpperCase(),
      );

      expect(mappedTuple.item1, equals('5'));
      expect(mappedTuple.item2, equals('FLUTTER'));
    });

    test('Tuple List Operations', () {
      final List<Tuple<int, String>> tupleList = [
        Tuple(1, 'One'),
        Tuple(2, 'Two'),
        Tuple(3, 'Three'),
      ];

      final List<String> mappedStrings =
          tupleList.map((tuple) => tuple.item2).toList();

      expect(mappedStrings, equals(['One', 'Two', 'Three']));
    });
  });
}
