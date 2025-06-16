import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/domain/use_cases/predict_price_use_case.dart';
import 'package:flutter/material.dart';

import '../../../domain/entitys/price_prediction_response_entity.dart';
import '../../../domain/entitys/property_request_entity.dart';

@injectable
class PredictPriceViewModel extends Cubit<PredictPriceState> {
  @factoryMethod
  PredictPriceViewModel(this.useCase) : super(PredictPriceInitial());

  final PredictPriceUseCase useCase;

  static PredictPriceViewModel get(BuildContext context) => BlocProvider.of(context);

  Future<void> predictPrice(PropertyRequestEntity request) async {
    emit(PredictPriceLoading());

    final result = await useCase.call(request);

    result.fold(
          (prediction) => emit(PredictPriceSuccess(prediction)),
          (error) => emit(PredictPriceError(error)),
    );
  }
}
abstract class PredictPriceState {}

class PredictPriceInitial extends PredictPriceState {}

class PredictPriceLoading extends PredictPriceState {}

class PredictPriceSuccess extends PredictPriceState {
  final PricePredictionResponseEntity prediction;

  PredictPriceSuccess(this.prediction);
}

class PredictPriceError extends PredictPriceState {
  final String error;

  PredictPriceError(this.error);
}
