import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

class RegistrationPageVM extends ChangeNotifier{
  int selectedRegistrationIndex  = 1;


  setSelectedIndex(index){
    selectedRegistrationIndex = index;
    notifyListeners();
  }


}