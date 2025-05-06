import 'package:injectable/injectable.dart';
import 'package:real_their/domain/repo_contract/favourite_repo.dart';

@injectable
class FavouriteUseCase {
  final AddToFavouriteRepo repo;

  @factoryMethod
  FavouriteUseCase(this.repo);

  Future add(String userId, String propertyId) {
    return repo.addToFavourite(userId, propertyId);
  }

  Future get(String userId) {
    return repo.getFavourites(userId);
  }

  Future remove(String userId, String propertyId) {
    return repo.removeFavourite(userId, propertyId);
  }

}
