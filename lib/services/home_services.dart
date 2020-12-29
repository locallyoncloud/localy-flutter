
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locally_flutter_app/base_classes/home_base.dart';
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/models/order.dart';
import 'package:locally_flutter_app/models/product.dart';

final FirebaseFirestore fireStore = FirebaseFirestore.instance;

class HomeServices implements HomeBase{

  @override
  Future<List<Company>> getCompanyList() async {
  QuerySnapshot querySnapshot = await fireStore.collection("companies").get();
  List<Company> companyList = [];
  querySnapshot.docs.forEach((doc) {
      companyList.add(Company.fromJsonMap(doc.data()));
  });
  return companyList;
  }

  @override
  Future<LoyaltyCard> getClientSideLoyaltyCard(String company_id) async {

    QuerySnapshot querySnapshot = await fireStore.collection("loyalties")
        .where("company_id",isEqualTo: company_id)
        .where("isActive", isEqualTo: true).get();

    LoyaltyCard loyaltyCard = LoyaltyCard.fromJsonMap(querySnapshot.docs[0].data());
    return loyaltyCard;
  }

  @override
  Stream getLoyaltyProgress(String loyaltyCardUid, String userMail) {
    return fireStore.collection("loyalties").doc(loyaltyCardUid).collection("gift_cards").doc(userMail).snapshots();
  }

  @override
  Future<void> openLoyaltyCardForUser(String loyaltyCardUid, String userMail, List<String> notificationIds) async{
    LoyaltyProgress loyaltyProgress = LoyaltyProgress(0,0,[],userMail,notificationIds);
    return await fireStore.collection("loyalties").doc(loyaltyCardUid).collection("gift_cards").doc(userMail).set(loyaltyProgress.toJson());
  }

  @override
  Future<List<Product>> getAllProducts(String companyId) async {
    QuerySnapshot snapshot =  await fireStore.collection("companies").doc(companyId).collection("products").get();

    List<Product> productList = [];
    snapshot.docs.forEach((doc) {
      productList.add(Product.fromJson(doc.data()));
    });
    return productList;
  }

  @override
  Future<Company> getCompanyDetails(String companyId) async {
    DocumentSnapshot snapshot = await fireStore.collection("companies").doc(companyId).get();
    return Company.fromJsonMap(snapshot.data());
  }

  @override
  Stream<LoyaltyProgress> getUserLoyalty(String loyaltyCardUid, String userMail)  {
     return fireStore.collection("loyalties").doc(loyaltyCardUid).collection("gift_cards").doc(userMail).snapshots()
        .map((snap) => LoyaltyProgress.fromJsonMap(snap.data()));

  }

  @override
  Future<void> submitOrder(Order order) async {
  return await fireStore.collection("orders").doc(order.uid).set(order.toJson());
  }

  @override
  Stream<List<Order>> getActiveOrders(String userMail) {

    return fireStore.collection("orders")
        .where("userMail",isEqualTo: userMail,)
        .where("orderStatus",isLessThan: 3)
        .snapshots()
        .map((snap) => snap.docs.map((e) => Order.fromJson(e.data())).toList());
  }

  @override
  Future<List<Order>> getAllCustomerPreviousOrders(String userMail) async {
   List<Order> orderList = [];
    QuerySnapshot snapshot = await fireStore.collection("orders")
        .where("userMail",isEqualTo: userMail,)
        .where("orderStatus", isEqualTo: 3)
        .get();
   snapshot.docs.forEach((document) {
    orderList.add(Order.fromJson(document.data()));
   });
   return orderList;
  }

  @override
  Stream<List<Order>> getAllAdminSideOrders(String companyId) {

    return fireStore.collection("orders")
        .where("companyId",isEqualTo: companyId,)
        .orderBy("orderTime",descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((e) => Order.fromJson(e.data())).toList());
  }

  @override
  Stream<List<Order>> getAllClientSideOrders(String userMail) {
    return fireStore.collection("orders")
        .where("userMail",isEqualTo: userMail,)
        .snapshots()
        .map((snap) => snap.docs.map((e) => Order.fromJson(e.data())).toList());
  }


}