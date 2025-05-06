import 'package:dartz/dartz.dart';

import '../models/favourite_property_model.dart';

abstract class AddToFavouriteContract {
  Future<Either<String, String>> addToFavourite({
    required String userId,
    required String propertyId,
  });
  Future<Either<List<FavouriteModel>, String>> getFavourites(String userId);
  Future<Either<String, String>> removeFavourite({
    required String userId,
    required String propertyId,
  });

}
