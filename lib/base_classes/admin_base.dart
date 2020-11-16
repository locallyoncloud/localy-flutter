
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';

abstract class AdminBase {

  dynamic getAdminSideLoyaltyCards(String companyId);
  Future<String> uploadFile(String filePath, String fileName, String storageReference);
  Future<void> addLoyaltyCard(LoyaltyCard loyaltyCard);
  Future<Company>getCompanyById(String companyId);
  Future<void> toggleCardStatus(LoyaltyCard loyaltyCard);
  Future<LoyaltyProgress> addLoyalty(String loyaltyInfo, String companyId,int incrementNumber, double totalPrice);
  Stream getLoyaltyProgressStatus(String loyaltyInfo);
  Stream getAllCustomersForCard(String companyId, int cardType);
  Future<void> sendGift(int count, String companyId, int cardType, String userMail);
}
