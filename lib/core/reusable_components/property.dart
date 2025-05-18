import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Property {
  String title;
  String description;
  double price;
  String addressLine1;
  String? addressLine2;
  String city;
  String governorate;
  String? postalCode;
  int? bedrooms;
  int? bathrooms;
  double? area;
  String yourName;
  String mobilePhone;
  String furnishStatus;
  List<String>? amenities;
  int? floor;
  String type;
  List<XFile>? files;

  Property({
    required this.title,
    required this.description,
    required this.price,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.governorate,
    this.postalCode,
    this.bedrooms,
    this.bathrooms,
    this.area,
    required this.yourName,
    required this.mobilePhone,
    required this.furnishStatus,
    this.amenities,
    this.floor,
    required this.type,
    this.files,
  });

  @override
  String toString() {
    return '''
Property Details:
- Title: $title
- Description: $description
- Price: \$$price
- City: $city
- Address Line 1: $addressLine1
- Address Line 2: $addressLine2
- Governorate: $governorate
- Postal Code: $postalCode
- Contact Name: $yourName
- Mobile Phone: $mobilePhone
- Furnish Status: $furnishStatus
- Property Type: $type
- Area: ${area}m²
- Bedrooms: $bedrooms
- Bathrooms: $bathrooms
- Amenities: ${amenities?.join(', ')}
- Floor: $floor
- Images Count: ${files?.length}
''';
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "price": price,
      "addressLine1": addressLine1,
      "addressLine2": addressLine2,
      "city": city,
      "governorate": governorate,
      "postalCode": postalCode,
      "bedrooms": bedrooms,
      "bathrooms": bathrooms,
      "area": area,
      "yourName": yourName,
      "mobilePhone": mobilePhone,
      "furnishStatus": furnishStatus,
      "amenities": amenities,
      "floor": floor,
      "type": type,
    };
  }
}
