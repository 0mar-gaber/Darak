import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Property {
  String title;
  String description;
  double price;
  String location;
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
    required this.location,
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

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "price": price,
      "location": location,
      "bedrooms": bedrooms,
      "bathrooms": bathrooms,
      "area": area,
      "yourName": yourName,
      "mobilePhone": mobilePhone,
      "furnishStatus": furnishStatus,
      "amenities": amenities,
      "floor": floor,
      "type": type,
      "files": files,
    };
  }
}
