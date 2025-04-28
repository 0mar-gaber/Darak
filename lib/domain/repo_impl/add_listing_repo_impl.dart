import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/core/reusable_components/property.dart';
import 'package:real_their/data/data_contract/add_listing_contract.dart';
import 'package:real_their/domain/entitys/property_entity.dart';
import 'package:real_their/domain/repo_contract/add_listing_repo.dart';

@Injectable(as: AddListingRepo)
class AddListingRepoImpl extends AddListingRepo {
  AddListingContract contract;

  @factoryMethod
  AddListingRepoImpl(this.contract);

  @override
  Future<Either<PropertyEntity, String>> addListing(Property property ,List<XFile>? images) async {
    var result = await contract.addListing(property,images);
    return result.fold((response) {
      PropertyEntity pro = PropertyEntity(
        id: response.id,
        title: response.title,
        description: response.description,
        price: response.price,
        type: response.type,
        location: response.location,
        bedrooms: response.bedrooms,
        bathrooms: response.bathrooms,
        floor: response.floor,
        images: response.images,
        area: response.area,
        furnishStatus: response.furnishStatus,
        amenities: response.amenities,
        shortDescription: response.shortDescription,
        priceFormatted: response.priceFormatted,
        locationShort: response.locationShort,
      );
      return Left(pro);
    }, (error) => Right(error));
  }
}
