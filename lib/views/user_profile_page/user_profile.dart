import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/registration_page/registration.dart';
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
                              CircleAvatar(radius: 50, backgroundImage: NetworkImage(context.watch<RegistrationPageVM>().currentUser.profilePicture != null && context.watch<RegistrationPageVM>().currentUser.profilePicture.length != 0 ? context.watch<RegistrationPageVM>().currentUser.profilePicture : 'https://firebasestorage.googleapis.com/v0/b/localy-d8280.appspot.com/o/localy_logo_white_bg.jpg?alt=media&token=25f202fe-9bd7-402c-8269-9682a54f5505')),
                            ]),
                      ),
                      SizedBox(height: 20),
                      Text(context.watch<RegistrationPageVM>().currentUser.name != null ? context.watch<RegistrationPageVM>().currentUser.name: "", style: AppFonts.getMainFont()),
                      SizedBox(height: 5),
                      Text(context.watch<RegistrationPageVM>().currentUser.email != null ? context.watch<RegistrationPageVM>().currentUser.email : "", style: AppFonts.getMainFont()),
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
              InkWell(
                onTap: () {
                  context.read<RegistrationPageVM>().signOut();
                  Get.off(RegistrationPage());
                },
                child: ProfileListItem(
                  icon: LineAwesomeIcons.alternate_sign_out,
                  text: 'Oturumu Kapatın',
                  hasNavigation: false,
                ),
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
            LineAwesomeIcons.angle_double_up,
            size: 25,
          )
        ],
      ),
    );
  }
}
