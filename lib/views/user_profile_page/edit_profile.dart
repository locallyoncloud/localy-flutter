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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<RegistrationPageVM>().setUser(false);
    });
  }
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.BG_WHITE,
        appBar: UtilityWidgets.CustomAppBar(
            Text("Profil Düzenleme",
                style: TextStyle(
                    color: AppColors.PRIMARY_COLOR,
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
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
                                  image: NetworkImage( context.watch<RegistrationPageVM>().tempUser.profilePicture !=null && context.watch<RegistrationPageVM>().tempUser.profilePicture.length !=0  ? context.watch<RegistrationPageVM>().tempUser.profilePicture
                                      : "https://firebasestorage.googleapis.com/v0/b/localy-d8280.appspot.com/o/localy_logo_white_bg.jpg?alt=media&token=25f202fe-9bd7-402c-8269-9682a54f5505"))),
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
                buildTextField("Ad ve Soyad",context.watch<RegistrationPageVM>().tempUser.name, context),
                buildTextField("E-Posta", context.watch<RegistrationPageVM>().tempUser.email,context),
                buildTextField("Telefon", context.watch<RegistrationPageVM>().tempUser.phone, context),
                SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    RaisedButton(
                        onPressed: () {
                          context.read<RegistrationPageVM>().updateUser(context.read<RegistrationPageVM>().userName,context.read<RegistrationPageVM>().currentUser.email, context.read<RegistrationPageVM>().phone, context.read<RegistrationPageVM>().tempUser.profilePicture);
                          context.read<RegistrationPageVM>().setUser(true);
                          },
                      color: AppColors.PRIMARY_COLOR,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 2,
                    child: Text("Kaydet", style: TextStyle(fontSize: 14, letterSpacing: 2.2, color: AppColors.WHITE)),
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
             context.read<RegistrationPageVM>().setCredentials("name", value);
             break;
            case "Telefon":
              context.read<RegistrationPageVM>().setCredentials("phone", value);
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
            hintStyle: TextStyle(
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
          .uploadFile(pickedFile.path, "${context.read<RegistrationPageVM>().currentUser.email}", 'user');
      context.read<RegistrationPageVM>().setCredentials("profilePicture", downloadUrl);

    }
  }
}
