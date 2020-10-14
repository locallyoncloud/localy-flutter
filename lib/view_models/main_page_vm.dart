import 'package:flutter/material.dart';

class MainPageVM extends ChangeNotifier{
  int currentSelectedIndex  = 0;

  setCurrentSelectedIndex(selectedIndex){
    currentSelectedIndex = selectedIndex;
    notifyListeners();
  }

}