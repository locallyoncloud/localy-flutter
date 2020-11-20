import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/models/company.dart';

class CompanyDetailsPageVM extends ChangeNotifier {
  int selectedTab = 0;
  PageController tabsPageController = PageController();
  LoyaltyProgress currentProgress;
  Company currentCompany;

  setSelectedTab(int index) {
    selectedTab = index;
    notifyListeners();
  }
  setCurrentProgress(LoyaltyProgress loyaltyProgress){
    currentProgress = loyaltyProgress;
    notifyListeners();
  }
  setCurrentCompany(Company company){
    currentCompany = company;
    notifyListeners();
  }

  bool isAvailableForService(Position firstPosition, Position secondPosition, int maxOrderDistance){
    double distanceBetweenPositions = Geolocator.distanceBetween(firstPosition.latitude, firstPosition.longitude, secondPosition.latitude, secondPosition.longitude);
    return distanceBetweenPositions > maxOrderDistance ? false : true;
  }

}