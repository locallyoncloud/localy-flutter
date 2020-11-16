

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/base_classes/admin_base.dart';
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/repositories/admin_repository.dart';
import 'package:locally_flutter_app/views/admin_page/all_customers_page/customers.dart';

import 'package:locally_flutter_app/views/admin_page/loyalty_tabs_page/loyalty_cards.dart';

import 'package:locally_flutter_app/views/admin_page/notifications.dart';
import 'package:locally_flutter_app/views/admin_page/qr_code_scan_page/loyalty_scan.dart';

import 'package:supercharged/supercharged.dart';

class AdminPanelVM extends ChangeNotifier with AdminBase {
  Company currentSelectedCompany;
  int pickedNumber = 1;
  LoyaltyProgress currentScannedProgress;
  List<LoyaltyProgress> customerLoyaltyList = [];
  String lastReadAdminQrCode = "";
  String lastReadCustomerQrCode = "";

  goToPage(String text) {
    switch (text) {
      case "Loyalty Kartlarım":
        Get.to(LoyaltyCards(),
            transition: Transition.rightToLeft, duration: 0.3.seconds);
        break;
      case "QR Kod Okut":
        Get.to(LoyaltyScan(),
            transition: Transition.leftToRight, duration: 0.3.seconds);
        break;
      case "Müşterilerim":
        Get.to(Customers(),
            transition: Transition.rightToLeft, duration: 0.3.seconds);
        break;
      case "Bildirimler":
        Get.to(Notifications(),
            transition: Transition.leftToRight, duration: 0.3.seconds);
        break;
    }
  }

  incrementPickedNumber() {
    pickedNumber += 1;
    notifyListeners();
  }

  decrementPickedNumber() {
    if (pickedNumber != 1) {
      {
        pickedNumber -= 1;
        notifyListeners();
      }
    }
  }
  setPickedNumber(int number){
    pickedNumber = number;
    notifyListeners();
  }
  setCurrentScannedProgress(LoyaltyProgress loyaltyProgress){
    currentScannedProgress = loyaltyProgress;
    notifyListeners();
  }
   setCustomerLoyaltyList(list){
    customerLoyaltyList = List.from(list);
    notifyListeners();
  }
  setAdminQrCode(String newQrCode){
    lastReadAdminQrCode = newQrCode;
    notifyListeners();
  }
  setCustomerQrCode(String newQrCode){
    lastReadCustomerQrCode = newQrCode;
    notifyListeners();
  }

  @override
  dynamic getAdminSideLoyaltyCards(String companyId) {
    return getIt<AdminRepository>().getAdminSideLoyaltyCards(companyId);
  }

  @override
  Future<String> uploadFile(String filePath, String fileName) async {
    return await getIt<AdminRepository>().uploadFile(filePath, fileName);
  }

  @override
  Future<void> addLoyaltyCard(LoyaltyCard loyaltyCard) async {
    return await getIt<AdminRepository>().addLoyaltyCard(loyaltyCard);
  }

  @override
  Future<Company> getCompanyById(String companyId) async {
    currentSelectedCompany = await getIt<AdminRepository>().getCompanyById(companyId);
    notifyListeners();
    return await getIt<AdminRepository>().getCompanyById(companyId);
  }

  @override
  Future<void> toggleCardStatus(LoyaltyCard loyaltyCard) async {
    return await getIt<AdminRepository>().toggleCardStatus(loyaltyCard);
  }

  @override
  Future<LoyaltyProgress> addLoyalty(String loyaltyInfo, String companyId, int incrementNumber, double totalPrice) async {
    return await getIt<AdminRepository>().addLoyalty(loyaltyInfo, companyId, incrementNumber,totalPrice);
  }

  @override
  Stream getLoyaltyProgressStatus(String loyaltyInfo) {
    return getIt<AdminRepository>().getLoyaltyProgressStatus(loyaltyInfo);
  }

  @override
  Stream getAllCustomersForCard(String companyId, int cardType) {
    return getIt<AdminRepository>().getAllCustomersForCard(companyId,cardType);
  }

  @override
  Future<void> sendGift(int count, String companyId, int cardType, String userMail) {
    return getIt<AdminRepository>().sendGift(count, companyId, cardType, userMail);
  }

  @override
  Future<void> incrementOrderStatus(String orderUid) {
    return getIt<AdminRepository>().incrementOrderStatus(orderUid);
  }

  @override
  Future<List<String>> getAllNotificationIdsForCard(String companyId) async {
    return getIt<AdminRepository>().getAllNotificationIdsForCard(companyId);
  }


}
