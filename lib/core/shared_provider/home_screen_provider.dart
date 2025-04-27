import 'package:flutter/material.dart';


class HomeScreenProvider extends ChangeNotifier {
  int tabIndex = 0;

  changeTab(int newTabIndex) {
    tabIndex = newTabIndex;
    notifyListeners();
  }

  bool visibility = false;
  List<int> property = [];

  addToCompare(int propertyId) {
    visibility = true;

    if (!property.contains(propertyId)) {
      if (property.length >= 2) {
        property.clear();
      }
      property.add(propertyId);
    }else{
      property.clear();
      visibility = false;
    }

    notifyListeners();
  }
  clearProperty(){
    property.clear();
    visibility = false;
    notifyListeners();
  }
}

