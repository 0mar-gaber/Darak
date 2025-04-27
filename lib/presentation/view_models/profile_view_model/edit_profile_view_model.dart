import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/domain/use_cases/profile_use_case.dart';


@injectable
class EditProfileViewModel extends Cubit<EditProfileState> {
  final ProfileUseCase _profileUseCase;
  @factoryMethod

  EditProfileViewModel(this._profileUseCase) : super(EditProfileInitial());

  static EditProfileViewModel get(BuildContext context)=>BlocProvider.of(context);


  uploadProfileImage(XFile imageFile) async {
    emit(UploadImageLoading());

    final result = await _profileUseCase.callUploadImage(imageFile);

    result.fold(
          (success) => emit(UploadImageSuccess(success)),
          (failure) => emit(UploadImageError(failure))

    );
  }

  editProfile(String userName, String phoneNumber, String gender) async {
    emit(EditProfileLoading());

    final result = await _profileUseCase.callUpdateProfile(userName,phoneNumber,gender);

    result.fold(
            (success) => emit(EditProfileSuccess(success)),
            (failure) => emit(EditProfileError(failure))

    );
  }


}


abstract class EditProfileState  {}

class EditProfileInitial extends EditProfileState {}



class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  final String message;
  EditProfileSuccess(this.message);
}

class EditProfileError extends EditProfileState {
  final String error;
  EditProfileError(this.error);

}




class UploadImageLoading extends EditProfileState {}

class UploadImageSuccess extends EditProfileState {
  final String message;
  UploadImageSuccess(this.message);
}

class UploadImageError extends EditProfileState {
  final String error;
  UploadImageError(this.error);

}


