import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/main_page_vm.dart';
import 'package:locally_flutter_app/views/main.dart';
import 'package:locally_flutter_app/views/widgets/fade_indexed_stack.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.1,
            backgroundColor: AppColors.PRIMARY_COLOR,
            title: Text(
              'Localy',
              style: AppFonts.getMainFont(color: AppColors.WHITE),
            ),
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
                    accountName: Text('Kullanıcı', style: AppFonts.getMainFont()),
                    accountEmail: Text('kullanici@gmail.com',
                        style: AppFonts.getMainFont()), currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: AppColors.GREY,
                    child: Icon(Icons.person, color: AppColors.WHITE),
                  ),
                ),
                  decoration: BoxDecoration(
                    color: AppColors.PRIMARY_COLOR,
                  )
                ),
                // body
                buildListElement('Ana Sayfa', Icons.home, AppColors.PRIMARY_COLOR),
                buildListElement('Hesabım', Icons.person, AppColors.PRIMARY_COLOR),
                buildListElement('Siparişlerim', Icons.shopping_basket, AppColors.PRIMARY_COLOR),
                buildListElement('Kategoriler', Icons.dashboard, AppColors.PRIMARY_COLOR),
                buildListElement("Favorilerim", Icons.favorite, AppColors.RED),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                buildListElement("Ayarlar", Icons.settings, AppColors.BLUE),
                buildListElement("Hakkımızda", Icons.help, AppColors.GREEN),
              ],
            ),
          ),
          body: FadeIndexedStack(
            index: context.watch<MainPageVM>().currentSelectedIndex,
            children: [
              Main(),
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
          case "Giriş":
            context.read<MainPageVM>().setCurrentSelectedIndex(1);
            break;
        }
      },
      child: ListTile(
          title: Text(text, style: AppFonts.getMainFont()), leading: Icon(icontype, color: iconColor)),
    );
  }
}
