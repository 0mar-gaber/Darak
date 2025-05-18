import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_their/core/reusable_components/property.dart';
import 'package:real_their/domain/entitys/property_entity.dart';

abstract class AddListingRepo{
  Future<Either<String,String>> addListing(Property property,List<XFile>? images);
}