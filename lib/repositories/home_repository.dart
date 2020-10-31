import 'package:get_it/get_it.dart';
import 'package:locally_flutter_app/base_classes/home_base.dart';
import 'package:locally_flutter_app/enums/database_type.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/models/product.dart';
import 'package:locally_flutter_app/services/home_services.dart';

final getIt = GetIt.instance;

class HomeRepository implements HomeBase {
  DatabaseType currentDatabase = DatabaseType.FireStore;

  @override
  Future<List<Company>> getCompanyList() async {
    if(currentDatabase == DatabaseType.FireStore) {
      return await getIt<HomeServices>().getCompanyList();
    }
  }

  @override
  Future<LoyaltyCard> getClientSideLoyaltyCard(String company_id) async {
    if(currentDatabase == DatabaseType.FireStore) {
      return await getIt<HomeServices>().getClientSideLoyaltyCard(company_id);
    }
  }

  @override
  Stream getLoyaltyProgress(String loyaltyCardUid, String userMail) {
    if(currentDatabase == DatabaseType.FireStore) {
      return getIt<HomeServices>().getLoyaltyProgress(loyaltyCardUid, userMail);
    }
  }

  @override
  Future<void> openLoyaltyCardForUser(String loyaltyCardUid, String userMail) async {
    if(currentDatabase == DatabaseType.FireStore) {
      return await getIt<HomeServices>().openLoyaltyCardForUser(loyaltyCardUid, userMail);
    }
  }

  @override
  Future<List<Product>> getAllProducts(String companyId) async {
    if(currentDatabase == DatabaseType.FireStore) {
      return await getIt<HomeServices>().getAllProducts(companyId);
    }
  }

}