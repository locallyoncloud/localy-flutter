import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/base_classes/admin_base.dart';
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/repositories/admin_repository.dart';
import 'package:locally_flutter_app/views/admin_page/customers.dart';
import 'package:locally_flutter_app/views/admin_page/loyalty_tabs_page/loyalty_cards.dart';

import 'package:locally_flutter_app/views/admin_page/notifications.dart';
import 'package:locally_flutter_app/views/admin_page/qr_code_scan_page/qr_code_scan.dart';

import 'package:supercharged/supercharged.dart';

class AdminPanelVM extends ChangeNotifier with AdminBase {
  Company currentSelectedCompany;
  int pickedNumber = 1;
  LoyaltyProgress currentScannedProgress;

  goToPage(String text) {
    switch (text) {
      case "Loyalty Kartlarım":
        Get.to(LoyaltyCards(),
            transition: Transition.rightToLeft, duration: 0.3.seconds);
        break;
      case "QR Kod Okut":
        Get.to(ScanQR(),
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
  setCurrentScannedProgress(LoyaltyProgress loyaltyProgress){
    currentScannedProgress = loyaltyProgress;
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
  Future<LoyaltyProgress> addLoyalty(String loyaltyInfo, String companyId, int incrementNumber) async {
    return await getIt<AdminRepository>().addLoyalty(loyaltyInfo, companyId, incrementNumber);
  }

  @override
  Stream getLoyaltyProgressStatus(String loyaltyInfo) {
    return getIt<AdminRepository>().getLoyaltyProgressStatus(loyaltyInfo);
  }
}
