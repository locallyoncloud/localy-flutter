import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/models/public_profile.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/main_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/admin_page/admin_panel.dart';
import 'package:locally_flutter_app/views/registration_page/registration.dart';
import 'package:locally_flutter_app/views/widgets/fade_indexed_stack.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'home.dart';


class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.BG_WHITE,
          appBar: AppBar(
            elevation: 0.1,
            backgroundColor: AppColors.PRIMARY_COLOR,
            centerTitle: true,
            title: Image.asset("assets/png/localy_white_logo.png",fit: BoxFit.contain, width: 132, height: 40),
            actions: [
              IconButton(
                  icon: Icon(Icons.search, color: AppColors.WHITE),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.shopping_cart, color: AppColors.WHITE),
                  onPressed: () {})
            ],
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                // header
                UserAccountsDrawerHeader(
                    accountName:
                        Text(context.watch<RegistrationPageVM>().currentUser.name ?? '', style: AppFonts.getMainFont()),
                    accountEmail: Text(context.watch<RegistrationPageVM>().currentUser.email,
                        style: AppFonts.getMainFont()),
                    currentAccountPicture: GestureDetector(
                      child: CircleAvatar(
                        backgroundColor: AppColors.GREY,
                        child: Icon(Icons.person, color: AppColors.WHITE),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.PRIMARY_COLOR,
                    )),
                // body
                buildListElement(
                    'Ana Sayfa', Icons.home, AppColors.PRIMARY_COLOR),
                buildListElement(
                    'Hesabım', Icons.person, AppColors.PRIMARY_COLOR),
                buildListElement('Siparişlerim', Icons.shopping_basket,
                    AppColors.PRIMARY_COLOR),
                buildListElement(
                    'Kategoriler', Icons.dashboard, AppColors.PRIMARY_COLOR),
                buildListElement("Favorilerim", Icons.favorite, AppColors.RED),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                context.watch<RegistrationPageVM>().currentUser.type =="admin" ? buildListElement("Admin", MaterialIcons.store_mall_directory, AppColors.ADMIN_GREY) : Container(),
                buildListElement("Hakkımızda", Icons.help, AppColors.GREEN),
                buildListElement("Çıkış", AntDesign.logout, AppColors.ERROR),
              ],
            ),
          ),
          body: FadeIndexedStack(
            index: context.watch<MainPageVM>().currentSelectedIndex,
            children: [
              Home(),
              AdminPanel(),
            ],
          )),
    );
  }

  buildListElement(String text, IconData icontype, Color iconColor) {
    return InkWell(
      onTap: () {
        switch (text) {
          case "Ana Sayfa":
            context.read<MainPageVM>().setCurrentSelectedIndex(0);
            break;
          case "Giriş Yapın":
            context.read<MainPageVM>().setCurrentSelectedIndex(1);
            break;
          case "Çıkış":
            context.read<RegistrationPageVM>().signOut();
            Get.off(RegistrationPage());
            break;
          case "Admin":
            context.read<MainPageVM>().setCurrentSelectedIndex(1);
        }
        Get.back();
      },
      child: ListTile(
          title: Text(text, style: AppFonts.getMainFont()),
          leading: Icon(icontype, color: iconColor)),
    );
  }
}
