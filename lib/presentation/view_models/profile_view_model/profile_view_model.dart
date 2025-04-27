import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/domain/entitys/user_details_entity.dart';
import 'package:real_their/domain/use_cases/profile_use_case.dart';

@injectable
class ProfileViewModel extends Cubit<ProfileState>{
  @factoryMethod
  ProfileViewModel(this.useCase):super(InitState());

  ProfileUseCase useCase;
  static ProfileViewModel get(BuildContext context)=>BlocProvider.of(context);

  getUserDetails() async {
    emit(LoadingState());
    var request = await useCase.callGetUserDetails();

    request.fold(
            (response) => emit(SuccessState(response)),
            (error) => emit(ErrorState(error))
    );
  }

}
abstract class ProfileState {}

class InitState extends ProfileState{}


class LoadingState extends ProfileState{}


class SuccessState extends ProfileState{
  UserDetailsEntity userDetailsEntity ;
  SuccessState(this.userDetailsEntity);
}

class ErrorState extends ProfileState{
  String error ;
  ErrorState(this.error);
}


class EditScreenProvider extends ChangeNotifier {
  int tabIndex = 0;

  changeGender(int newIndex){
    tabIndex = newIndex;
    notifyListeners();
  }

}

