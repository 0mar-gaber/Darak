import 'package:dartz/dartz.dart';
import 'package:real_their/domain/entitys/price_prediction_response_entity.dart';
import 'package:real_their/domain/entitys/property_request_entity.dart';

abstract class PredictPriceRepo {
  Future<Either<PricePredictionResponseEntity, String>> predictPrice(PropertyRequestEntity request);
}
