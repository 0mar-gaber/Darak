import 'dart:convert';

class UserModel {
  final String email;
  final String userId;
  final String role;
  final String token;
  final String message;
  final bool isAuthenticated;
  final DateTime expier;

  UserModel({
    required this.email,
    required this.userId,
    required this.role,
    required this.token,
    required this.message,
    required this.isAuthenticated,
    required this.expier,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      userId: json['userId'],
      role: json['role'],
      token: json['token'],
      message: json['message'],
      isAuthenticated: json['isAuthenticated'],
      expier: DateTime.parse(json['expier']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'userId': userId,
      'role': role,
      'token': token,
      'message': message,
      'isAuthenticated': isAuthenticated,
      'expier': expier.toIso8601String(),
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
