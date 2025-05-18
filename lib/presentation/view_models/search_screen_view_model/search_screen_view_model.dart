import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/core/reusable_components/filter_model.dart';
import 'package:real_their/domain/entitys/search_property_response_entity.dart';
import 'package:real_their/domain/use_cases/get_search_properties_use_case.dart';

@injectable
class GetSearchPropertiesViewModel extends Cubit<GetSearchPropertiesState> {
  @factoryMethod
  GetSearchPropertiesViewModel(this.useCase) : super(InitGetSearchPropertiesState());

  final GetSearchPropertiesUseCase useCase;

  static GetSearchPropertiesViewModel get(BuildContext context) => BlocProvider.of(context);
  static List<SearchPropertyResponseEntity> properties = [];

  getSearchProperties(FilterModel filter, String searchTerm) async {
    emit(LoadingGetSearchPropertiesState());
    var request = await useCase.call(filter, searchTerm);

    request.fold(
          (response) {
            properties = response;
            emit(SuccessGetSearchPropertiesState(response));
          },
          (error) => emit(ErrorGetSearchPropertiesState(error)),
    );
  }
}

abstract class GetSearchPropertiesState {}

class InitGetSearchPropertiesState extends GetSearchPropertiesState {}

class LoadingGetSearchPropertiesState extends GetSearchPropertiesState {}

class SuccessGetSearchPropertiesState extends GetSearchPropertiesState {
  final List<SearchPropertyResponseEntity> properties;
  SuccessGetSearchPropertiesState(this.properties);
}

class ErrorGetSearchPropertiesState extends GetSearchPropertiesState {
  final String error;
  ErrorGetSearchPropertiesState(this.error);
}
