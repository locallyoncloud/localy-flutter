import 'dart:convert';

import 'package:locally_flutter_app/models/address.dart';
import 'package:locally_flutter_app/utilities/extensions/clone_object.dart';
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
  PublicProfile tempUser = PublicProfile(uid: "",name: "",phone: "",type: "",company_id: "",notificationIds: [],favorites: [],profilePicture: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.vectorstock.com%2Froyalty-free-vectors%2Fteacher-profile-icon-avatar-vectors&psig=AOvVaw3c0yl1iAPm7aAquNIRyWS_&ust=1605695257106000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCIiD_oqvie0CFQAAAAAdAAAAABAI");
  String userName;
  String phone;

  setSelectedRegistrationContainer(bool signinStatus){
    isSignInSelected = signinStatus;
    notifyListeners();
  }
  onTextfieldChange(TextfieldType textfieldType, String value) {
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

  setUser(bool isTemp2Current) {
    if(isTemp2Current) {
      currentUser = PublicProfile.fromJson(tempUser.toJson().clone);
    } else {
      tempUser = PublicProfile.fromJson(currentUser.toJson().clone);
    }
    notifyListeners();
  }

  setCredentials(String varName, String value) {
     var tempUserMap = tempUser.toJson();
     tempUserMap[varName] = value;
     tempUser = PublicProfile.fromJson(tempUserMap);
     notifyListeners();
  }
  addAddressToCurrentUser(Address address) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUser.address.add(address);
    prefs.setString("user", json.encode(currentUser.toJson()));
    notifyListeners();
  }

  checkUserPlayerId(String playerId) async{
    if(currentUser.notificationIds.length==0 || !currentUser.notificationIds.contains(playerId)){
      await setPlayerId(currentUser.email, playerId);
    }
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
  Future<PublicProfile> updateUser(String name, String email, String phone, String pictureURL) async {
    return await getIt<AuthRepository>().updateUser(name, email, phone, pictureURL);
  }
  @override
  Future<PublicProfile> signInWithGoogle(String playerId) async {
    return await getIt<AuthRepository>().signInWithGoogle(playerId);
  }

  @override
  Future<void> setPlayerId(String userMail, String playerId) async {
    return await getIt<AuthRepository>().setPlayerId(userMail, playerId);
  }

  @override
  Future<void> updateUserAddress(Address address, String userMail, bool isAdd) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(isAdd){
      currentUser.address.add(address);
    }else{
      currentUser.address.removeWhere((element) => element.openAddress == address.openAddress);
    }
    prefs.setString("user", json.encode(currentUser.toJson()));
    notifyListeners();
    return await getIt<AuthRepository>().updateUserAddress(address, userMail,isAdd);
  }
}

