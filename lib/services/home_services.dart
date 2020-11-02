
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locally_flutter_app/base_classes/home_base.dart';
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
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
  Future<void> openLoyaltyCardForUser(String loyaltyCardUid, String userMail) async{
    LoyaltyProgress loyaltyProgress = LoyaltyProgress(0,0,[],userMail);
    return await fireStore.collection("loyalties").doc(loyaltyCardUid).collection("gift_cards").doc(userMail).set(loyaltyProgress.toJson());
  }

  @override
  Future<List<Product>> getAllProducts(String companyId) async {
    QuerySnapshot snapshot =  await fireStore.collection("companies").doc(companyId).collection("products").get();

    List<Product> productList = [];

    snapshot.docs.forEach((doc) {
      productList.add(Product.fromJsonMap(doc.data()));
    });
    return productList;
  }



}