import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/enums/text_type.dart';
import 'package:locally_flutter_app/models/public_profile.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/main_page.dart';
import 'package:locally_flutter_app/views/widgets/registration_textfield.dart';
import 'package:locally_flutter_app/views/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class LoginContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          RegistrationTextfield(
            placeholder: "Mail",
            iconData: Octicons.mail,
            iconColor: AppColors.WHITE,
            textfieldType: TextfieldType.signinMail,
            value: context.watch<RegistrationPageVM>().signinMail,
          ),
          SizedBox(
            height: 2.hb,
          ),
          RegistrationTextfield(
            placeholder: "Şifre",
            iconData: MaterialCommunityIcons.textbox_password,
            iconColor: AppColors.WHITE,
            hideText: true,
            textfieldType: TextfieldType.signinPassword,
            value: context.watch<RegistrationPageVM>().signinPassword,
            hasSuffixEyeIcon: true,
          ),
          SizedBox(
            height: 2.hb,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: ()=>resetPassword(context),
              child: Text(
                "Şifremi Unuttum",
                style: AppFonts.getMainFont(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.WHITE
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2.hb,
          ),
          InkWell(
            onTap: () =>  loginUser(context),
            child: Container(
                width: 139,
                height: 44,
                decoration: BoxDecoration(
                    /*border: Border.all(color: AppColors.WHITE,width: 2),*/
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF28A745)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Giriş",
                      style: AppFonts.getMainFont(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.WHITE),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(
                        Ionicons.md_log_in,
                        color: AppColors.WHITE,
                      ),
                    )
                  ],
                )),
          ),
          SizedBox(
            height: 3.hb,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  AntDesign.facebook_square,
                  color: AppColors.WHITE,
                  size: 40,
                ),
                Icon(
                  AntDesign.google,
                  color: AppColors.WHITE,
                  size: 40,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  loginUser(BuildContext context) async{
    context.read<RegistrationPageVM>().setLoadingVisibility(true);
    try {
      PublicProfile publicProfile = await context.read<RegistrationPageVM>().signInWithEmailAndPassword(
          context.read<RegistrationPageVM>().signinMail,
          context.read<RegistrationPageVM>().signinPassword);
      if(publicProfile!=null){
        context.read<RegistrationPageVM>().setCurrentUser(publicProfile);
        context.read<RegistrationPageVM>().setLoadingVisibility(false);
        Scaffold.of(context).showSnackBar(CustomSnackbar.buildSnackbar(AppColors.PRIMARY_COLOR, "Hoşgeldiniz!",context));
        Get.off(MainPage());
      }
    } on FirebaseAuthException catch (e) {
      context.read<RegistrationPageVM>().setLoadingVisibility(false);
      Scaffold.of(context).showSnackBar(CustomSnackbar.buildSnackbar(AppColors.ERROR, e.message,context));
    }
  }

  resetPassword(BuildContext context) {
    String mail = context.read<RegistrationPageVM>().signinMail;
      if(mail.length>3 && mail.isEmail){
        context.read<RegistrationPageVM>().resetPassword(mail);
        Scaffold.of(context).showSnackBar(CustomSnackbar.buildSnackbar(AppColors.GREEN, "Şifre sıfırlama mailı gönderilmiştir",context));
      }else{
        Scaffold.of(context).showSnackBar(CustomSnackbar.buildSnackbar(AppColors.ERROR, "Lütfen geçerli bir mail adresi giriniz",context));
      }
  }
}
