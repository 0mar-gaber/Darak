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
  Future<Either<String, String>> addListing(Property property ,List<XFile>? images) async {
    var result = await contract.addListing(property,images);
    return result.fold((response) {
      return Left("done");
    }, (error) => Right(error));
  }
}
