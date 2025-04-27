import 'dart:convert';

class UserDetailsModel {
  final String id;
  final String userName;
  final String email;
  final String phoneNumber;
  final String bio;
  final String gender;
  final String profilePictureUrl;

  UserDetailsModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.bio,
    required this.gender,
    required this.profilePictureUrl,
  });

  // Factory method لتحويل JSON إلى كائن من نوع UserModel
  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      bio: json['bio'] ?? '',
      gender: json['gender'] ?? '',
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
      'bio': bio,
      'gender': gender,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}
