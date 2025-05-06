import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/domain/repo_contract/favourite_repo.dart';

import '../../data/data_contract/favourite_contract.dart';
import '../entitys/favourite_entity.dart';

@Injectable(as: AddToFavouriteRepo)
class AddToFavouriteRepoImpl extends AddToFavouriteRepo {
  final AddToFavouriteContract contract;

  @factoryMethod
  AddToFavouriteRepoImpl(this.contract);

  @override
  Future<Either<String, String>> addToFavourite(String userId, String propertyId) {
    return contract.addToFavourite(userId: userId, propertyId: propertyId);
  }

  @override
  Future<Either<List<FavouriteEntity>, String>> getFavourites(String userId) async {
    var result = await contract.getFavourites(userId);
    return result.fold(
          (models) => Left(models.map((e) => FavouriteEntity(
        userId: e.userId,
        propertyId: e.propertyId,
        title: e.title,
        address: e.address,
        price: e.price,
        formattedPrice: e.formattedPrice,
        area: e.area,
        mainImageUrl: e.mainImageUrl,
      )).toList()),
          (error) => Right(error),
    );
  }

  @override
  Future<Either<String, String>> removeFavourite(String userId, String propertyId) {
    return contract.removeFavourite(userId: userId, propertyId: propertyId);
  }
}
