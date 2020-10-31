import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/models/product.dart';
import 'package:locally_flutter_app/models/public_profile.dart';

abstract class HomeBase {
  Future<List<Company>> getCompanyList();
  Future<LoyaltyCard> getClientSideLoyaltyCard(String company_id);
  Stream getLoyaltyProgress(String loyaltyCardUid, String userMail);
  Future<void> openLoyaltyCardForUser(String loyaltyCardUid, String userMail);
  Future<List<Product>> getAllProducts(String companyId);
}
