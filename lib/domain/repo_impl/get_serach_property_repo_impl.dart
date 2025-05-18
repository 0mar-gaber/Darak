import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/domain/entitys/search_property_response_entity.dart';

import '../../core/reusable_components/filter_model.dart';
import '../../data/data_contract/get_search_property_contract.dart';
import '../repo_contract/get_search_property_repo.dart';

@Injectable(as: GetSearchPropertiesRepo)
class GetSearchPropertiesRepoImpl extends GetSearchPropertiesRepo {

  final GetSearchPropertiesContract contract;

  @factoryMethod
  GetSearchPropertiesRepoImpl(this.contract);

  @override
  Future<
      Either<List<SearchPropertyResponseEntity>, String>> getSearchProperties(
      FilterModel? filter, String searchTerm) async {
    var result = await contract.getSearchProperties(filter, searchTerm);
    return result.fold((response) {
      var properties = response.map((e) =>
          SearchPropertyResponseEntity(
            id: e.id,
            title: e.title,
            locationShort: e.locationShort,
            priceFormatted: e.priceFormatted,
            area: e.area,
            mainImageUrl: e.mainImageUrl,
            price: e.price,
            addressLine1: e.addressLine1,
            addressLine2: e.addressLine2,
            city: e.city,
            governorate: e.governorate,

          )).toList();

      return Left(properties);
    }, (error) => Right(error));
  }
}



