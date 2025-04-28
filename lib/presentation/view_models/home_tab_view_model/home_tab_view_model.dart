import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/domain/entitys/property_response_entity.dart';
import 'package:real_their/domain/use_cases/get_properties_use_case.dart';

@injectable
class GetPropertiesViewModel extends Cubit<GetPropertiesState> {
  @factoryMethod
  GetPropertiesViewModel(this.useCase) : super(InitGetPropertiesState());

  final GetPropertiesUseCase useCase;

  static GetPropertiesViewModel get(BuildContext context) => BlocProvider.of(context);

  getProperties() async {
    emit(LoadingGetPropertiesState());
    var request = await useCase.call();

    request.fold(
          (response) => emit(SuccessGetPropertiesState(response)),
          (error) => emit(ErrorGetPropertiesState(error)),
    );
  }
}

abstract class GetPropertiesState {}

class InitGetPropertiesState extends GetPropertiesState {}

class LoadingGetPropertiesState extends GetPropertiesState {}

class SuccessGetPropertiesState extends GetPropertiesState {
  final PropertyResponseEntity propertyResponseEntity;
  SuccessGetPropertiesState(this.propertyResponseEntity);
}

class ErrorGetPropertiesState extends GetPropertiesState {
  final String error;
  ErrorGetPropertiesState(this.error);
}
