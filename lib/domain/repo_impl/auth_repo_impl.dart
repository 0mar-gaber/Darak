import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../data/data_contract/auth_contract.dart';
import '../entitys/user_entity.dart';
import '../repo_contract/auth_repo.dart';
@Injectable(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  AuthContract contract ;
  @factoryMethod
  AuthRepoImpl(this.contract);
  @override
  Future<Either<UserEntity, String>> login(String userEmail, String userPassword) async {
    var result = await contract.login(userEmail, userPassword);
    return result.fold(
            (response) {
              UserEntity entity = UserEntity(
                email: response.email,
                token: response.token,
                userId: response.userId,
                message: response.message,
              );
              return Left(entity);
            },
            (error) => Right(error)
    );
  }

  @override
  Future<Either<String, String>> signup(String userEmail, String userPassword, String userPhone) async {

    var result = await contract.signup(userEmail, userPassword,userPhone);
    return result.fold(
            (response) => Left(response),
            (error) => Right(error),
    );
  }

  @override
  Future<Either<String, String>> forgetPassword(String userPhone) async {
    var result = await contract.forgetPassword(userPhone);
    return result.fold(
          (response) => Left(response),
          (error) => Right(error),
    );
  }

  @override
  Future<Either<String, String>> resetPaas(String userPassword, String confirmPassword) async {
    var result = await contract.resetPaas(userPassword, confirmPassword);
    return result.fold(
          (response) => Left(response),
          (error) => Right(error),
    );
  }

  @override
  Future<Either<String, String>> verifyOtp(String otp,String phoneNumber) async {
    var result = await contract.verifyOtp(otp,phoneNumber);
    return result.fold(
          (response) => Left(response),
          (error) => Right(error),
    );
  }
  
}