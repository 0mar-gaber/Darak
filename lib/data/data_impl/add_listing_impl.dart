import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/core/api/end_points.dart';
import 'package:real_their/core/local_storage/shared_pref.dart';
import 'package:real_their/data/data_contract/add_listing_contract.dart';
import 'package:real_their/data/models/property_model.dart';

import '../../core/api/api_manger.dart';
import '../../core/reusable_components/property.dart';

@Injectable(as: AddListingContract)
class AddListingImpl extends AddListingContract {
  ApiManager apiManager;

  @factoryMethod
  AddListingImpl(this.apiManager);

  @override
  Future<Either<String, String>> addListing(
    Property pr,
    List<XFile>? images,
  ) async {
    try {
      var request = await apiManager.postRequest(
        endPoint: EndPoint.addPropertyEndPoint,
        body: pr.toMap(),
        
        isFormData: true,
        images: pr.files,
        token: PrefsHelper.getToken(),
      );

      if (request.statusCode == 200) {
        return Left("done");
      }

      return Right("error statusCode != 200");
    } catch (error) {
      return Right(error.toString());
    }
  }
}
