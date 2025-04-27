import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entitys/user_entity.dart';
import '../repo_contract/auth_repo.dart';
@injectable
class AuthUseCase {
  AuthRepo authRepo ;
  @factoryMethod
  AuthUseCase(this.authRepo);
  Future<Either<String,String>> callSignup(String userEmail, String userPassword,String userPhone) {
    return authRepo.signup( userEmail, userPassword,userPhone);
  }
  Future<Either<UserEntity,String>> callLogin(String userEmail, String userPassword) {
    return authRepo.login( userEmail,userPassword);
  }
  Future<Either<String,String>> callForgetPassword(String userPhone){
    return authRepo.forgetPassword(userPhone);

  }
    
  Future<Either<String,String>> callVerifyOtp(String otp,String phoneNumber){
    return authRepo.verifyOtp(otp,phoneNumber);

  }
  Future<Either<String,String>> callResetPaas(String userPassword,String confirmPassword,){
    return authRepo.resetPaas(userPassword, confirmPassword);

  }
}
  
  