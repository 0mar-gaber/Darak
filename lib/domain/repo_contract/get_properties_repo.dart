import 'package:dartz/dartz.dart';
import 'package:real_their/domain/entitys/property_response_entity.dart';

abstract class GetPropertiesRepo {
  Future<Either<PropertyResponseEntity, String>> getProperties();
}
