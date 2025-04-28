import 'package:dartz/dartz.dart';

import '../models/property_response.dart';

abstract class GetPropertiesContract {
  Future<Either<PropertyResponse, String>> getProperties();
}
