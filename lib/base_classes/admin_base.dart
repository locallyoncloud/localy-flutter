
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';

abstract class AdminBase {

  dynamic getAdminSideLoyaltyCards(String companyId);
  Future<String> uploadFile(String filePath, String fileName);
  Future<void> addLoyaltyCard(LoyaltyCard loyaltyCard);
  Future<Company>getCompanyById(String companyId);
  Future<void> toggleCardStatus(LoyaltyCard loyaltyCard);
  Future<void> addLoyalty(String userMail, String companyId,int incrementNumber);
}
