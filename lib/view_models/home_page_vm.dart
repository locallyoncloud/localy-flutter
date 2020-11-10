import 'package:flutter/material.dart';
import 'package:locally_flutter_app/base_classes/home_base.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/models/product.dart';
import 'package:locally_flutter_app/repositories/home_repository.dart';

class HomePageVM extends ChangeNotifier with HomeBase{
  bool hideCarousel  = false;
  List<Company> companyList = [];
  List<String> categoryList = [];
  String currentFilter="";

  setCarouselVisibility(bool carouselStatus){
    hideCarousel = carouselStatus;
    notifyListeners();
  }

  selectFilter(String filter){
    currentFilter = filter;
    notifyListeners();
  }

  @override
  Future<List<Company>> getCompanyList() async {
    return await getIt<HomeRepository>().getCompanyList();
  }

  @override
  Future<LoyaltyCard> getClientSideLoyaltyCard(String company_id) async {
    return await getIt<HomeRepository>().getClientSideLoyaltyCard(company_id);
  }

  @override
  Stream getLoyaltyProgress(String loyaltyCardUid, String userMail) {
    return  getIt<HomeRepository>().getLoyaltyProgress(loyaltyCardUid, userMail);
  }

  @override
  Future<void> openLoyaltyCardForUser(String loyaltyCardUid, String userMail) async {
    return await getIt<HomeRepository>().openLoyaltyCardForUser(loyaltyCardUid, userMail);
  }

  @override
  Future<List<Product>> getAllProducts(String companyId) async {
    String categoryName = "";
    List<Product> productList = await getIt<HomeRepository>().getAllProducts(companyId);
    productList.forEach((product) {
      if(product.category != categoryName && !categoryList.contains(product.category)){
        categoryName = product.category;
        categoryList.add(categoryName);
      }
    });
    notifyListeners();
    return productList;
  }

  @override
  Future<Company> getCompanyDetails(String companyId) async {
    return await getIt<HomeRepository>().getCompanyDetails(companyId);
  }


}