import 'package:dartz/dartz.dart';
import '../models/price_prediction_response.dart';
import '../models/property_request_model.dart';

abstract class PredictPriceContract {
  Future<Either<PricePredictionResponse, String>> predictPrice(PropertyRequest request);
}
