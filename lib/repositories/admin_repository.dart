import 'package:get_it/get_it.dart';
import 'package:locally_flutter_app/base_classes/admin_base.dart';
import 'package:locally_flutter_app/enums/database_type.dart';
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/services/admin_services.dart';

final getIt = GetIt.instance;

class AdminRepository implements AdminBase {
  DatabaseType currentDatabase = DatabaseType.FireStore;
  Company selectedCompany;

  @override
  Stream getAdminSideLoyaltyCards(String companyId)  {
    if(currentDatabase == DatabaseType.FireStore) {
      return getIt<AdminServices>().getAdminSideLoyaltyCards(companyId);
    }
  }

  @override
  Future<String> uploadFile(String filePath, String fileName) async {
    if(currentDatabase == DatabaseType.FireStore) {
      return await getIt<AdminServices>().uploadFile(filePath,fileName);
    }
  }

  @override
  Future<void> addLoyaltyCard(LoyaltyCard loyaltyCard) async {
    if(currentDatabase == DatabaseType.FireStore) {
      return await getIt<AdminServices>().addLoyaltyCard(loyaltyCard);
    }
  }

  @override
  Future<Company> getCompanyById(String companyId) async {
    if(currentDatabase == DatabaseType.FireStore) {
      return await getIt<AdminServices>().getCompanyById(companyId);
    }
  }

  @override
  Future<void> toggleCardStatus(LoyaltyCard loyaltyCard) async {
    if(currentDatabase == DatabaseType.FireStore) {
      return await getIt<AdminServices>().toggleCardStatus(loyaltyCard);
    }
  }

  @override
  Future<LoyaltyProgress> addLoyalty(String loyaltyInfo, String companyId, int incrementNumber, double totalPrice) async {
    if(currentDatabase == DatabaseType.FireStore) {
      return await getIt<AdminServices>().addLoyalty(loyaltyInfo, companyId, incrementNumber,totalPrice);
    }
  }

  @override
  Stream getLoyaltyProgressStatus(String loyaltyInfo) {
    if(currentDatabase == DatabaseType.FireStore) {
      return getIt<AdminServices>().getLoyaltyProgressStatus(loyaltyInfo);
    }
  }

  @override
  Future<List<LoyaltyProgress>> getAllCustomersForCard(String companyId, int cardType) {
    if(currentDatabase == DatabaseType.FireStore) {
      return getIt<AdminServices>().getAllCustomersForCard(companyId,cardType);
    }

  }

  @override
  Future<void> sendGift(int count, String companyId, int cardType, String userMail) async {
    if(currentDatabase == DatabaseType.FireStore) {
      return await getIt<AdminServices>().sendGift(count, companyId, cardType, userMail);
    }
  }

}