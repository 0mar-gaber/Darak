import 'package:flutter/material.dart';
import 'package:real_their/domain/entitys/favourite_entity.dart';
import 'package:real_their/domain/entitys/favourite_entity.dart';
import 'package:real_their/domain/entitys/favourite_entity.dart';

import '../../data/models/favourite_property_model.dart';
import '../reusable_components/filter_model.dart';

class HomeScreenProvider extends ChangeNotifier {
  int tabIndex = 0;
  List<FavouriteEntity> _favourites = [];

  List<FavouriteEntity> get favourites => _favourites;

  // تغيير التاب
  changeTab(int newTabIndex) {
    tabIndex = newTabIndex;
    notifyListeners();
  }

  bool visibility = false;
  List<int> property = [];

  // إضافة عقار للمقارنة
  addToCompare(int propertyId) {
    visibility = true;

    if (!property.contains(propertyId)) {
      if (property.length >= 2) {
        property.clear();
      }
      property.add(propertyId);
    } else {
      property.clear();
      visibility = false;
    }

    notifyListeners();
  }

  clearProperty() {
    property.clear();
    visibility = false;
    notifyListeners();
  }

  // إضافة قائمة الـ favourites
  void setFavourites(List<FavouriteEntity> favs) {
    _favourites = favs;
    notifyListeners();
  }


  FilterModel _filter = FilterModel(
    minPrice: null,
    maxPrice: null,
    minArea: null,
    maxArea: null,
    rooms: null,
    bathrooms: null,
    propertyType: null,
    availability: null,
    furnished: null,
  );

  FilterModel get filter => _filter;

  void updateFilter(FilterModel newFilter) {
    _filter = newFilter;
    notifyListeners();
  }

  void resetFilter() {
    _filter.reset();
    notifyListeners();
  }



}
