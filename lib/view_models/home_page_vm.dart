import 'package:flutter/material.dart';
import 'package:locally_flutter_app/base_classes/home_base.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/repositories/home_repository.dart';

class HomePageVM extends ChangeNotifier with HomeBase{
  bool hideCarousel  = false;
  List<Company> companyList = [];

  setCarouselVisibility(bool carouselStatus){
    hideCarousel = carouselStatus;
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

}