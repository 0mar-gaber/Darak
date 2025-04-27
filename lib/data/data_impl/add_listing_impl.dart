import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/core/api/end_points.dart';
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
  Future<Either<PropertyModel, String>> addListing(Property pr) async {
   try{
     var request = await apiManager.postRequest(
       endPoint: EndPoint.addPropertyEndPoint,
       body: pr.toMap(),
       isFormData: true,
     );

     var property = PropertyModel.fromJson(request.data);
     if(request.statusCode==200){
       return Left(property);
     }

     return Right("error statusCode != 200");

   }catch(error){
     return Right(error.toString());
   }


  }
}
