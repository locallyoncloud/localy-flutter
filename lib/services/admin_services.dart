import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:locally_flutter_app/base_classes/admin_base.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/models/public_profile.dart';

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
  Future<String> uploadFile(String filePath, String fileName, String storageReference) async {
    File file = File(filePath);

    TaskSnapshot task =
        await storage.ref(storageReference + '/$fileName').putFile(file);
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
  Future<LoyaltyProgress> addLoyalty(String loyaltyInfo, String companyId,
      int incrementNumber, double totalPrice) async {
    DateTime date = DateTime.now();
    String todayDate = date
        .toString()
        .replaceRange(date.toString().length - 7, date.toString().length, "");
    List<String> loyaltyCardInfoArray = loyaltyInfo.split("/");
    String userMail = loyaltyCardInfoArray[0];
    int loyaltyCardType = int.parse(loyaltyCardInfoArray[1]);
    int loyaltyCardTarget = int.parse(loyaltyCardInfoArray[2]);
    String loyaltyCardUid = loyaltyCardInfoArray[3];
    double loyaltyCardPercentage = double.parse(loyaltyCardInfoArray[4]);
    DocumentSnapshot documentSnapshot = await fireStore
        .collection("loyalties")
        .doc(loyaltyCardUid)
        .collection("gift_cards")
        .doc(userMail)
        .get();

    LoyaltyProgress giftCards =
        LoyaltyProgress.fromJsonMap(documentSnapshot.data());
    if (loyaltyCardType == 0) {
      giftCards.progress += incrementNumber;
      while (giftCards.progress >= loyaltyCardTarget) {
        giftCards.progress = giftCards.progress - loyaltyCardTarget;
        giftCards.gifts += 1;
      }
    } else {
      giftCards.progress = (giftCards.progress +
          (giftCards.progress * (loyaltyCardPercentage / 100)));
    }

    giftCards.pushDates.add(todayDate);
    await documentSnapshot.reference.set(giftCards.toJson());
    return giftCards;
  }

  @override
  Stream<LoyaltyProgress> getLoyaltyProgressStatus(String loyaltyInfo) {
    List<String> loyaltyCardInfoArray = loyaltyInfo.split("/");
    String userMail = loyaltyCardInfoArray[0];
    String loyaltyCardUid = loyaltyCardInfoArray[3];
    return fireStore
        .collection("loyalties")
        .doc(loyaltyCardUid)
        .collection("gift_cards")
        .doc(userMail)
        .snapshots()
        .map((snap) => LoyaltyProgress.fromJsonMap(snap.data()));
  }

  @override
  Stream getAllCustomersForCard( String companyId, int cardType) async* {

    String uid = "";

    QuerySnapshot snapshot =  await fireStore
        .collection("loyalties")
        .where("company_id", isEqualTo: companyId)
        .where("type", isEqualTo: cardType)
        .get();
    uid =snapshot.docs[0].id;

    yield*  fireStore.collection("loyalties").doc(uid).collection("gift_cards").snapshots();

  }

  @override
  Future<void> sendGift(int count, String companyId, int cardType, String userMail) async {

    QuerySnapshot snapshot =  await fireStore.collection("loyalties")
        .where("company_id", isEqualTo: companyId)
        .where("type", isEqualTo: cardType)
        .get();


   await snapshot.docs[0].reference.collection("gift_cards").doc(userMail.trim()).update({
     "gifts": count
   });
  }

  @override
  Future<void> incrementOrderStatus(String orderUid) async {
    await fireStore.collection("orders")
        .doc(orderUid)
        .update({
      "orderStatus":FieldValue.increment(1)
    });
  }

  @override
  Future<List<String>> getAllNotificationIdsForCard(String companyId) async {
    List<String> allUserIds = [];
    List<String> notNullArray = [];

    QuerySnapshot snapshot = await fireStore.collection("loyalties")
        .where("isActive", isEqualTo: true)
        .where("company_id", isEqualTo:companyId).get();
    
    QuerySnapshot giftCardSnapshot = await snapshot.docs[0].reference
        .collection("gift_cards").get();

    giftCardSnapshot.docs.forEach((doc) {
      LoyaltyProgress progress = LoyaltyProgress.fromJsonMap(doc.data());
      notNullArray = progress.notificationIdsOfUsers.where((element) => element!=null && element.length>0).toList();
      allUserIds += notNullArray;
    });
    allUserIds = allUserIds.toSet().toList();
    return allUserIds;
  }

  @override
  Stream<PublicProfile> getPublicProfile(String mail) {
    return fireStore.collection("accounts").doc(mail).collection("public_profile").snapshots().map((event) => PublicProfile.fromJson(event.docs[0].data()));
  }
}
