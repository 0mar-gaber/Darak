import 'dart:convert';

class UserDetailsModel {
  final String id;
  final String userName;
  final String email;
  final String phoneNumber;
  final String bio;
  final String gender;
  final String profilePictureUrl;
  final String city;
  final String governorate;

  UserDetailsModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.bio,
    required this.gender,
    required this.profilePictureUrl,
    required this.city,
    required this.governorate,
  });

  // Factory method لتحويل JSON إلى كائن من نوع UserDetailsModel
  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      bio: json['bio'] ?? '',
      gender: json['gender'] ?? '',
      profilePictureUrl: json['profilePictureUrl'] ?? '',
      city: json['city'] ?? '',
      governorate: json['governorate'] ?? '',
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
      'city': city,
      'governorate': governorate,
    };
  }
}
