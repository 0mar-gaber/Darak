class UserDetailsEntity {
  final String id;
  final String userName;
  final String email;
  final String profilePictureUrl;
  final String city;
  final String governorate;

  UserDetailsEntity({
    required this.id,
    required this.userName,
    required this.email,
    required this.profilePictureUrl,
    required this.city,
    required this.governorate,
  });

  factory UserDetailsEntity.fromJson(Map<String, dynamic> json) {
    return UserDetailsEntity(
      id: json['id'] ?? '',
      userName: json['bio'] ?? '',
      email: json['email'] ?? '',
      profilePictureUrl: json['profilePictureUrl'] ?? '',
      city: json['city'] ?? '',
      governorate: json['governorate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bio': userName,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
      'city': city,
      'governorate': governorate,
    };
  }
}
