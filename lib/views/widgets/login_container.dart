import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/views/main_page.dart';
import 'package:locally_flutter_app/views/widgets/registration_textfield.dart';

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
          ),
          SizedBox(
            height: 2.hb,
          ),
          RegistrationTextfield(
            placeholder: "Şifre",
            iconData: MaterialCommunityIcons.textbox_password,
            iconColor: AppColors.WHITE,
            hideText: true,
          ),
          SizedBox(
            height: 3.hb,
          ),
          InkWell(
            onTap: (){
              Get.off(MainPage());
            },
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
                    "Giriş",
                    style: AppFonts.getMainFont(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColors.WHITE),
                  ),
                  Padding(padding: EdgeInsets.only(left: 5),
                    child: Icon(
                      Ionicons.md_log_in,
                      color: AppColors.WHITE,
                    ),
                  )
                ],
              )
            ),
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
}
