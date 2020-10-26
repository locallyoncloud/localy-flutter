import 'package:locally_flutter_app/models/public_profile.dart';

abstract class AuthBase {
  Future<PublicProfile> createUserWithEmailAndPassword(
      String mail, String password);

  Future<PublicProfile> signInWithEmailAndPassword(String mail, String password);

  Future resetPassword(String mail);

  /*Future getUser();*/

  signOut();
}
