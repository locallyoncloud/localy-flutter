import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/base_classes/admin_base.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/repositories/admin_repository.dart';
import 'package:locally_flutter_app/services/admin_services.dart';
import 'package:locally_flutter_app/views/admin_page/customers.dart';
import 'package:locally_flutter_app/views/admin_page/loyalty_cards.dart';
import 'package:locally_flutter_app/views/admin_page/notifications.dart';
import 'package:locally_flutter_app/views/admin_page/qr_code_scan.dart';
import 'package:supercharged/supercharged.dart';

class AdminPanelVM extends ChangeNotifier with AdminBase{

  goToPage(String text){
    switch (text){
      case "Loyalty Kartlarım" :
        Get.to(LoyaltyCards(),transition: Transition.rightToLeft, duration: 0.3.seconds);
        break;
      case "QR Kod Okut" :
        Get.to(ScanQR(),transition: Transition.leftToRight, duration: 0.3.seconds);
        break;
      case "Müşterilerim" :
        Get.to(Customers(),transition: Transition.rightToLeft, duration: 0.3.seconds);
        break;
      case "Bildirimler" :
        Get.to(Notifications(),transition: Transition.leftToRight, duration: 0.3.seconds);
        break;
    }
  }

  @override
  Stream getAdminSideLoyaltyCards(String companyId)  {
    return getIt<AdminRepository>().getAdminSideLoyaltyCards(companyId);
  }
}