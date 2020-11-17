import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/utility_widgets.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.BG_WHITE,
        appBar: UtilityWidgets.CustomAppBar(
            Text("Profil Düzenleme",
                style: AppFonts.getMainFont(
                    color: AppColors.PRIMARY_COLOR,
                    fontSize: 25,
                    fontWeight: FontWeight.w500)),
            null),
        body: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          pickNewImage();
                        },
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 4, color: AppColors.WHITE),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(context.watch<RegistrationPageVM>().currentUser.profilePicture != null ? context.watch<RegistrationPageVM>().currentUser.profilePicture : "assets/images/avatar.jpg"))),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 4, color: AppColors.WHITE),
                              color: AppColors.PRIMARY_COLOR,
                            ),
                            child: Icon(Icons.edit, color: Colors.white),
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 35),
                buildTextField("Ad ve Soyad",context.watch<RegistrationPageVM>().currentUser.name, context),
                buildTextField("E-Posta", context.watch<RegistrationPageVM>().currentUser.email,context),
                buildTextField("Telefon", context.watch<RegistrationPageVM>().currentUser.phone, context),
                SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    /*OutlineButton(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        onPressed: () {},
                    child : Text("Sıfırla", style: AppFonts.getMainFont(fontSize: 14, letterSpacing: 2.2, color: Colors.black))
                    ),*/
                    RaisedButton(
                        onPressed: () {
                          context.read<RegistrationPageVM>().updateUser(context.read<RegistrationPageVM>().userName,context.read<RegistrationPageVM>().currentUser.email, context.read<RegistrationPageVM>().phone);
                        },
                      color: AppColors.PRIMARY_COLOR,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 2,
                    child: Text("Kaydet", style: AppFonts.getMainFont(fontSize: 14, letterSpacing: 2.2, color: AppColors.WHITE)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 35),
      child: TextField(
        onChanged: (value) {
          switch(labelText) {
            case "Ad ve Soyad":
             context.read<RegistrationPageVM>().setUserName(value);
             break;
            case "Telefon":
              context.read<RegistrationPageVM>().setPhone(value);
              break;
            default:
              break;
          }
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: AppFonts.getMainFont(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
      ),
    );
  }

  pickNewImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    String downloadUrl;
    if (pickedFile != null) {
      downloadUrl = await context
          .read<AdminPanelVM>()
          .uploadFile(pickedFile.path, "${context.watch<RegistrationPageVM>().currentUser.email}", 'user');
    }
  }
}
