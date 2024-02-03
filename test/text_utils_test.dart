import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/utils/text_utils.dart';

void main() {
  group('TextUtils Tests', () {
    test('Color to Text Conversion', () {
      Color color = Colors.blue;
      expect(TextUtils.colorToText(color), equals('ff2196f3'));
    });

    test('Text to Color Conversion', () {
      String colorString = 'ff00ff00';
      Color color = TextUtils.textToColor(colorString);
      expect(color, equals(Color(0xff00ff00)));
    });

    test('Text to FontStyle Conversion', () {
      expect(TextUtils.textToFontStyle('normal'), equals(FontStyle.normal));
      expect(TextUtils.textToFontStyle('italic'), equals(FontStyle.italic));
      expect(TextUtils.textToFontStyle('invalid'), equals(FontStyle.normal));
    });

    test('Text to FontWeight Conversion', () {
      expect(TextUtils.textToFontWeight('xsmall'), equals(FontWeight.w100));
      expect(TextUtils.textToFontWeight('small'), equals(FontWeight.w300));
      expect(TextUtils.textToFontWeight('medium'), equals(FontWeight.w500));
      expect(TextUtils.textToFontWeight('large'), equals(FontWeight.w700));
      expect(TextUtils.textToFontWeight('xlarge'), equals(FontWeight.w900));
      expect(TextUtils.textToFontWeight('invalid'), equals(FontWeight.normal));
    });

    test('FontWeight to Text Conversion', () {
      expect(TextUtils.fontWeightToText(FontWeight.w100), equals('XSmall'));
      expect(TextUtils.fontWeightToText(FontWeight.w300), equals('Small'));
      expect(TextUtils.fontWeightToText(FontWeight.w500), equals('Medium'));
      expect(TextUtils.fontWeightToText(FontWeight.w700), equals('Large'));
      expect(TextUtils.fontWeightToText(FontWeight.w900), equals('XLarge'));
      expect(TextUtils.fontWeightToText(FontWeight.normal), equals('Medium'));
    });

    test('Text to TextDecoration Conversion', () {
      expect(TextUtils.textToDecoration('none'), equals(TextDecoration.none));
      expect(TextUtils.textToDecoration('underline'),
          equals(TextDecoration.underline));
      expect(TextUtils.textToDecoration('line through'),
          equals(TextDecoration.lineThrough));
      expect(TextUtils.textToDecoration('overline'),
          equals(TextDecoration.overline));
      expect(
          TextUtils.textToDecoration('invalid'), equals(TextDecoration.none));
    });

    test('TextDecoration to Text Conversion', () {
      expect(TextUtils.decorationToText(TextDecoration.none), equals('none'));
      expect(TextUtils.decorationToText(TextDecoration.underline),
          equals('underline'));
      expect(TextUtils.decorationToText(TextDecoration.overline),
          equals('overline'));
      expect(TextUtils.decorationToText(TextDecoration.lineThrough),
          equals('line through'));
      expect(
          TextUtils.decorationToText(TextDecoration.combine(
              [TextDecoration.underline, TextDecoration.lineThrough])),
          equals(''));
    });

    test('Invalid FontStyle String to FontStyle Conversion', () {
      expect(TextUtils.textToFontStyle('unknown'), equals(FontStyle.normal));
    });

    test('Invalid FontWeight String to FontWeight Conversion', () {
      expect(TextUtils.textToFontWeight('unknown'), equals(FontWeight.normal));
    });

    test('Invalid TextDecoration String to TextDecoration Conversion', () {
      expect(
          TextUtils.textToDecoration('unknown'), equals(TextDecoration.none));
    });
    test('Invalid TextDecoration to Text Conversion', () {
      expect(
          TextUtils.decorationToText(TextDecoration.combine(
              [TextDecoration.underline, TextDecoration.lineThrough])),
          equals(''));
    });
    test('FontWeight Text to FontWeight Conversion', () {
      FontWeight fontWeight = TextUtils.textToFontWeight('medium');
      expect(fontWeight, equals(FontWeight.w500));
    });

    test('TextDecoration Text to TextDecoration Conversion', () {
      TextDecoration textDecoration = TextUtils.textToDecoration('underline');
      expect(textDecoration, equals(TextDecoration.underline));
    });

    test('Valid FontWeight to Text Conversion', () {
      String text = TextUtils.fontWeightToText(FontWeight.w700);
      expect(text, equals('Large'));
    });

    test('Valid TextDecoration to Text Conversion', () {
      String text = TextUtils.decorationToText(TextDecoration.overline);
      expect(text, equals('overline'));
    });

    test('Valid Color to Text Conversion', () {
      Color color = Colors.blue;
      String colorString = TextUtils.colorToText(color);
      expect(
          colorString, equals('ff2196f3')); // Hex representation of blue color
    });
    test('Invalid FontWeight String to Default FontWeight', () {
      FontWeight fontWeight = TextUtils.textToFontWeight('invalid_weight');
      expect(fontWeight, equals(FontWeight.normal));
    });

    test('Invalid TextDecoration String to Default TextDecoration', () {
      TextDecoration textDecoration =
          TextUtils.textToDecoration('invalid_decoration');
      expect(textDecoration, equals(TextDecoration.none));
    });

    test('Invalid FontWeight to Default Text Conversion', () {
      String text =
          TextUtils.fontWeightToText(FontWeight.w900); // Invalid FontWeight
      expect(text, equals('XLarge')); // Default value
    });

    test('Invalid TextDecoration to Default Text Conversion', () {
      String text = TextUtils.decorationToText(
          TextDecoration.overline); // Invalid TextDecoration
      expect(text, equals('overline')); // Default value
    });

    test('Text to Color Conversion', () {
      Color color = TextUtils.textToColor(
          'ff00ff00'); // Hex representation of green color
      expect(color, equals(Color(0xff00ff00)));
    });

    test('Invalid FontStyle String to Default FontStyle', () {
      FontStyle fontStyle = TextUtils.textToFontStyle('invalid_style');
      expect(fontStyle, equals(FontStyle.normal));
    });

    test('Invalid FontWeight String to Default FontWeight', () {
      FontWeight fontWeight = TextUtils.textToFontWeight('invalid_weight');
      expect(fontWeight, equals(FontWeight.normal));
    });

    test('Invalid TextDecoration String to Default TextDecoration', () {
      TextDecoration textDecoration =
          TextUtils.textToDecoration('invalid_decoration');
      expect(textDecoration, equals(TextDecoration.none));
    });

    test('Invalid FontWeight to Default Text Conversion', () {
      String text =
          TextUtils.fontWeightToText(FontWeight.w100); // Invalid FontWeight
      expect(text, equals('XSmall')); // Default value
    });

    test('Invalid TextDecoration to Default Text Conversion', () {
      String text = TextUtils.decorationToText(
          TextDecoration.overline); // Invalid TextDecoration
      expect(text, equals('overline')); // Default value
    });

    test('Text to Color Conversion', () {
      Color color = TextUtils.textToColor(
          'ff00ff00'); // Hex representation of green color
      expect(color, equals(Color(0xff00ff00)));
    });

    test('Invalid FontStyle String to Default FontStyle', () {
      FontStyle fontStyle = TextUtils.textToFontStyle('invalid_style');
      expect(fontStyle, equals(FontStyle.normal));
    });
  });

  group('TextUtils FontWeight Tests', () {
    test('Valid FontWeight String to FontWeight Conversion', () {
      FontWeight fontWeight = TextUtils.textToFontWeight('medium');
      expect(fontWeight, equals(FontWeight.w500));
    });

    test('Valid FontWeight String to FontWeight Conversion (Extra Small)', () {
      FontWeight fontWeight = TextUtils.textToFontWeight('xsmall');
      expect(fontWeight, equals(FontWeight.w100));
    });

    test('Invalid FontWeight String to Default FontWeight Conversion', () {
      FontWeight fontWeight = TextUtils.textToFontWeight('invalid_weight');
      expect(fontWeight, equals(FontWeight.normal));
    });

    test('Valid FontWeight to Text Conversion (Medium)', () {
      String text = TextUtils.fontWeightToText(FontWeight.w500);
      expect(text, equals('Medium'));
    });

    test('Valid FontWeight to Text Conversion (Extra Small)', () {
      String text = TextUtils.fontWeightToText(FontWeight.w100);
      expect(text, equals('XSmall'));
    });

    test('Valid FontWeight to Text Conversion (Small)', () {
      String text = TextUtils.fontWeightToText(FontWeight.w300);
      expect(text, equals('Small'));
    });

    test('Valid FontWeight to Text Conversion (Large)', () {
      String text =
          TextUtils.fontWeightToText(FontWeight.w700); // Invalid FontWeight
      expect(text, equals('Large')); // Default value
    });

    test('Valid FontWeight to Text Conversion (Medium)', () {
      String text = TextUtils.fontWeightToText(FontWeight.w600);
      expect(text, equals('Medium'));
    });
    test('Valid FontWeight to Text Conversion (XLarge)', () {
      String text = TextUtils.fontWeightToText(FontWeight.w900);
      expect(text, equals('XLarge'));
    });
  });

  group('TextUtils TextDecoration Tests', () {
    test('Valid TextDecoration String to TextDecoration Conversion (None)', () {
      TextDecoration textDecoration = TextUtils.textToDecoration('none');
      expect(textDecoration, equals(TextDecoration.none));
    });

    test('Valid TextDecoration String to TextDecoration Conversion (Underline)',
        () {
      TextDecoration textDecoration = TextUtils.textToDecoration('underline');
      expect(textDecoration, equals(TextDecoration.underline));
    });

    test(
        'Valid TextDecoration String to TextDecoration Conversion (Line Through)',
        () {
      TextDecoration textDecoration =
          TextUtils.textToDecoration('line through');
      expect(textDecoration, equals(TextDecoration.lineThrough));
    });

    test('Valid TextDecoration String to TextDecoration Conversion (Overline)',
        () {
      TextDecoration textDecoration = TextUtils.textToDecoration('overline');
      expect(textDecoration, equals(TextDecoration.overline));
    });

    test('Invalid TextDecoration String to Default TextDecoration Conversion',
        () {
      TextDecoration textDecoration =
          TextUtils.textToDecoration('invalid_decoration');
      expect(textDecoration, equals(TextDecoration.none));
    });

    test(
        'Valid TextDecoration String to TextDecoration Conversion (Mixed Case)',
        () {
      TextDecoration textDecoration = TextUtils.textToDecoration('UnDeRLiNe');
      expect(textDecoration, equals(TextDecoration.underline));
    });

    test(
        'Valid TextDecoration String to TextDecoration Conversion (Extra Spaces)',
        () {
      TextDecoration textDecoration =
          TextUtils.textToDecoration('   overline   ');
      expect(textDecoration, equals(TextDecoration.overline));
    });

    test(
        'Valid TextDecoration String to TextDecoration Conversion (Empty String)',
        () {
      TextDecoration textDecoration = TextUtils.textToDecoration('');
      expect(textDecoration, equals(TextDecoration.none));
    });
  });
}
