class UserModel {
  final String id;
  final String email;
  final String name;
  final String surname;
  final String birthDate;
  final String phoneNumber;
  final String bio;
  final String gender;
  final String profileImage;
  final List<String>? talesFK;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.surname,
    required this.birthDate,
    this.phoneNumber = '',
    this.bio = '',
    this.gender = '',
    this.profileImage = '',
    this.talesFK,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      surname: json['surname'],
      birthDate: json['birthDate'],
      phoneNumber: json['phoneNumber'] ?? '',
      bio: json['bio'] ?? '',
      gender: json['gender'] ?? '',
      profileImage: json['profileImage'] ?? '',
      talesFK: json['talesFK'] != null
          ? List<String>.from(json['talesFK'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'surname': surname,
      'birthDate': birthDate,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'gender': gender,
      'profileImage': profileImage,
      'talesFK': talesFK,
    };
  }
}