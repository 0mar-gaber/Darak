class PropertyResponse {
  final List<Property> recommendedProperties;
  final List<Property> allProperties;

  PropertyResponse({
    required this.recommendedProperties,
    required this.allProperties,
  });

  factory PropertyResponse.fromJson(Map<String, dynamic> json) {
    return PropertyResponse(
      recommendedProperties: (json['recommendedProperties'] as List)
          .map((item) => Property.fromJson(item))
          .toList(),
      allProperties: (json['allProperties'] as List)
          .map((item) => Property.fromJson(item))
          .toList(),
    );
  }
}

class Property {
  final String id;
  final String title;
  final String location;
  final String priceFormatted;
  final String areaFormatted;
  final String imageUrl;

  Property({
    required this.id,
    required this.title,
    required this.location,
    required this.priceFormatted,
    required this.areaFormatted,
    required this.imageUrl,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      location: json['city'] ?? '',
      priceFormatted: json['priceFormatted'] ?? '',
      areaFormatted: json['areaFormatted'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
