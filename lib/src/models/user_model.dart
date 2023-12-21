class UserModel {
  final String uid;
  final String email;
  final String name;
  final String surname;
  final String birthDate;
  final String phoneNumber;
  final String bio;
  final String gender;
  final String profileImage;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.surname,
    required this.birthDate,
    this.phoneNumber = '',
    this.bio = '',
    this.gender = '',
    this.profileImage = '',
  });
}