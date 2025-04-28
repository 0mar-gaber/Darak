import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/core/api/end_points.dart';
import 'package:real_their/core/local_storage/shared_pref.dart';
import 'package:real_their/data/data_contract/get_properties_contract.dart';

import '../../core/api/api_manger.dart';
import '../models/property_response.dart';

@Injectable(as: GetPropertiesContract)
class GetPropertiesImpl extends GetPropertiesContract {
  final ApiManager apiManager;

  @factoryMethod
  GetPropertiesImpl(this.apiManager);

  @override
  Future<Either<PropertyResponse, String>> getProperties() async {
    try {
      var response = await apiManager.getRequest(
        endPoint: EndPoint.getPropertiesEndPoint,
        token: PrefsHelper.getToken(),
      );

      var properties = PropertyResponse.fromJson(response);

        return Left(properties);

    } catch (error) {
      return Right(error.toString());
    }
  }
}
