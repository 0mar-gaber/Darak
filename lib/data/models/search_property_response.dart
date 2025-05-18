import 'dart:convert';

class SearchPropertyResponse {
  final String id;
  final String title;
  final String description;
  final String ownerName;
  final String contactInfo;
  final bool isOwner;
  final int price;
  final String type;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String governorate;
  final String postalCode;
  final int bedrooms;
  final int bathrooms;
  final int floor;
  final List<String> images;
  final int area;
  final String furnishStatus;
  final String mainImageUrl;
  final List<String> amenities;
  final DateTime createdAt;
  final String shortDescription;
  final String priceFormatted;
  final String locationShort;

  SearchPropertyResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.ownerName,
    required this.contactInfo,
    required this.isOwner,
    required this.price,
    required this.type,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.governorate,
    required this.postalCode,
    required this.bedrooms,
    required this.bathrooms,
    required this.floor,
    required this.images,
    required this.area,
    required this.furnishStatus,
    required this.mainImageUrl,
    required this.amenities,
    required this.createdAt,
    required this.shortDescription,
    required this.priceFormatted,
    required this.locationShort,
  });

  factory SearchPropertyResponse.fromJson(Map<String, dynamic> json) {
    return SearchPropertyResponse(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      ownerName: json['ownerName'],
      contactInfo: json['contactInfo'],
      isOwner: json['isOwner'],
      price: (json['price'] as num).toInt(),
      type: json['type'],
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      city: json['city'],
      governorate: json['governorate'],
      postalCode: json['postalCode'].toString(),
      bedrooms: (json['bedrooms'] as num).toInt(),
      bathrooms: (json['bathrooms'] as num).toInt(),
      floor: (json['floor'] as num).toInt(),
      images: List<String>.from(json['images']),
      area: (json['area'] as num).toInt(),
      furnishStatus: json['furnishStatus'],
      mainImageUrl: json['mainImageUrl'],
      amenities: List<String>.from(json['amenities']),
      createdAt: DateTime.parse(json['createdAt']),
      shortDescription: json['shortDescription'],
      priceFormatted: json['priceFormatted'],
      locationShort: json['locationShort'],
    );
  }

  // دالة لتحويل قائمة من JSON إلى قائمة من الكائنات
  static List<SearchPropertyResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => SearchPropertyResponse.fromJson(json))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'ownerName': ownerName,
      'contactInfo': contactInfo,
      'isOwner': isOwner,
      'price': price,
      'type': type,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'governorate': governorate,
      'postalCode': postalCode,
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

  @override
  String toString() => jsonEncode(toJson());
}
