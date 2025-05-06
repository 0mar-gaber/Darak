import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_their/domain/entitys/favourite_entity.dart';
import 'package:real_their/domain/use_cases/favourite_use_case.dart';

class FavouriteViewModel extends Cubit<FavouriteState> {
  final FavouriteUseCase useCase;
  List<FavouriteEntity> favourites = []; // إضافة متغير لحفظ الـ favourites

  @factoryMethod
  FavouriteViewModel(this.useCase) : super(FavouriteInitial());

  static FavouriteViewModel get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> addToFavourite(String userId, String propertyId) async {
    emit(FavouriteLoading());
    final result = await useCase.add(userId, propertyId);
    result.fold(
          (_) async {
        await getFavourites(userId); // إعادة تحميل الـ favourites بعد الإضافة
        emit(FavouriteAddSuccess());
      },
          (error) => emit(FavouriteError(error)),
    );
  }

  Future<void> getFavourites(String userId) async {
    emit(FavouriteLoading());
    final result = await useCase.get(userId);
    result.fold(
          (favouritesList) {
        favourites = favouritesList; // تخزين الـ favourites في المتغير
        emit(FavouriteGetSuccess(favouritesList));
      },
          (error) => emit(FavouriteError(error)),
    );
  }

  Future<void> removeFromFavourite(String userId, String propertyId) async {
    emit(FavouriteLoading());
    final result = await useCase.remove(userId, propertyId);
    result.fold(
          (_) async {
        await getFavourites(userId); // إعادة تحميل الـ favourites بعد الإزالة
        emit(FavouriteRemoveSuccess());
      },
          (error) => emit(FavouriteError(error)),
    );
  }
}


abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteAddSuccess extends FavouriteState {}

class FavouriteRemoveSuccess extends FavouriteState {}

class FavouriteGetSuccess extends FavouriteState {
  final List<FavouriteEntity> favourites;
  FavouriteGetSuccess(this.favourites);
}

class FavouriteError extends FavouriteState {
  final String error;
  FavouriteError(this.error);
}
