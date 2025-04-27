import 'dart:convert';

class UserDetailsEntity {
  final String id;
  final String userName;
  final String email;
  final String phoneNumber;
  final String gender;
  final String bio;
  final String profilePictureUrl;

  UserDetailsEntity({
    required this.id,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.bio,
    required this.profilePictureUrl,
  });

  // Factory method لتحويل JSON إلى كائن من نوع UserModel
  factory UserDetailsEntity.fromJson(Map<String, dynamic> json) {
    return UserDetailsEntity(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      gender: json['gender'] ?? '',
      bio: json['bio'] ?? '',
      profilePictureUrl: json['profilePictureUrl'] ?? '',
    );
  }

  // تحويل الكائن إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'bio': bio,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}
