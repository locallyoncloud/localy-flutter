import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:locally_flutter_app/enums/text_type.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/notifications_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';

import 'package:locally_flutter_app/views/widgets/registration_textfield.dart';
import 'package:locally_flutter_app/views/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class SignUpContainer extends StatelessWidget {
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
            textfieldType: TextfieldType.signupMail,
            value: context.watch<RegistrationPageVM>().signupMail,
          ),
          SizedBox(
            height: 2.hb,
          ),
          RegistrationTextfield(
            placeholder: "Şifre",
            iconData: MaterialCommunityIcons.textbox_password,
            iconColor: AppColors.WHITE,
            hideText: true,
            textfieldType: TextfieldType.signupPassword,
            value: context.watch<RegistrationPageVM>().signupPassword,
            hasSuffixEyeIcon: true,
          ),
          SizedBox(
            height: 2.hb,
          ),
          RegistrationTextfield(
            placeholder: "Şifre Doğrula",
            iconData: MaterialCommunityIcons.textbox_password,
            iconColor: AppColors.WHITE,
            hideText: true,
            textfieldType: TextfieldType.signupConfPassword,
            value: context.watch<RegistrationPageVM>().signupConfPassword,
            hasSuffixEyeIcon: true,
          ),
          SizedBox(
            height: 3.hb,
          ),
          InkWell(
            onTap: () => createUser(context),
            child: Container(
                width: 139,
                height: 44,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.WHITE,width: 2),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Üye Ol",
                      style: AppFonts.getMainFont(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.WHITE),
                    ),
                    Padding(padding: EdgeInsets.only(left: 5),
                      child: Icon(
                        AntDesign.user,
                        color: AppColors.WHITE,
                      ),
                    )
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }
  createUser(BuildContext context){
    context.read<RegistrationPageVM>().setLoadingVisibility(true);
    try {
      context.read<RegistrationPageVM>().createUserWithEmailAndPassword(context.read<RegistrationPageVM>().signupMail, context.read<RegistrationPageVM>().signupPassword, context.read<NotificationsVM>().currentUserId);
      context.read<RegistrationPageVM>().setLoadingVisibility(false);
      Scaffold.of(context).showSnackBar(CustomSnackbar.buildSnackbar(AppColors.ERROR, "Aktivasyon mailı gönderilmiştir.",context));
    } on FirebaseAuthException catch(e) {
      context.read<RegistrationPageVM>().setLoadingVisibility(false);
      Scaffold.of(context).showSnackBar(CustomSnackbar.buildSnackbar(AppColors.ERROR, "Hatalı giriş.",context));
    }
  }
}
