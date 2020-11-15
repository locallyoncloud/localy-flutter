import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/models/order.dart';
import 'package:locally_flutter_app/models/product.dart';


abstract class HomeBase {
  Future<List<Company>> getCompanyList();

  Future<LoyaltyCard> getClientSideLoyaltyCard(String company_id);

  Future<Company> getCompanyDetails(String companyId);

  Stream getLoyaltyProgress(String loyaltyCardUid, String userMail);

  Stream<LoyaltyProgress> getUserLoyalty(String loyaltyCardUid,
      String userMail);

  Future<void> openLoyaltyCardForUser(String loyaltyCardUid, String userMail);

  Future<List<Product>> getAllProducts(String companyId);

  Future<void> submitOrder(Order order);

  Stream<List<Order>> getActiveOrders(String userMail);

  Future<List<Order>> getAllCustomerPreviousOrders(String userMail);

  Stream<List<Order>> getAllAdminSideOrders(String companyId);
}
