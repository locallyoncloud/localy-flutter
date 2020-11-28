import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:locally_flutter_app/base_classes/authentication_base.dart';
import 'package:locally_flutter_app/models/address.dart';
import 'package:locally_flutter_app/models/public_profile.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;

final FirebaseAuth fAuth = FirebaseAuth.instance;
final FirebaseFirestore fireStore = FirebaseFirestore.instance;

class AuthenticationServices implements AuthBase {
  @override
  Future<PublicProfile> createUserWithEmailAndPassword(String mail, String password, String playerId) async {
    PublicProfile profile;
    var result = await fAuth.createUserWithEmailAndPassword(email: mail, password: password);
    profile = PublicProfile(uid: result.user.uid, email: result.user.email, type: "user", company_id: "",notificationIds: [playerId], name: "",favorites: [],profilePicture: "", phone: "", address: []);

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
      profile = PublicProfile(uid: userCredential.user.uid, email: userCredential.user.email, type: "user", company_id: "", notificationIds: [playerId],name: "",favorites: [],profilePicture: "", phone: "", address: []);

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
  Future<PublicProfile> updateUser(String name, String email, String phone, String pictureURL) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    QuerySnapshot snapshot = await fireStore
        .collection("accounts")
        .doc(email)
        .collection("public_profile").get();
    PublicProfile newProfile = PublicProfile.fromJson(snapshot.docs[0].data());

    await snapshot.docs[0].reference.update({
      "name": name,
      "phone": phone,
      "profilePicture": pictureURL
    });
  newProfile
    ..name = name
    ..phone = phone
    ..profilePicture = pictureURL;

    prefs.setString("user", json.encode(newProfile));

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

  @override
  Future<void> updateUserAddress(Address address, String userMail, bool isAdd) async {
    QuerySnapshot snapshot = await fireStore.collection("accounts")
        .doc(userMail)
        .collection("public_profile")
        .get();

    await snapshot.docs[0].reference.update(
      {
        "address" : isAdd ? FieldValue.arrayUnion([address.toJson()]) : FieldValue.arrayRemove([address.toJson()])
      }
    );
  }

  @override
  Future signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
        clientId:
        'com.locallyFlutterApp.service',
        redirectUri: Uri.parse(
          'https://fresh-gleaming-silica.glitch.me/callbacks/sign_in_with_apple',
        ),
      ),
    );

    final signInWithAppleEndpoint = Uri(
      scheme: 'https',
      host: 'fresh-gleaming-silica.glitch.me',
      path: '/sign_in_with_apple',
      queryParameters: <String, String>{
        'code': credential.authorizationCode,
        'firstName': credential.givenName,
        'lastName': credential.familyName,
        'useBundleId':
        Platform.isIOS  ? 'true' : 'false',
        if (credential.state != null) 'state': credential.state,
      },
    );

    final session = await http.Client().post(
      signInWithAppleEndpoint,
    );
    final authCredential = OAuthProvider("apple.com").getCredential(accessToken: credential.identityToken,idToken: credential.identityToken);
    await FirebaseAuth.instance.signInWithCredential(authCredential);
  }

}