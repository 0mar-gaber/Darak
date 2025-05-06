import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/core/api/api_manger.dart';
import 'package:real_their/core/api/end_points.dart';
import 'package:real_their/core/local_storage/shared_pref.dart';

import '../data_contract/favourite_contract.dart';
import '../models/favourite_property_model.dart';

@Injectable(as: AddToFavouriteContract)
class AddToFavouriteImpl extends AddToFavouriteContract {
  ApiManager apiManager;

  @factoryMethod
  AddToFavouriteImpl(this.apiManager);

  @override
  Future<Either<String, String>> addToFavourite({
    required String userId,
    required String propertyId,
  }) async {
    try {
      var response = await apiManager.postRequest(
        endPoint: EndPoint.addFavouriteEndPoint,
        body: {
          'userId': userId,
          'propertyId': propertyId,
        },
        token: PrefsHelper.getToken(),
      );

      if (response.statusCode == 200) {
        return const Left("done"); // Success
      } else {
        return Right('Error: ${response.statusCode}');
      }
    } catch (e) {
      return Right('Exception: ${e.toString()}');
    }
  }
  @override
  Future<Either<List<FavouriteModel>, String>> getFavourites(String userId) async {
    try {
      var response = await apiManager.getRequest(
        endPoint: '${EndPoint.getFavouritesEndPoint}/$userId',
        token: PrefsHelper.getToken(),
      );

      // هنا تأكد إنك بتتعامل مع response.data
      if (response is List) {
        List<FavouriteModel> favourites = response.map((e) => FavouriteModel.fromJson(e)).toList();
        return Left(favourites);
      } else {
        return Right("Unexpected data format");
      }
    } catch (e) {
      return Right(e.toString());
    }
  }
  @override
  Future<Either<String, String>> removeFavourite({
    required String userId,
    required String propertyId,
  }) async {
    try {
      var response = await apiManager.deleteRequest(
        endPoint: '${EndPoint.removeFavouriteEndPoint}/$userId/$propertyId',
        token: PrefsHelper.getToken(),
      );

      if (response.statusCode == 200) {
        return const Left("done");
      } else {
        return Right("Error: ${response.statusCode}");
      }
    } catch (e) {
      return Right(e.toString());
    }
  }
}
