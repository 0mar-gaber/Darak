import 'package:dartz/dartz.dart';

import '../entitys/user_entity.dart';

abstract class AuthRepo{
  Future<Either<String,String>> signup(String userEmail, String userPassword,String userPhone);
  Future<Either<UserEntity,String>> login(String userEmail, String userPassword);
  Future<Either<String,String>> forgetPassword(String userPhone);
  Future<Either<String,String>> verifyOtp(String otp,String phoneNumber);
  Future<Either<String,String>> resetPaas(String userPassword,String confirmPassword,);
}