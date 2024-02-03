import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/utils/validator.dart';

void main() {
  group('Validator Tests', () {
    late Validator validator;

    setUp(() {
      validator = Validator();
    });

    test('Null or Empty Check', () {
      expect(validator.checkNullEmpty(null), isTrue);
      expect(validator.checkNullEmpty(''), isTrue);
      expect(validator.checkNullEmpty('Non-empty'), isFalse);
    });

    test('Default Validator', () {
      expect(validator.defaultValidator(null, 'Field'),
          equals('Field is required'));
      expect(
          validator.defaultValidator('', 'Field'), equals('Field is required'));
      expect(validator.defaultValidator('Non-empty', 'Field'), isNull);
    });

    test('Phone Number Validator', () {
      expect(validator.phoneNumberValidator(null),
          equals('Phone Number is required'));
      expect(validator.phoneNumberValidator(''),
          equals('Phone Number is required'));
      expect(validator.phoneNumberValidator('123'),
          equals('Phone number is invalid'));
      expect(validator.phoneNumberValidator('1234567890'), isNull);
    });

    test('Email Validator', () {
      expect(validator.emailValidator(null), equals('Email is required'));
      expect(validator.emailValidator(''), equals('Email is required'));
      expect(
          validator.emailValidator('invalidEmail'), equals('Email is invalid'));
      expect(validator.emailValidator('valid@email.com'), isNull);
    });

    test('Password Validator', () {
      expect(validator.passwordValidator(null), equals('Password is required'));
      expect(validator.passwordValidator(''), equals('Password is required'));
      expect(validator.passwordValidator('weak'),
          equals('Password is not strong enough'));
      expect(validator.passwordValidator('StrongPassword123!'), isNull);
    });

    test('Confirm Password Validator', () {
      expect(validator.confirmPasswordValidator(null, 'password'),
          equals('Password is required'));
      expect(
          validator.confirmPasswordValidator('password', 'password'), isNull);
      expect(validator.confirmPasswordValidator('invalidPassword', 'password'),
          equals('Password is not confirmed'));
    });

    test('Name Validator', () {
      expect(validator.nameValidator(null), equals('Name is required'));
      expect(validator.nameValidator(''), equals('Name is required'));
      expect(validator.nameValidator('John'), isNull);
    });

    test('Surname Validator', () {
      expect(validator.surnameValidator(null), equals('Surname is required'));
      expect(validator.surnameValidator(''), equals('Surname is required'));
      expect(validator.surnameValidator('Doe'), isNull);
    });

    test('Date Validator', () {
      expect(validator.dateValidator(null), equals('Date is required'));
      expect(validator.dateValidator(''), equals('Date is required'));
      expect(validator.dateValidator('2022-02-02'), isNull);
    });
  });
}
