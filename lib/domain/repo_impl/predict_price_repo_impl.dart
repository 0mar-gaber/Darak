import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/data/data_contract/predict_price_contract.dart';
import 'package:real_their/data/models/property_request_model.dart';

import '../entitys/price_prediction_response_entity.dart';
import '../entitys/property_request_entity.dart';
import '../repo_contract/predict_price_repo_contract.dart';


@Injectable(as: PredictPriceRepo)
class PredictPriceRepoImpl extends PredictPriceRepo {
  final PredictPriceContract contract;

  @factoryMethod
  PredictPriceRepoImpl(this.contract);

  @override
  Future<Either<PricePredictionResponseEntity, String>> predictPrice(PropertyRequestEntity request) async {
    PropertyRequest propertyRequest = PropertyRequest(
      amenities: request.amenities,
      propertyType: request.propertyType,
      nearbyFacility: request.nearbyFacility,
      area: request.area,
      bathrooms: request.bathrooms,
      bedrooms: request.bedrooms,
    );
    final result = await contract.predictPrice(propertyRequest);


    return result.fold(
          (response) {
            PricePredictionResponseEntity predictionResponseEntity = PricePredictionResponseEntity(predictedPrice2026: response.predictedPrice2026);
            return Left(predictionResponseEntity);
          },
          (error) => Right(error),
    );
  }
}
