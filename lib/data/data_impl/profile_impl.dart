import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/core/api/end_points.dart';
import 'package:real_their/core/local_storage/shared_pref.dart';
import 'package:real_their/data/data_contract/profile_contract.dart';
import 'package:real_their/data/models/user_details_model.dart';

import '../../core/api/api_manger.dart';

@Injectable(as: ProfileContract)
class ProfileImpl extends ProfileContract {
  ApiManager apiManager;

  @factoryMethod
  ProfileImpl(this.apiManager);

  @override
  Future<Either<UserDetailsModel, String>> getUserDetails() async {
    try {
      var response = await apiManager.getRequest(
        endPoint: EndPoint.getUserDetailsEndPoint,
        token: PrefsHelper.getToken(),
      );
      var userDetails = UserDetailsModel.fromJson(response);
      return Left(userDetails);
    } catch (error) {
      return Right(error.toString());
    }
  }

  @override
  Future<Either<String, String>> updateProfile(
    String userName,
    String phoneNumber,
    String gender,
  ) async {
    try {
      var request = await apiManager.putRequest(
        endPoint: EndPoint.updateUserDetailsEndPoint,
        token: PrefsHelper.getToken(),
        body: {
          "bio": userName,
          "governorate": phoneNumber,
          "city": gender
        },
      );
      if (request.statusCode == 200) {
        return Left("updated");
      }
      return Right("error");
    } catch (error) {
      return Right(error.toString());
    }
  }

  @override
  Future<Either<String, String>> uploadProfileImage(XFile imageFile) async {
    try {
      var request = await apiManager.uploadImageWithToken(
        endPoint: EndPoint.uploadPictureEndPoint,
        imageFile: imageFile,
        token: PrefsHelper.getToken(),
      );
      if (request.statusCode == 200) {
        return Left("done");
      }
      return Right("error");
    } catch (error) {
      return Right(error.toString());
    }
  }
}
