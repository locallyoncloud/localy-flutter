import 'package:flutter/material.dart';

class CompanyDetailsPageVM extends ChangeNotifier {
  int selectedTab = 0;
  PageController tabsPageController = PageController();


  setSelectedTab(int index) {
    selectedTab = index;

    notifyListeners();
  }

}