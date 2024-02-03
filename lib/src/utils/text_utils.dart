import 'dart:convert';
import 'package:flutter/material.dart';

class TextUtils {
  static String colorToText(Color color) {
    return color.value.toRadixString(16);
  }

  static Color textToColor(String colorString) {
    return Color(int.parse(colorString, radix: 16));
  }

  static FontStyle textToFontStyle(String fontStyleString) {
    switch (fontStyleString.toLowerCase()) {
      case 'normal':
        return FontStyle.normal;
      case 'italic':
        return FontStyle.italic;
      default:
        return FontStyle.normal;
    }
  }

  static FontWeight textToFontWeight(String fontWeightString) {
    switch (fontWeightString.toLowerCase()) {
      case 'xsmall':
        return FontWeight.w100;
      case 'small':
        return FontWeight.w300;
      case 'medium':
        return FontWeight.w500;
      case 'large':
        return FontWeight.w700;
      case 'xlarge':
        return FontWeight.w900;
      default:
        return FontWeight.normal;
    }
  }

  static String fontWeightToText(FontWeight fontWeight) {
    switch (fontWeight) {
      case FontWeight.w100:
        return 'XSmall';
      case FontWeight.w300:
        return 'Small';
      case FontWeight.w500:
        return 'Medium';
      case FontWeight.w700:
        return 'Large';
      case FontWeight.w900:
        return 'XLarge';
      default:
        return 'Medium';
    }
  }

  static TextDecoration textToDecoration(String decorationString) {
    switch (decorationString.toLowerCase()) {
      case 'none':
        return TextDecoration.none;
      case 'underline':
        return TextDecoration.underline;
      case 'line through':
        return TextDecoration.lineThrough;
      case 'overline':
        return TextDecoration.overline;
      default:
        return TextDecoration.none;
    }
  }

  static String decorationToText(TextDecoration decoration) {
    switch (decoration) {
      case TextDecoration.none:
        return 'none';
      case TextDecoration.underline:
        return 'underline';
      case TextDecoration.overline:
        return 'overline';
      case TextDecoration.lineThrough:
        return 'line through';
      default:
        return '';
    }
  }
}
