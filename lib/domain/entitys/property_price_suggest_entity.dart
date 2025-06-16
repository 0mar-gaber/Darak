class PropertyPriceSuggestEntity {
  final num areaSqm; // المساحة بالمتر المربع
  final String propertyType; // نوع العقار (شقة، فيلا، إلخ)
  final num bedrooms; // عدد غرف النوم
  final num bathrooms; // عدد الحمامات
  final num buildingAgeYears; // عمر المبنى بالسنوات
  final num floorLevel; // رقم الطابق
  final String location; // الموقع
  final num price; // السعر

  // constructor
  PropertyPriceSuggestEntity({
    required this.areaSqm,
    required this.propertyType,
    required this.bedrooms,
    required this.bathrooms,
    required this.buildingAgeYears,
    required this.floorLevel,
    required this.location,
    required this.price,
  });

  // factory constructor لتحويل JSON إلى كائن Property
  factory PropertyPriceSuggestEntity.fromJson(Map<String, dynamic> json) {
    return PropertyPriceSuggestEntity(
      areaSqm: (json['Area (sqm)'] as num).toDouble(),
      propertyType: json['Property Type'] as String,
      bedrooms: json['Bedrooms'] as num,
      bathrooms: json['Bathrooms'] as num,
      buildingAgeYears: json['Building Age (years)'] as num,
      floorLevel: json['Floor Level'] as num,
      location: json['Location'] as String,
      price: (json['Price'] as num).toDouble(),
    );
  }

  // ميثود لتحويل كائن Property إلى JSON (عند إرسال البيانات مثلاً)
  Map<String, dynamic> toJson() {
    return {
      'Area (sqm)': areaSqm,
      'Property Type': propertyType,
      'Bedrooms': bedrooms,
      'Bathrooms': bathrooms,
      'Building Age (years)': buildingAgeYears,
      'Floor Level': floorLevel,
      'Location': location,
      'Price': price,
    };
  }
}