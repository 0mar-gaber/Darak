class PropertyResponseEntity {
  final List<PropertyItemEntity> recommendedProperties;
  final List<PropertyItemEntity> allProperties;

  PropertyResponseEntity({
    required this.recommendedProperties,
    required this.allProperties,
  });
}

class PropertyItemEntity {
  final String id;
  final String title;
  final String location;
  final String priceFormatted;
  final String areaFormatted;
  final String imageUrl;

  PropertyItemEntity({
    required this.id,
    required this.title,
    required this.location,
    required this.priceFormatted,
    required this.areaFormatted,
    required this.imageUrl,
  });
}
