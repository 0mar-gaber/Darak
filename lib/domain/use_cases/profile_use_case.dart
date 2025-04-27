import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/domain/entitys/user_details_entity.dart';
import 'package:real_their/domain/repo_contract/profile_repo_contract.dart';

import '../repo_contract/auth_repo.dart';
@injectable
class ProfileUseCase {
  ProfileRepoContract profileRepoContract ;
  @factoryMethod
  ProfileUseCase(this.profileRepoContract);
  Future<Either<UserDetailsEntity,String>> callGetUserDetails() {
    return profileRepoContract.getUserDetails();
  }
  Future<Either<String,String>> callUpdateProfile(String userName, String phoneNumber, String gender) {
    return profileRepoContract.updateProfile(userName, phoneNumber, gender);
  }
  Future<Either<String,String>> callUploadImage(XFile imageFile) {
    return profileRepoContract.uploadProfileImage(imageFile);
  }


}

