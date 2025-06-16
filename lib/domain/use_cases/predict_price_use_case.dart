import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

import '../entitys/price_prediction_response_entity.dart';
import '../entitys/property_request_entity.dart';
import '../repo_contract/predict_price_repo_contract.dart';

@injectable
class PredictPriceUseCase {
  final PredictPriceRepo predictPriceRepo;

  @factoryMethod
  PredictPriceUseCase(this.predictPriceRepo);

  Future<Either<PricePredictionResponseEntity, String>> call(PropertyRequestEntity request) {
    return predictPriceRepo.predictPrice(request);
  }
}
