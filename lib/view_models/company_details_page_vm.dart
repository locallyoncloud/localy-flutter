import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/models/cart_product.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/models/product.dart';

class CompanyDetailsPageVM extends ChangeNotifier {
  int selectedTab = 0;
  PageController tabsPageController = PageController();
  LoyaltyProgress currentProgress;
  Company currentCompany;
  List<CartProductOption> currentSelectedProductOptions = [];
  double extraProductPrice = 0;

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

  setProductOption(ProductOptions productOption, Options option){
    int index = currentSelectedProductOptions.indexWhere((element) => element.name == productOption.name);
    if(index == -1){
      CartProductOption cartProductOption = CartProductOption(name: productOption.name, options: [option]);
      currentSelectedProductOptions.add(cartProductOption);
    }else{
      currentSelectedProductOptions[index].options[0] = option;
    }
    calculateTotalExtraPrice();
    notifyListeners();
  }

  addProductOption(ProductOptions productOption, Options option){
    int index = currentSelectedProductOptions.indexWhere((element) => element.name == productOption.name);
    if(index == -1){
      CartProductOption cartProductOption = CartProductOption(name: productOption.name, options: [option]);
      currentSelectedProductOptions.add(cartProductOption);
    }else{
      currentSelectedProductOptions[index].options.add(option);
    }
    calculateTotalExtraPrice();
    notifyListeners();
  }
  removeProductOption(ProductOptions productOption, Options option){
    int productOptionIndex = currentSelectedProductOptions.indexWhere((element) => element.name == productOption.name);
    int optionIndex = currentSelectedProductOptions[productOptionIndex].options.indexWhere((element) => element.optionName == option.optionName);
    currentSelectedProductOptions[productOptionIndex].options.removeAt(optionIndex);
    calculateTotalExtraPrice();
    notifyListeners();
  }
  clearCurrentSelectedProductOptions(){
    currentSelectedProductOptions.clear();
    extraProductPrice=0;
    notifyListeners();
  }
  calculateTotalExtraPrice(){
    extraProductPrice = 0;
    currentSelectedProductOptions.forEach((element) {
      for(var i=0; i<element.options.length; i++){
        extraProductPrice+=element.options[i].optionValue;
      }
    });
  }

}