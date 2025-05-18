class FilterModel {
  double? minPrice;
  double? maxPrice;
  int? minArea;
  int? maxArea;
  int? rooms;
  int? bathrooms;
  String? propertyType;
  String? city;
  String? availability;
  String? furnished;

  FilterModel({
    this.minPrice,
    this.maxPrice,
    this.minArea,
    this.maxArea,
    this.rooms,
    this.bathrooms,
    this.propertyType,
    this.availability,
    this.furnished,
    this.city
  });

  void reset() {
    minArea = null;
    maxArea = null;
    maxPrice = null;
    minPrice = null;
    rooms = null;
    bathrooms = null;
    propertyType = null;
    availability = null;
    furnished = null;
    city = null;
  }

  FilterModel copyWith({
    double? minPrice,
    double? maxPrice,
    int? minArea,
    int? maxArea,
    int? rooms,
    int? bathrooms,
    String? city,
    String? propertyType,
    String? availability,
    String? furnished,
  }) {
    return FilterModel(
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minArea: minArea ?? this.minArea,
      maxArea: maxArea ?? this.maxArea,
      rooms: rooms ?? this.rooms,
      bathrooms: bathrooms ?? this.bathrooms,
      propertyType: propertyType ?? this.propertyType,
      availability: availability ?? this.availability,
      furnished: furnished ?? this.furnished,
      city: city ?? this.city,
    );
  }
}
