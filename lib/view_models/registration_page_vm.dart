import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locally_flutter_app/base_classes/authentication_base.dart';
import 'package:locally_flutter_app/enums/text_type.dart';
import 'package:locally_flutter_app/models/public_profile.dart';
import 'package:locally_flutter_app/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationPageVM extends ChangeNotifier with AuthBase{
  int selectedRegistrationIndex  = 1;
  String signupMail = "", signupPassword = "", signupConfPassword = "" , signinMail = "", signinPassword = "" ;
  bool isSignInSelected = true;
  bool isLoadingVisible = false;
  PublicProfile currentUser;
  String userName;
  String phone;


  setSelectedRegistrationContainer(bool signinStatus){
    isSignInSelected = signinStatus;
    notifyListeners();
  }
  onTextfieldChange(TextfieldType textfieldType, String value){
    switch (textfieldType){
      case TextfieldType.signinMail:
        signinMail = value;
        break;
      case TextfieldType.signinPassword:
        signinPassword = value;
        break;
      case TextfieldType.signupMail:
        signupMail = value;
        break;
      case TextfieldType.signupPassword:
        signupPassword = value;
        break;
      case TextfieldType.signupConfPassword:
        signupConfPassword = value;
        break;
    }
    notifyListeners();
  }
  setLoadingVisibility (bool status){
    isLoadingVisible = status;
    notifyListeners();
  }
  setCurrentUser(PublicProfile profile){
    currentUser = profile;
    notifyListeners();
  }


  setPhone(String phone) {
    this.phone = phone;
    notifyListeners();
  }

  setUserName(String name) {
    this.userName = name;
    notifyListeners();
  }

  checkUserPlayerId(String playerId) async{
    if(currentUser.notificationIds.length==0 || !currentUser.notificationIds.contains(playerId)){
      await setPlayerId(currentUser.email, playerId);
    }
 
  @override
  Future<PublicProfile> createUserWithEmailAndPassword(String mail, String password, String playerId) async {
    currentUser = await getIt<AuthRepository>().createUserWithEmailAndPassword(mail, password, playerId);
    notifyListeners();
  }

  @override
  Future resetPassword(String mail) async {
    await getIt<AuthRepository>().resetPassword(mail);
  }

  @override
  Future<PublicProfile> signInWithEmailAndPassword(String mail, String password) async {
    currentUser = await getIt<AuthRepository>().signInWithEmailAndPassword(signinMail, signinPassword);
    notifyListeners();
    return currentUser;
  }

  @override
  signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await getIt<AuthRepository>().signOut();
    prefs.remove("user");
    notifyListeners();
  }

  @override
  Future<PublicProfile> updateUser(String name, String email, String phone) async {
    return await getIt<AuthRepository>().updateUser(name, email, phone);
  }
  @override
  Future<PublicProfile> signInWithGoogle(String playerId) async {
    return await getIt<AuthRepository>().signInWithGoogle(playerId);
  }

  @override
  Future<void> setPlayerId(String userMail, String playerId) async {
    return await getIt<AuthRepository>().setPlayerId(userMail, playerId);
  }}
