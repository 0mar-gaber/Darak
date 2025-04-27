
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_their/domain/entitys/user_details_entity.dart';


abstract class ProfileRepoContract{
  Future<Either<UserDetailsEntity,String>>getUserDetails();
  Future<Either<String,String>>updateProfile(String userName,String phoneNumber,String gender);
  Future<Either<String, String>> uploadProfileImage(XFile imageFile);
}