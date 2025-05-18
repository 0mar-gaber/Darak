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
        // body: {
        //   "title": "Nice Apartment in Nasr City",
        //   "description": "Spacious 3-bedroom apartment near City Stars.",
        //   "price": 1500000,
        //   "addressLine1": "15 Abbas El Akkad",
        //   "addressLine2": "Building 4",
        //   "city": "Cairo",
        //   "governorate": "Cairo",
        //   "postalCode": "11371",
        //   "bedrooms": 3,
        //   "bathrooms": 2,
        //   "area": 180,
        //   "yourName": "Omar Gaber",
        //   "mobilePhone": "01012345678",
        //   "furnishStatus": "Furnished", // أو "Unfurnished"
        //   "amenities": ["AC", "Elevator", "Balcony"], // Array
        //   "floor": 5,
        //   "type": "Apartment", // أو "Villa" أو حسب القيم المتاحة
        //   "files": [], // لو هتبعت صور، استخدم MultipartFile هنا
        // },
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
