import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/core/api/end_points.dart';
import 'package:real_their/core/local_storage/shared_pref.dart';
import 'package:real_their/data/data_contract/add_listing_contract.dart';

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
        body: {
          "PropertyJson": jsonEncode({
            "title": pr.type,
            "description": pr.description,
            "price": pr.price,
            "addressLine1": pr.addressLine1,
            "addressLine2": pr.addressLine2,
            "city": pr.city,
            "governorate": pr.governorate,
            "nearbyFacility": "Metro station",
            "postalCode": pr.postalCode,
            "bedrooms": pr.bedrooms,
            "bathrooms": pr.bathrooms,
            "floor": pr.floor,
            "area": pr.area,
            "yourName": pr.yourName,
            "mobilePhone": pr.mobilePhone,
            "furnishStatus": pr.furnishStatus,
            "amenities": pr.amenities,
            "type": pr.type
          }),
          "files" : images
        },
        isFormData: true,
        images: images,
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
