import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:locally_flutter_app/base_classes/admin_base.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/models/gift_cards.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';

final FirebaseFirestore fireStore = FirebaseFirestore.instance;
firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;

class AdminServices implements AdminBase {
  @override
  dynamic getAdminSideLoyaltyCards(String companyId) {
    return fireStore
        .collection("loyalties")
        .where("company_id", isEqualTo: companyId)
        .snapshots();
  }

  @override
  Future<String> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);

    TaskSnapshot task =
        await storage.ref('company_logos/$fileName').putFile(file);
    if (task.state == TaskState.success) {
      return await task.ref.getDownloadURL();
    }
  }

  @override
  Future<void> addLoyaltyCard(LoyaltyCard loyaltyCard) async {
    await fireStore
        .collection("loyalties")
        .doc(loyaltyCard.uid)
        .set(loyaltyCard.toJson());
  }

  @override
  Future<Company> getCompanyById(String companyId) async {
    QuerySnapshot snapshot = await fireStore
        .collection("companies")
        .where("company_id", isEqualTo: companyId)
        .get();
    if (snapshot.docs.length > 0) {
      return Company.fromJsonMap(snapshot.docs[0].data());
    } else {
      return null;
    }
  }

  @override
  Future<void> toggleCardStatus(LoyaltyCard loyaltyCard) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    await fireStore
        .collection("loyalties")
        .doc(loyaltyCard.uid)
        .update({"isActive": loyaltyCard.isActive ? false : true});
    if (loyaltyCard.isActive) {
      QuerySnapshot snapshot = await fireStore
          .collection("loyalties")
          .where("company_id", isEqualTo: loyaltyCard.company_id)
          .get();
      snapshot.docs.forEach((doc) {
        LoyaltyCard iterableLoyaltyCard = LoyaltyCard.fromJsonMap(doc.data());
        if (iterableLoyaltyCard.uid != loyaltyCard.uid &&
            iterableLoyaltyCard.isActive) {
          batch.update(doc.reference, {"isActive": false});
        }
      });
      return batch.commit();
    }
  }

  @override
  Future<void> addLoyalty(String loyaltyInfo, String companyId,  int incrementNumber, ) async {
    print(loyaltyInfo);
    DateTime date = DateTime.now();
    String todayDate = date.toString().replaceRange(date.toString().length-7, date.toString().length, "");
    List<String> loyaltyCardInfoArray = loyaltyInfo.split("/");
    String userMail = loyaltyCardInfoArray[0];
    int loyaltyCardType = int.parse(loyaltyCardInfoArray[1]);
    int loyaltyCardTarget = int.parse(loyaltyCardInfoArray[2]);
    String loyaltyCardUid = loyaltyCardInfoArray[3];
    DocumentSnapshot documentSnapshot = await fireStore
        .collection("loyalties")
        .doc(loyaltyCardUid)
        .collection("gift_cards")
        .doc(userMail)
        .get();

    LoyaltyProgress giftCards = LoyaltyProgress.fromJsonMap(documentSnapshot.data());
    giftCards.progress += incrementNumber;
    while (giftCards.progress > loyaltyCardTarget) {
      giftCards.progress = giftCards.progress - loyaltyCardTarget;
      giftCards.gifts += 1;
    }
    giftCards.pushDates.add(todayDate);
    await documentSnapshot.reference.set(giftCards.toJson());
  }
}
