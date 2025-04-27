import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entitys/user_entity.dart';
import '../../../domain/use_cases/auth_use_case.dart';
@injectable

class AuthViewModel extends Cubit<AuthViewModelState>{

  AuthUseCase useCase ;

  @factoryMethod
  AuthViewModel(this.useCase):super(AuthViewModelInitState());
  static AuthViewModel get(BuildContext context)=>BlocProvider.of(context);


  signup(String userEmail, String userPassword,String userPhone) async {
    emit(SignupViewModelLoadingState());
    var request = await useCase.callSignup( userEmail, userPassword, userPhone);

    request.fold(
            (response) => emit(SignupViewModelSuccessState(response)),
            (error) => emit(SignupViewModelErrorState(error))
    );
  }


  login(String userEmail, String userPassword) async{
    emit(LoginViewModelLoadingState());
    var request = await useCase.callLogin( userEmail, userPassword);

    request.fold(
            (response) => emit(LoginViewModelSuccessState(response)),
            (error) => emit(LoginViewModelErrorState(error))
    );
  }

  forgotPassword(String userPhone) async {
    emit(ForgotPasswordViewModelLoadingState());
    var request = await useCase.callForgetPassword(userPhone);

    request.fold(
            (response) => emit(ForgotPasswordViewModelSuccessState(response)),
            (error) => emit(ForgotPasswordViewModelErrorState(error))
    );
  }

  verifyOtp(String otp,String phoneNumber) async {
    emit(VerifyOtpViewModelLoadingState());
    var request = await useCase.callVerifyOtp(otp,phoneNumber);

    request.fold(
            (response) => emit(VerifyOtpViewModelSuccessState(response)),
            (error) => emit(VerifyOtpViewModelErrorState(error))
    );
  }

  resetPassword(String userPassword, String confirmPassword) async {
    emit(ResetPasswordViewModelLoadingState());
    var request = await useCase.callResetPaas(userPassword, confirmPassword);

    request.fold(
            (response) => emit(ResetPasswordViewModelSuccessState(response)),
            (error) => emit(ResetPasswordViewModelErrorState(error))
    );
  }


}



abstract class AuthViewModelState {}


class AuthViewModelInitState extends AuthViewModelState {}


class SignupViewModelLoadingState extends AuthViewModelState {}


class SignupViewModelErrorState extends AuthViewModelState {
  String ? errorMessage ;
  SignupViewModelErrorState(this.errorMessage);
}


class SignupViewModelSuccessState extends AuthViewModelState {
  String? statusCode ;
  SignupViewModelSuccessState(this.statusCode);
}

class LoginViewModelLoadingState extends AuthViewModelState {}

class LoginViewModelErrorState extends AuthViewModelState {
  String ? errorMessage ;
  LoginViewModelErrorState(this.errorMessage);
}

class LoginViewModelSuccessState extends AuthViewModelState {
  UserEntity? userEntity ;
  LoginViewModelSuccessState(this.userEntity);
}



class ForgotPasswordViewModelLoadingState extends AuthViewModelState {}


class ForgotPasswordViewModelErrorState extends AuthViewModelState {
  String ? errorMessage ;
  ForgotPasswordViewModelErrorState(this.errorMessage);
}


class ForgotPasswordViewModelSuccessState extends AuthViewModelState {
  String? statusCode ;
  ForgotPasswordViewModelSuccessState(this.statusCode);
}





class VerifyOtpViewModelLoadingState extends AuthViewModelState {}


class VerifyOtpViewModelErrorState extends AuthViewModelState {
  String ? errorMessage ;
  VerifyOtpViewModelErrorState(this.errorMessage);
}


class VerifyOtpViewModelSuccessState extends AuthViewModelState {
  String? statusCode ;
  VerifyOtpViewModelSuccessState(this.statusCode);
}





class ResetPasswordViewModelLoadingState extends AuthViewModelState {}


class ResetPasswordViewModelErrorState extends AuthViewModelState {
  String ? errorMessage ;
  ResetPasswordViewModelErrorState(this.errorMessage);
}


class ResetPasswordViewModelSuccessState extends AuthViewModelState {
  String? statusCode ;
  ResetPasswordViewModelSuccessState(this.statusCode);
}