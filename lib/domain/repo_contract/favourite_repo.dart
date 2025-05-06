import 'package:dartz/dartz.dart';

import '../entitys/favourite_entity.dart';

abstract class AddToFavouriteRepo {
  Future<Either<String, String>> addToFavourite(String userId, String propertyId);
  Future<Either<List<FavouriteEntity>, String>> getFavourites(String userId);
  Future<Either<String, String>> removeFavourite(String userId, String propertyId);
}
