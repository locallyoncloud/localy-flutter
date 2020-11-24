import 'package:locally_flutter_app/models/address.dart';
import 'package:locally_flutter_app/models/app_config.dart';
import 'package:locally_flutter_app/models/public_profile.dart';

abstract class AuthBase {
  Future<PublicProfile> createUserWithEmailAndPassword(String mail, String password, String playerId);

  Future<PublicProfile> signInWithEmailAndPassword(String mail, String password);

  Future resetPassword(String mail);

  signOut();

  Future<PublicProfile> updateUser(String name, String email, String phone, String pictureURL);

  Future<PublicProfile> signInWithGoogle(String playerId);

  Future<void> setPlayerId(String userMail, String playerId);

  Future<void> updateUserAddress(Address address, String userMail, bool isAdd);

  Future<AppConfig> getAppConfig();
}
