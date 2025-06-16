class PropertyRequestEntity {
  final num area;
  final num bedrooms;
  final num bathrooms;
  final String propertyType;
  final List<String> amenities;
  final List<String> nearbyFacility;

  PropertyRequestEntity({
    required this.area,
    required this.bedrooms,
    required this.bathrooms,
    required this.propertyType,
    required this.amenities,
    required this.nearbyFacility,
  });

  Map<String, dynamic> toJson() {
    return {
      "Area (sqm)": area,
      "Bedrooms": bedrooms,
      "Bathrooms": bathrooms,
      "Property Type": propertyType,
      "Amenities": amenities.join(' '), // ← تحويل من List ل String
      "Nearby Facility": nearbyFacility.join(' '),
    };
  }
}
