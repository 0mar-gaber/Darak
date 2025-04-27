import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/core/reusable_components/property.dart';
import 'package:real_their/domain/entitys/property_entity.dart';
import 'package:real_their/domain/use_cases/add_listing_use_case.dart';

@injectable

class AddListingViewModel extends Cubit<AddListingState>{
  AddListingUseCase useCase ;
  @factoryMethod
  AddListingViewModel(super.initialState,this.useCase);
  static AddListingViewModel get(BuildContext context)=>BlocProvider.of(context);
  addListing(Property property) async {
    emit(AddListingLoading());
    var request = await useCase.call(property);
    request.fold(
            (response) => emit(AddListingSuccess(response)),
            (error) => emit(AddListingError(error))
    );

  }


}



abstract class AddListingState  {}

class AddListingInitial extends AddListingState {}



class AddListingLoading extends AddListingState {}



class AddListingSuccess extends AddListingState {
  final PropertyEntity propertyEntity;
  AddListingSuccess(this.propertyEntity);
}

class AddListingError extends AddListingState {
  final String error;
  AddListingError(this.error);

}

