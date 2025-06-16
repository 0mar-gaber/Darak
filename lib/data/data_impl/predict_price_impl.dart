import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/core/api/api_manger.dart';
import 'package:real_their/core/api/end_points.dart';
import 'package:real_their/data/models/price_prediction_response.dart';
import 'package:real_their/data/data_contract/predict_price_contract.dart';

import '../models/property_request_model.dart';

@Injectable(as: PredictPriceContract)
class PredictPriceImpl extends PredictPriceContract {
  final ApiManager apiManager;

  @factoryMethod
  PredictPriceImpl(this.apiManager);

  @override
  Future<Either<PricePredictionResponse, String>> predictPrice(PropertyRequest request) async {
    try {
      final response = await apiManager.postRequest(
        endPoint: EndPoint.predictPriceEndPoint,
        body: request.toJson(),
        baseUrl: "https://omaar.pythonanywhere.com"
      );

      final prediction = PricePredictionResponse.fromJson(response.data);
      return Left(prediction);
    } catch (error) {
      return Right(error.toString());
    }
  }

}
