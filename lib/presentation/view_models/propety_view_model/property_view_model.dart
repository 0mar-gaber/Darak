import '../../../domain/entitys/property_entity.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/domain/use_cases/get_properties_use_case.dart';

@injectable
class GetPropertyByIdViewModel extends Cubit<GetPropertyByIdState> {
  @factoryMethod
  GetPropertyByIdViewModel(this.useCase) : super(InitGetPropertyByIdState());

  final GetPropertiesUseCase useCase;

  static GetPropertyByIdViewModel get(BuildContext context) => BlocProvider.of(context);

  getPropertyById(String id) async {
    emit(LoadingGetPropertyByIdState());
    var request = await useCase.callGetPropertiesById(id);

    request.fold(
          (property) => emit(SuccessGetPropertyByIdState(property)),
          (error) => emit(ErrorGetPropertyByIdState(error)),
    );
  }
}



abstract class GetPropertyByIdState {}

class InitGetPropertyByIdState extends GetPropertyByIdState {}

class LoadingGetPropertyByIdState extends GetPropertyByIdState {}

class SuccessGetPropertyByIdState extends GetPropertyByIdState {
  final PropertyEntity property;
  SuccessGetPropertyByIdState(this.property);
}

class ErrorGetPropertyByIdState extends GetPropertyByIdState {
  final String error;
  ErrorGetPropertyByIdState(this.error);
}
