import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/data/data_contract/get_properties_contract.dart';
import 'package:real_their/domain/entitys/property_entity.dart';
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

  @override
  Future<Either<List<PropertyEntity>, String>> getNearMeProperties() async {
    var result = await contract.getNearMeProperties();

    return result.fold((response) {
      var properties = response.map((e) => PropertyEntity(
        id: e.id,
        title: e.title,
        description: e.description,
        ownerName: e.ownerName,
        contactInfo: e.contactInfo,
        isOwner: e.isOwner,
        price: e.price,
        type: e.type,
        addressLine1: e.addressLine1,
        addressLine2: e.addressLine2,
        city: e.city,
        governorate: e.governorate,
        postalCode: e.postalCode,
        bedrooms: e.bedrooms,
        bathrooms: e.bathrooms,
        floor: e.floor,
        images: e.images,
        area: e.area,
        furnishStatus: e.furnishStatus,
        mainImageUrl: e.mainImageUrl,
        amenities: e.amenities,
        createdAt: e.createdAt,
        shortDescription: e.shortDescription,
        priceFormatted: e.priceFormatted,
        locationShort: e.locationShort,
      )).toList();

      return Left(properties);
    }, (error) => Right(error));
  }



}
