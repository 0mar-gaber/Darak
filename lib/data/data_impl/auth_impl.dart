import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/core/local_storage/shared_pref.dart';

import '../../core/api/api_manger.dart';
import '../../core/api/end_points.dart';
import '../data_contract/auth_contract.dart';
import '../models/user_model.dart';

@Injectable(as: AuthContract)
class AuthImpl extends AuthContract {
  ApiManager apiManager;

  @factoryMethod
  AuthImpl(this.apiManager);

  @override
  Future<Either<UserModel, String>> login(String userEmail, String userPassword) async {
    try {

      var request = await  apiManager.postRequest(endPoint: EndPoint.logInEndPoint
          ,body: {
            "email": userEmail,
            "password": userPassword
          }
      );
      var logInResponse = UserModel.fromJson(request.data);

      if(logInResponse.message=="Success"){
        return Left(logInResponse);
      }else{
        return Right(request.statusCode.toString());
      }

    } catch (error) {
      return Right(error.toString());

    }
  }

  @override
  Future<Either<String, String>> signup(String userEmail, String userPassword, String userPhone) async {
    try {
        var request = await  apiManager.postRequest(endPoint: EndPoint.signUpEndPoint
          ,body: {
          "Email": userEmail,
              "Password": userPassword,
              "ConfirmPassword": userPassword,
              "PhoneNumber":userPhone
          },
          isFormData: true
      );
      if(request.statusCode==200){
        return Left("success");
      }else{
        return Right("failed");
      }

    } catch (error) {
      return Right(error.toString());

    }
  }

  @override
  Future<Either<String, String>> forgetPassword(String userPhone) async {
   try{
     var request = await apiManager.postRequest(endPoint: EndPoint.forgetPasswordEndPoint,
         body: {
           "phoneNumber": userPhone
         }
     );
     if(request.statusCode==200){
       return Left("success");
     }else {
       return Right("failed");
     }
   }catch(error){
     return Right(error.toString());
   }
  }

  @override
  Future<Either<String, String>> resetPaas(String userPassword, String confirmPassword) async {
    try{
      var request = await apiManager.postRequest(endPoint: EndPoint.resetPasswordEndPoint,
          body:{
            "phoneNumber": PrefsHelper.getPhoneNumber(),
            "newPassword": userPassword,
            "confirmPassword": confirmPassword,
            "otp": "1234"
          }
      );
      if(request.statusCode==200){
        return Left("success");
      }else {
        print("==========================================================");
        print(PrefsHelper.getPhoneNumber());
        return Right("failed");
      }
    }catch(error){
      return Right(error.toString());
    }
  }

  @override
  Future<Either<String, String>> verifyOtp(String otp,String phoneNumber) async {
    try{
      var request = await apiManager.postRequest(endPoint: EndPoint.verifyOtpEndPoint,
          body:{
            "phoneNumber": phoneNumber,
            "otp": otp
          }
      );

      if(request.statusCode==200){
        return Left("success");
      }else {
        return Right("failed");
      }
    }catch(error){
      return Right(error.toString());
    }
  }
  
  
}