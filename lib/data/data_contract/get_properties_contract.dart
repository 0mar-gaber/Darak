import 'package:dartz/dartz.dart';

import '../models/property_model.dart';
import '../models/property_response.dart';

abstract class GetPropertiesContract {
  Future<Either<PropertyResponse, String>> getProperties();
  Future<Either<List<PropertyModel>, String>> getNearMeProperties();
  Future<Either<PropertyModel, String>> getPropertiesById(String id);
}
