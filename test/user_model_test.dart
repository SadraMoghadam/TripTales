import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/models/user_model.dart';

void main() {
  group('UserModel Tests', () {
    test('Create UserModel instance from JSON', () {
      final json = {
        'id': '123',
        'email': 'test@example.com',
        'name': 'John',
        'surname': 'Doe',
        'birthDate': '1990-01-01',
        'phoneNumber': '123456789',
        'bio': 'Lorem ipsum',
        'gender': 'Male',
        'profileImage': 'profile.jpg',
        'talesFK': ['1', '2'],
      };

      final imageURL = 'https://example.com/image.jpg';
      final user = UserModel.fromJson(json, imageURL);

      expect(user.id, '123');
      expect(user.email, 'test@example.com');
      expect(user.name, 'John');
      expect(user.surname, 'Doe');
      expect(user.birthDate, '1990-01-01');
      expect(user.phoneNumber, '123456789');
      expect(user.bio, 'Lorem ipsum');
      expect(user.gender, 'Male');
      expect(user.profileImage, 'https://example.com/image.jpg');
      expect(user.talesFK, ['1', '2']);
    });

    test('Create UserModel instance from JSON with null values', () {
      final json = {
        'id': null,
        'email': null,
        'name': null,
        'surname': null,
        'birthDate': null,
        'phoneNumber': null,
        'bio': null,
        'gender': null,
        'profileImage': null,
        'talesFK': null,
      };

      final user = UserModel.fromJson(json, null);

      expect(user.id, '1'); // Default value if id is null
      expect(user.email, '');
      expect(user.name, '');
      expect(user.surname, '');
      expect(user.birthDate, '');
      expect(user.phoneNumber, '');
      expect(user.bio, '');
      expect(user.gender, '');
      expect(user.profileImage, '');
      expect(user.talesFK, null);
    });

    test('Create JSON from UserModel instance', () {
      final user = UserModel(
        id: '123',
        email: 'test@example.com',
        name: 'John',
        surname: 'Doe',
        birthDate: '1990-01-01',
        phoneNumber: '123456789',
        bio: 'Lorem ipsum',
        gender: 'Male',
        profileImage: 'profile.jpg',
        talesFK: ['1', '2'],
      );

      final json = user.toJson();

      expect(json['id'], '123');
      expect(json['email'], 'test@example.com');
      expect(json['name'], 'John');
      expect(json['surname'], 'Doe');
      expect(json['birthDate'], '1990-01-01');
      expect(json['phoneNumber'], '123456789');
      expect(json['bio'], 'Lorem ipsum');
      expect(json['gender'], 'Male');
      expect(json['profileImage'], 'profile.jpg');
      expect(json['talesFK'], ['1', '2']);
    });

    test('Create UserModel instance with default values', () {
      final user = UserModel(
        id: '123',
        email: 'test@example.com',
        name: 'John',
        surname: 'Doe',
        birthDate: '1990-01-01',
      );

      expect(user.phoneNumber, ''); // Default value for phoneNumber
      expect(user.bio, ''); // Default value for bio
      expect(user.gender, ''); // Default value for gender
      expect(user.profileImage, ''); // Default value for profileImage
      expect(user.talesFK, null); // Default value for talesFK
    });

    test('Create UserModel instance with null values and default values', () {
      final user = UserModel(
        id: '1',
        email: '',
        name: '',
        surname: '',
        birthDate: '',
      );

      expect(user.id, '1'); // Default value if id is null
      expect(user.email, '');
      expect(user.name, '');
      expect(user.surname, '');
      expect(user.birthDate, '');
      expect(user.phoneNumber, '');
      expect(user.bio, '');
      expect(user.gender, '');
      expect(user.profileImage, '');
      expect(user.talesFK, null);
    });

    test('Equality Test', () {
      final user1 = UserModel(
        id: '123',
        email: 'test@example.com',
        name: 'John',
        surname: 'Doe',
        birthDate: '1990-01-01',
        phoneNumber: '123456789',
        bio: 'Lorem ipsum',
        gender: 'Male',
        profileImage: 'profile.jpg',
        talesFK: ['1', '2'],
      );

      final user2 = UserModel(
        id: '123',
        email: 'test@example.com',
        name: 'John',
        surname: 'Doe',
        birthDate: '1990-01-01',
        phoneNumber: '123456789',
        bio: 'Lorem ipsum',
        gender: 'Male',
        profileImage: 'profile.jpg',
        talesFK: ['1', '2'],
      );

      final user3 = UserModel(
        id: '456',
        email: 'test2@example.com',
        name: 'Jane',
        surname: 'Doe',
        birthDate: '1990-01-01',
        phoneNumber: '987654321',
        bio: 'Dolor sit amet',
        gender: 'Female',
        profileImage: 'profile2.jpg',
        talesFK: ['3', '4'],
      );

      expect(user1, isNot(equals(user2)));
      expect(user1, isNot(equals(user3)));
    });

    test('Create UserModel instance with empty talesFK list', () {
      final user = UserModel(
        id: '123',
        email: 'test@example.com',
        name: 'John',
        surname: 'Doe',
        birthDate: '1990-01-01',
        phoneNumber: '123456789',
        bio: 'Lorem ipsum',
        gender: 'Male',
        profileImage: 'profile.jpg',
        talesFK: [],
      );

      expect(user.talesFK, isEmpty);
    });

    test('Create UserModel instance with null talesFK list', () {
      final user = UserModel(
        id: '123',
        email: 'test@example.com',
        name: 'John',
        surname: 'Doe',
        birthDate: '1990-01-01',
        phoneNumber: '123456789',
        bio: 'Lorem ipsum',
        gender: 'Male',
        profileImage: 'profile.jpg',
        talesFK: null,
      );

      expect(user.talesFK, null);
    });

    test('ToJson Method', () {
      final user = UserModel(
        id: '123',
        email: 'test@example.com',
        name: 'John',
        surname: 'Doe',
        birthDate: '1990-01-01',
        phoneNumber: '123456789',
        bio: 'Lorem ipsum',
        gender: 'Male',
        profileImage: 'profile.jpg',
        talesFK: ['1', '2'],
      );

      final json = user.toJson();

      expect(json['id'], '123');
      expect(json['email'], 'test@example.com');
      expect(json['name'], 'John');
      expect(json['surname'], 'Doe');
      expect(json['birthDate'], '1990-01-01');
      expect(json['phoneNumber'], '123456789');
      expect(json['bio'], 'Lorem ipsum');
      expect(json['gender'], 'Male');
      expect(json['profileImage'], 'profile.jpg');
      expect(json['talesFK'], ['1', '2']);
    });

    test('ToJson Method with null values', () {
      final user = UserModel(
        id: '1',
        email: '',
        name: '',
        surname: '',
        birthDate: '',
      );

      final json = user.toJson();

      expect(json['id'], '1');
      expect(json['email'], '');
      expect(json['name'], '');
      expect(json['surname'], '');
      expect(json['birthDate'], '');
      expect(json['phoneNumber'], '');
      expect(json['bio'], '');
      expect(json['gender'], '');
      expect(json['profileImage'], '');
      expect(json['talesFK'], null);
    });

    test('Create UserModel instance with default values and empty talesFK list',
        () {
      final user = UserModel(
        id: '123',
        email: 'test@example.com',
        name: 'John',
        surname: 'Doe',
        birthDate: '1990-01-01',
        talesFK: [],
      );

      expect(user.phoneNumber, ''); // Default value for phoneNumber
      expect(user.bio, ''); // Default value for bio
      expect(user.gender, ''); // Default value for gender
      expect(user.profileImage, ''); // Default value for profileImage
      expect(user.talesFK, isEmpty);
    });

    test('Equality Test with null talesFK list', () {
      final user1 = UserModel(
        id: '123',
        email: 'test@example.com',
        name: 'John',
        surname: 'Doe',
        birthDate: '1990-01-01',
        talesFK: ['1', '2'],
      );

      final user2 = UserModel(
        id: '123',
        email: 'test@example.com',
        name: 'John',
        surname: 'Doe',
        birthDate: '1990-01-01',
        talesFK: null,
      );

      expect(user1, isNot(equals(user2)));
    });
  });
}
