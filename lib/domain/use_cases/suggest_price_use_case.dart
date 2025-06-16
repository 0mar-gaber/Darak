

import 'package:injectable/injectable.dart';
import 'package:real_their/domain/repo_contract/suggest_price_repo.dart';

import '../entitys/property_price_suggest_entity.dart';

@injectable
class SuggestPriceUseCase {
  final SuggestPriceRepo predictPriceRepo;

  @factoryMethod
  SuggestPriceUseCase(this.predictPriceRepo);

   call(PropertyPriceSuggestEntity request) {
    return predictPriceRepo.suggestPrice(request);
  }
}
