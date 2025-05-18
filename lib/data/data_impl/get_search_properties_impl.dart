import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/core/api/end_points.dart';
import 'package:real_their/core/reusable_components/filter_model.dart';

import '../../core/api/api_manger.dart';
import '../data_contract/get_search_property_contract.dart';
import '../models/search_property_response.dart';

@Injectable(as: GetSearchPropertiesContract)
class GetSearchPropertiesImpl extends GetSearchPropertiesContract {
  final ApiManager apiManager;

  @factoryMethod
  GetSearchPropertiesImpl(this.apiManager);

  @override
  Future<Either<List<SearchPropertyResponse>, String>> getSearchProperties(
    FilterModel? filter,
    String searchTerm,
  ) async {
    try {

      var response = await apiManager.getRequest(
        endPoint: EndPoint.getAllSearchProperty,
        queryParameters: {
          'searchTerm': searchTerm,
          'location': filter?.city,
          'minPrice': filter?.minPrice,
          'maxPrice': filter?.maxPrice,
          'minSize': filter?.minArea,
          'maxSize': filter?.maxArea,
          'bedrooms': filter?.rooms,
          'bathrooms': filter?.bathrooms,
          'furnishingStatus': filter?.furnished,
          'type':filter?.propertyType
        },
      );



      var properties = SearchPropertyResponse.fromJsonList(response);

      return Left(properties);
    } catch (error) {
      return Right(error.toString());
    }
  }
}
