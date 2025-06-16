import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/domain/entitys/analysis_response_entity.dart';
import 'package:real_their/domain/entitys/property_price_suggest_entity.dart';
import 'package:real_their/domain/use_cases/suggest_price_use_case.dart';


@injectable
class SuggestPriceViewModel extends Cubit<SuggestPriceState> {
  final SuggestPriceUseCase suggestPriceUseCase;

  @factoryMethod
  SuggestPriceViewModel(this.suggestPriceUseCase) : super(SuggestPriceInitial());

  static SuggestPriceViewModel get(BuildContext context) => BlocProvider.of(context);

  Future<void> suggestPrice(PropertyPriceSuggestEntity request) async {
    emit(SuggestPriceLoading());
    final result = await suggestPriceUseCase.call(request);
    result.fold(
          (response) => emit(SuggestPriceSuccess(response)),
          (error) => emit(SuggestPriceError(error)),
    );
  }
}

abstract class SuggestPriceState {}

class SuggestPriceInitial extends SuggestPriceState {}

class SuggestPriceLoading extends SuggestPriceState {}

class SuggestPriceSuccess extends SuggestPriceState {
  final AnalysisResponseEntity response;

  SuggestPriceSuccess(this.response);
}

class SuggestPriceError extends SuggestPriceState {
  final String error;

  SuggestPriceError(this.error);
}
