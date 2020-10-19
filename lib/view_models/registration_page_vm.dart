import 'package:flutter/material.dart';
import 'package:locally_flutter_app/enums/text_type.dart';

class RegistrationPageVM extends ChangeNotifier{
  int selectedRegistrationIndex  = 1;
  String signupMail = "", signupPassword = "", signupConfPassword = "" , signinMail = "", signinPassword = "" ;
  bool isSignInSelected = true;

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


}