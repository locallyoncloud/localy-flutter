import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/user_profile_page/edit_profile.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                    children:[
                      Container(
                        height: 100,
                        width: 100,
                        margin: EdgeInsets.only(top: 30),
                        child: Stack(
                            children: [
                              CircleAvatar(radius: 50, backgroundImage: AssetImage('assets/images/avatar.jpg')),
                            ]),
                      ),
                      SizedBox(height: 20),
                      Text(context.watch<RegistrationPageVM>().currentUser.name, style: AppFonts.getMainFont()),
                      SizedBox(height: 5),
                      Text(context.watch<RegistrationPageVM>().currentUser.email, style: AppFonts.getMainFont()),
                      SizedBox(height: 20),
                    ]
                ),
              ),
            ],
          ),
          Expanded(child: ListView(
            children: [
              InkWell(
                onTap:()=>{
                  Get.to(EditProfile())
                },
                child: ProfileListItem(
                  icon: LineAwesomeIcons.user,
                  text: 'Kişisel Bilgiler',
                ),
              ),
              /*ProfileListItem(
                icon: LineAwesomeIcons.user_shield,
                text: 'Gizli Bilgiler',
              ),
              ProfileListItem(
                icon: LineAwesomeIcons.history,
                text: 'Satın Alma Geçmişi',
              ),
              ProfileListItem(
                icon: LineAwesomeIcons.question_circle,
                text: 'Yardım & Destek',
              ),
              ProfileListItem(
                icon: LineAwesomeIcons.user_plus,
                text: 'Arkadaşınızı Davet Edin',
              ),*/
              ProfileListItem(
                icon: LineAwesomeIcons.alternate_sign_out,
                text: 'Oturumu Kapatın',
                hasNavigation: false,
              )
            ],
          ))
        ],
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final text;
  final bool hasNavigation;

  const ProfileListItem({Key key, this.icon, this.text, this.hasNavigation=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: 40).copyWith(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black12
      ),
      child: Row(
        children: [
          Icon(
            this.icon,
            size: 25,
          ),
          SizedBox(width: 25),
          Text(this.text, style: AppFonts.getMainFont(fontWeight: FontWeight.w500)),
          Spacer(),
          if(this.hasNavigation)
          Icon(
            LineAwesomeIcons.angle_right,
            size: 25,
          )
        ],
      ),
    );
  }
}
