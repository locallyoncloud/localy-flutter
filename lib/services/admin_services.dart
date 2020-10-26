
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locally_flutter_app/base_classes/admin_base.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';

final FirebaseFirestore fireStore = FirebaseFirestore.instance;

class AdminServices implements AdminBase{

  @override
  Stream getAdminSideLoyaltyCards(String companyId)  {

    return fireStore.collection("loyalties")
        .where("company_id",isEqualTo: companyId)
        .snapshots();
  }


}