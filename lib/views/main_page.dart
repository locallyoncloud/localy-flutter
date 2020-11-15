import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/models/order.dart';
import 'package:locally_flutter_app/models/public_profile.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/utility_widgets.dart';
import 'package:locally_flutter_app/view_models/home_page_vm.dart';
import 'package:locally_flutter_app/view_models/main_page_vm.dart';
import 'package:locally_flutter_app/view_models/notifications_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/admin_page/admin_panel.dart';
import 'package:locally_flutter_app/views/cart_page/cart_main.dart';
import 'package:locally_flutter_app/views/info_page/info.dart';
import 'package:locally_flutter_app/views/registration_page/registration.dart';
import 'package:locally_flutter_app/views/widgets/fade_indexed_stack.dart';
import 'package:locally_flutter_app/views/widgets/loading_bar.dart';
import 'package:locally_flutter_app/views/widgets/main_bottom_navigation.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'home.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    context.read<RegistrationPageVM>().checkUserPlayerId(context.read<NotificationsVM>().currentUserId);
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoadingBar(
        isLoadingVisible: context.watch<RegistrationPageVM>().isLoadingVisible,
        child: Scaffold(
            backgroundColor: AppColors.BG_WHITE,
            appBar: UtilityWidgets.CustomAppBar(
              Image.asset("assets/png/localy_logo_transparent_bg.png",
                  fit: BoxFit.contain, width: 132, height: 40),
              context.watch<MainPageVM>().currentSelectedIndex == 1
                  ? TabBar(
                      indicatorColor: AppColors.SECONDARY_COLOR,
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
                      controller: tabController,
                      unselectedLabelColor: AppColors.DISABLED_GREY,
                      labelColor: AppColors.SECONDARY_COLOR,
                      labelPadding: EdgeInsets.all(0),
                      labelStyle: AppFonts.getMainFont(
                          fontSize: 12, fontWeight: FontWeight.w700),
                      tabs: [
                          Tab(text: "Sepetim"),
                          Tab(text: "Aktif Siparişler"),
                          Tab(text: "Önceki Siparişlerim"),
                        ])
                  : null,
            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  // header
                  UserAccountsDrawerHeader(
                      accountName: Text(
                          context.watch<RegistrationPageVM>().currentUser.name ??
                              '',
                          style: AppFonts.getMainFont()),
                      accountEmail: Text(
                          context.watch<RegistrationPageVM>().currentUser.email,
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
                  context.watch<RegistrationPageVM>().currentUser.type == "admin"
                      ? buildListElement(
                          "Admin",
                          MaterialIcons.store_mall_directory,
                          AppColors.ADMIN_GREY)
                      : Container(),
                  buildListElement("Çıkış", AntDesign.logout, AppColors.ERROR),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: FadeIndexedStack(
                    index: context.watch<MainPageVM>().currentSelectedIndex,
                    children: [
                      Home(),
                      CartMain(tabController),
                      AdminPanel(),
                      Info(),
                    ],
                  ),
                ),
                GetirBottomNavigation()
              ],
            )),
      ),
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
            context.read<MainPageVM>().setCurrentSelectedIndex(2);
        }
        Get.back();
      },
      child: ListTile(
          title: Text(text, style: AppFonts.getMainFont()),
          leading: Icon(icontype, color: iconColor)),
    );
  }
}
