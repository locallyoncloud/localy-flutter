import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:locally_flutter_app/base_classes/authentication_base.dart';
import 'package:locally_flutter_app/enums/database_type.dart';
import 'package:locally_flutter_app/models/public_profile.dart';
import 'package:locally_flutter_app/services/authentication_services.dart';

final getIt = GetIt.instance;

class AuthRepository implements AuthBase {

  DatabaseType currentDatabase = DatabaseType.FireStore;

  @override
  Future<PublicProfile> createUserWithEmailAndPassword(String mail, String password, String playerId) async {
    if(currentDatabase == DatabaseType.FireStore) {
      return await getIt<AuthenticationServices>().createUserWithEmailAndPassword(mail, password, playerId);
    }
  }

  @override
  Future resetPassword(String mail) async {
    if(currentDatabase == DatabaseType.FireStore){
      return await getIt<AuthenticationServices>().resetPassword(mail);
    }
  }

  @override
  Future<PublicProfile> signInWithEmailAndPassword(String mail, String password) async {
    if(currentDatabase == DatabaseType.FireStore){
      return await getIt<AuthenticationServices>().signInWithEmailAndPassword(mail, password);
    }
  }

  @override
  signOut() async {
    if(currentDatabase == DatabaseType.FireStore) {
      return await getIt<AuthenticationServices>().signOut();
    }
  }

  @override
  Future<PublicProfile> signInWithGoogle(String playerId) async{
    if(currentDatabase == DatabaseType.FireStore) {
      return await getIt<AuthenticationServices>().signInWithGoogle(playerId);
    }
  }

  @override
  Future<void> setPlayerId(String userMail, String playerId) async {
    if(currentDatabase == DatabaseType.FireStore) {
      return await getIt<AuthenticationServices>().setPlayerId(userMail, playerId);
    }
  }


  
}