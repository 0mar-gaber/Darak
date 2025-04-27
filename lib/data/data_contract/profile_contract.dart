
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user_details_model.dart';

abstract class ProfileContract{
  Future<Either<UserDetailsModel,String>>getUserDetails();
  Future<Either<String,String>>updateProfile(String userName,String phoneNumber,String gender);
  Future<Either<String, String>> uploadProfileImage(XFile imageFile);


}