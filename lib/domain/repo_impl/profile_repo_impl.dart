import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/data/data_contract/profile_contract.dart';
import 'package:real_their/domain/entitys/user_details_entity.dart';
import 'package:real_their/domain/repo_contract/profile_repo_contract.dart';

@Injectable(as: ProfileRepoContract)
class ProfileRepoImpl extends ProfileRepoContract {
  ProfileContract profileContract;

  @factoryMethod
  ProfileRepoImpl(this.profileContract);

  @override
  Future<Either<UserDetailsEntity, String>> getUserDetails() async {
    var result = await profileContract.getUserDetails();
    return result.fold((response) {
      var userDetails = UserDetailsEntity(
        id: response.id,
        userName: response.bio,
        email: response.email,
        governorate: response.governorate,
        city: response.city,
        profilePictureUrl: response.profilePictureUrl,
      );

      return Left(userDetails);
    }, (error) => Right(error));
  }

  @override
  Future<Either<String, String>> updateProfile(String userName, String phoneNumber, String gender) async {
    var result = await profileContract.updateProfile(userName,phoneNumber,gender);
    return result.fold(
          (response) => Left(response),
          (error) => Right(error),
    );
  }

  @override
  Future<Either<String, String>> uploadProfileImage(XFile imageFile) async {
    var result = await profileContract.uploadProfileImage(imageFile);
    return result.fold(
          (response) => Left(response),
          (error) => Right(error),
    );
  }
}
