import 'package:dartz/dartz.dart';

import '../models/user_model.dart';

abstract class AuthContract{
  Future<Either<String,String>> signup(String userEmail, String userPassword,String userPhone);
  Future<Either<UserModel,String>> login(String userEmail, String userPassword);
  Future<Either<String,String>> forgetPassword(String userPhone);
  Future<Either<String,String>> verifyOtp(String otp,String phoneNumber);
  Future<Either<String,String>> resetPaas(String userPassword,String confirmPassword,);
}