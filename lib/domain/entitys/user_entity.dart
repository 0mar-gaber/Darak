import 'dart:convert';

class UserEntity {
  final String email;
  final String userId;
  final String token;
  final String message;

  UserEntity({
    required this.email,
    required this.userId,
    required this.token,
    required this.message,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      email: json['email'],
      userId: json['userId'],
      token: json['token'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'userId': userId,
      'token': token,
      'message': message,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
