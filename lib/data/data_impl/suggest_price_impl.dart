
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/core/api/api_manger.dart';
import 'package:real_their/data/models/analysis_response_model.dart';
import 'package:real_their/data/models/property_price_suggest_model.dart';

import '../../core/api/end_points.dart';
import '../data_contract/suggest_price_contract.dart';

@Injectable(as: SuggestPriceContract)
class SuggestPriceImpl extends  SuggestPriceContract {
  final ApiManager apiManager;

  @factoryMethod
  SuggestPriceImpl(this.apiManager);

  @override
  Future<Either<AnalysisResponse, String>> suggestPrice(PropertyPriceSuggestModel request) async {
    try{
      final response = await apiManager.postRequest(
          endPoint: EndPoint.suggestPriceEndPoint,
          body: {
            "Area (sqm)": request.areaSqm,
            "Property Type": request.propertyType,
            "Bedrooms": request.bedrooms,
            "Bathrooms": request.bathrooms,
            "Building Age (years)": 5,
            "Floor Level": request.floorLevel,
            "Location": request.location,
            "Price": request.price
          },
          baseUrl: "https://omargaber.pythonanywhere.com"
      );
      print(response.statusCode);
      print(request.toJson());
      final suggestion = AnalysisResponse.fromJson(response.data);

      return Left(suggestion);


    }catch(error){

      return Right(error.toString());
    }
  }

}