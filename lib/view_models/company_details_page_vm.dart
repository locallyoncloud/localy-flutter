import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/models/company.dart';

class CompanyDetailsPageVM extends ChangeNotifier {
  int selectedTab = 0;
  PageController tabsPageController = PageController();
  LoyaltyProgress currentProgress;
  Company currentCompany;
  bool isCartModeOn = false;

  setSelectedTab(int index) {
    selectedTab = index;
    notifyListeners();
  }
  setCurrentProgress(LoyaltyProgress loyaltyProgress){
    currentProgress = loyaltyProgress;
    notifyListeners();
  }
  setCurrentCompany(Company company, bool cartMode){
    currentCompany = company;
    isCartModeOn = cartMode;
  notifyListeners();
  }
  setCartMode(bool cartModeStatus){
    isCartModeOn = cartModeStatus;
    notifyListeners();
  }

}