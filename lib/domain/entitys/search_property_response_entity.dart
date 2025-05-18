import 'dart:convert';

class SearchPropertyResponseEntity {
  final String id;
  final String title;
  final int price;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String governorate;
  final int area;
  final String mainImageUrl;
  final String priceFormatted;
  final String locationShort;

  SearchPropertyResponseEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.governorate,
    required this.area,
    required this.mainImageUrl,
    required this.priceFormatted,
    required this.locationShort,
  });

  factory SearchPropertyResponseEntity.fromJson(Map<String, dynamic> json) {
    return SearchPropertyResponseEntity(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      city: json['city'],
      governorate: json['governorate'],
      area: json['area'],
      mainImageUrl: json['mainImageUrl'],
      priceFormatted: json['priceFormatted'],
      locationShort: json['locationShort'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'governorate': governorate,
      'area': area,
      'mainImageUrl': mainImageUrl,
      'priceFormatted': priceFormatted,
      'locationShort': locationShort,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
