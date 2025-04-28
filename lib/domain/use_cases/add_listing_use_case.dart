import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/core/reusable_components/property.dart';
import 'package:real_their/domain/repo_contract/add_listing_repo.dart';

@injectable
class AddListingUseCase {
  AddListingRepo addListingRepo ;
  @factoryMethod
  AddListingUseCase(this.addListingRepo);
  call(Property property,List<XFile>? images){
    return addListingRepo.addListing(property,images);

  }
}