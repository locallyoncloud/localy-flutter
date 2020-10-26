import 'package:get_it/get_it.dart';
import 'package:locally_flutter_app/base_classes/admin_base.dart';
import 'package:locally_flutter_app/enums/database_type.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/services/admin_services.dart';

final getIt = GetIt.instance;

class AdminRepository implements AdminBase {
  DatabaseType currentDatabase = DatabaseType.FireStore;

  @override
  Stream getAdminSideLoyaltyCards(String companyId)  {
    if(currentDatabase == DatabaseType.FireStore) {
      return getIt<AdminServices>().getAdminSideLoyaltyCards(companyId);
    }
  }


}