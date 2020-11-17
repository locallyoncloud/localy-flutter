import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:locally_flutter_app/base_classes/authentication_base.dart';
import 'package:locally_flutter_app/models/public_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
final FirebaseFirestore fireStore = FirebaseFirestore.instance;

class AuthenticationServices implements AuthBase {
  @override
  Future<PublicProfile> createUserWithEmailAndPassword(String mail, String password, String playerId) async {
    PublicProfile profile;
    var result = await fAuth.createUserWithEmailAndPassword(email: mail, password: password);
    profile = PublicProfile(uid: result.user.uid, email: result.user.email, type: "user", company_id: "",notificationIds: [playerId]);

    await fireStore
        .collection("accounts")
        .doc(profile.email)
        .collection("public_profile")
        .doc(result.user.uid)
        .set(profile.toJson());
    fAuth.currentUser.sendEmailVerification();
    await fAuth.signOut();
  }

  @override
  Future resetPassword(String mail) async {
    await fAuth.sendPasswordResetEmail(email: mail);
  }

  @override
  Future<PublicProfile> signInWithEmailAndPassword(String mail, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var result = await fAuth.signInWithEmailAndPassword(email: mail, password: password);
    QuerySnapshot profiles = await fireStore.collection("accounts").doc(mail).collection("public_profile").where("uid", isEqualTo: result.user.uid).get();

    if(!result.user.emailVerified) {
      throw "E-Posta hesabınız doğrulanmamıştır.";
    }

    if(profiles.docs.length > 0) {
      PublicProfile profile = PublicProfile.fromJson(profiles.docs[0].data());
      prefs.setString("user", json.encode(profile.toJson()));
      return profile;
    } else {
      return null;
    }
  }

  @override
  signOut() async {
    await fAuth.signOut();
  }

  Future<PublicProfile> signInWithGoogle(String playerId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    //Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential= await FirebaseAuth.instance.signInWithCredential(credential);

    QuerySnapshot profiles = await fireStore.collection("accounts").doc(userCredential.user.email).collection("public_profile").get();


    if(profiles.docs.length==0) {
      PublicProfile profile;
      profile = PublicProfile(uid: userCredential.user.uid, email: userCredential.user.email, type: "user", company_id: "");

      await fireStore
          .collection("accounts")
          .doc(userCredential.user.email)
          .collection("public_profile")
          .doc(userCredential.user.uid)
          .set(profile.toJson());
      return profile;
    } else {
    if(userCredential != null) {
      prefs.setString("user", json.encode(profiles.docs[0].data()));
      return PublicProfile.fromJson(profiles.docs[0].data());
    } else {
      return null;
    }

    }
  }

  @override
  Future<PublicProfile> updateUser(String name, String email, String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    QuerySnapshot snapshot = await fireStore
        .collection("accounts")
        .doc(email)
        .collection("public_profile").get();

    await snapshot.docs[0].reference.update({
      "name": name,
      "phone": phone,
    });

    prefs.setString("user", json.encode(snapshot.docs[0].data()));

    return PublicProfile.fromJson(snapshot.docs[0].data());

  }

  @override
  Future<void> setPlayerId(String userMail, String playerId) async {
   QuerySnapshot snapshot = await fireStore
        .collection("accounts")
        .doc(userMail)
        .collection("public_profile")
        .get();
   
   return await snapshot.docs[0].reference.update({
     "notificationIds" : FieldValue.arrayUnion([playerId])
   });
        
  }

}