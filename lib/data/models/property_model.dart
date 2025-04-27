class PropertyModel {
  final String id;
  final String title;
  final String description;
  final int price;
  final String type;
  final String location;
  final int bedrooms;
  final int bathrooms;
  final int floor;
  final List<String> images;
  final int area;
  final String furnishStatus;
  final String? mainImageUrl;
  final List<String> amenities;
  final DateTime createdAt;
  final String shortDescription;
  final String priceFormatted;
  final String locationShort;

  PropertyModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.type,
    required this.location,
    required this.bedrooms,
    required this.bathrooms,
    required this.floor,
    required this.images,
    required this.area,
    required this.furnishStatus,
    this.mainImageUrl,
    required this.amenities,
    required this.createdAt,
    required this.shortDescription,
    required this.priceFormatted,
    required this.locationShort,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      type: json['type'],
      location: json['location'],
      bedrooms: json['bedrooms'],
      bathrooms: json['bathrooms'],
      floor: json['floor'],
      images: List<String>.from(json['images']),
      area: json['area'],
      furnishStatus: json['furnishStatus'],
      mainImageUrl: json['mainImageUrl'],
      amenities: List<String>.from(json['amenities']),
      createdAt: DateTime.parse(json['createdAt']),
      shortDescription: json['shortDescription'],
      priceFormatted: json['priceFormatted'],
      locationShort: json['locationShort'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'type': type,
      'location': location,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'floor': floor,
      'images': images,
      'area': area,
      'furnishStatus': furnishStatus,
      'mainImageUrl': mainImageUrl,
      'amenities': amenities,
      'createdAt': createdAt.toIso8601String(),
      'shortDescription': shortDescription,
      'priceFormatted': priceFormatted,
      'locationShort': locationShort,
    };
  }
}
