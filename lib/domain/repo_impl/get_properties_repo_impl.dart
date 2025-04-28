import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/data/data_contract/get_properties_contract.dart';
import 'package:real_their/domain/entitys/property_response_entity.dart';
import 'package:real_their/domain/repo_contract/get_properties_repo.dart';

@Injectable(as: GetPropertiesRepo)
class GetPropertiesRepoImpl extends GetPropertiesRepo {
  final GetPropertiesContract contract;

  @factoryMethod
  GetPropertiesRepoImpl(this.contract);

  @override
  Future<Either<PropertyResponseEntity, String>> getProperties() async {
    var result = await contract.getProperties();
    return result.fold((response) {
      var recommended = response.recommendedProperties.map((e) => PropertyItemEntity(
        id: e.id,
        title: e.title,
        location: e.location,
        priceFormatted: e.priceFormatted,
        areaFormatted: e.areaFormatted,
        imageUrl: e.imageUrl,
      )).toList();

      var all = response.allProperties.map((e) => PropertyItemEntity(
        id: e.id,
        title: e.title,
        location: e.location,
        priceFormatted: e.priceFormatted,
        areaFormatted: e.areaFormatted,
        imageUrl: e.imageUrl,
      )).toList();

      return Left(PropertyResponseEntity(
        recommendedProperties: recommended,
        allProperties: all,
      ));
    }, (error) => Right(error));
  }
}
