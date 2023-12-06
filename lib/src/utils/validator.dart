import 'package:flutter/material.dart';

class Validator {
  bool checkNullEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return true;
    }
    return false;
  }

  String? defaultValidator(String? value, String fieldName) {
    if (checkNullEmpty(value)) {
      return '$fieldName is required';
    }
    return null;
  }

  String? emailValidator(String? value) {
    bool isEmail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value.toString());
    String? defaultText = defaultValidator(value, 'Email');
    if (defaultText != null) {
      return defaultText;
    }

    if (!isEmail) {
      return 'Email is invalid';
    }
    return null;
  }

  int checkPasswordStrength(String value) {
    int hasUppercase = value.contains(RegExp(r'[A-Z]')) ? 1 : 0;
    int hasLowercase = value.contains(RegExp(r'[a-z]')) ? 1 : 0;
    int hasDigits = value.contains(RegExp(r'[0-9]')) ? 1 : 0;
    int hasSpecialCharacters =
        value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ? 1 : 0;

    return hasUppercase + hasLowercase + hasDigits + hasSpecialCharacters;
  }

  String? passwordValidator(String? value) {
    String? defaultText = defaultValidator(value, 'Password');
    if (defaultText != null) {
      return defaultText;
    }
    if (checkPasswordStrength(value!) <= 2) {
      return 'Password is not strong enough';
    }
    return null;
  }

  String? confirmPasswordValidator(String? value, String password) {
    String? defaultText = defaultValidator(value, 'Password');
    if (defaultText != null) {
      return defaultText;
    }
    if (password != value) {
      return 'Password is not confirmed';
    }
    return null;
  }

  String? nameValidator(String? value) => defaultValidator(value, "Name");
  String? surnameValidator(String? value) => defaultValidator(value, "Surname");
  String? dateValidator(String? value) => defaultValidator(value, "Date");
}
