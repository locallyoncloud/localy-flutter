import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/utility_widgets.dart';
import 'package:locally_flutter_app/view_models/cart_page_vm.dart';
import 'package:locally_flutter_app/view_models/home_page_vm.dart';
import 'package:locally_flutter_app/view_models/main_page_vm.dart';
import 'package:locally_flutter_app/view_models/notifications_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/admin_page/admin_panel.dart';
import 'package:locally_flutter_app/views/admin_page/admin_show_orders_page/admin_show_orders.dart';
import 'package:locally_flutter_app/views/cart_page/cart_main.dart';
import 'package:locally_flutter_app/views/info_page/info.dart';
import 'package:locally_flutter_app/views/push_notification_page/push_notifications.dart';
import 'package:locally_flutter_app/views/registration_page/registration.dart';
import 'package:locally_flutter_app/views/user_profile_page/user_profile.dart';
import 'package:locally_flutter_app/views/widgets/fade_indexed_stack.dart';
import 'package:locally_flutter_app/views/widgets/loading_bar.dart';
import 'package:locally_flutter_app/views/widgets/main_bottom_navigation.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  StreamSubscription<Position> positionStream;
  @override
  void initState() {
    context.read<RegistrationPageVM>().checkUserPlayerId(context.read<NotificationsVM>().currentUserId);
    tabController = TabController(length:context.read<RegistrationPageVM>().currentUser.type != "admin" ? 3 : 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      positionStream = context.read<HomePageVM>().listenLocationChanges();
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    positionStream.cancel();
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
                      labelStyle: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w700),
                      tabs: context.watch<RegistrationPageVM>().currentUser.type != "admin" ? [
                          Tab(text: "Sepetim"),
                          Tab(text: "Aktif Siparişler"),
                          Tab(text: "Önceki Siparişlerim"),
                        ]
                :[
                        Tab(text: "Aktif Siparişler"),
                        Tab(text: "Önceki Siparişler"),
                      ]
              )
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
                          style: TextStyle()),
                      accountEmail: Text(
                          context.watch<RegistrationPageVM>().currentUser.email,
                          style: TextStyle()),
                      currentAccountPicture: GestureDetector(
                        child: CircleAvatar(
                          backgroundColor: AppColors.GREY,
                          child: context.watch<RegistrationPageVM>().currentUser.profilePicture != null ? ClipOval(child: Image.network(context.watch<RegistrationPageVM>().currentUser.profilePicture)): Icon(Icons.person, color: AppColors.WHITE),
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
            body: InkWell(
                onTap: (){
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if(!currentFocus.hasPrimaryFocus){
                    currentFocus.unfocus();
                  }
                },
              child: Column(
                children: [
                  Expanded(
                    child: FadeIndexedStack(
                      index: context.watch<MainPageVM>().currentSelectedIndex,
                      children: [
                        Home(),
                        context.watch<RegistrationPageVM>().currentUser.type != "admin"
                        ? StreamProvider(
                          create: (context) => context.read<HomePageVM>().getAllClientSideOrders(context.read<RegistrationPageVM>().currentUser.email),
                          child: CartMain(tabController))
                        : StreamProvider(
                          create: (context) => context.read<HomePageVM>().getAllAdminSideOrders(context.read<RegistrationPageVM>().currentUser.company_id),
                          child: AdminShowOrders(tabController),
                        ),

                        context.watch<RegistrationPageVM>().currentUser.type != "admin"
                        ? ProfileScreen()
                        : AdminPanel(),

                        context.watch<RegistrationPageVM>().currentUser.type != "admin"
                        ? Info()
                        : PushNotifications(),
                      ],
                    ),
                  ),
                  BottomNavigation()
                ],
              ),
            )),
    ));
  }

  buildListElement(String text, IconData icontype, Color iconColor) {
    return InkWell(
      onTap: () {
        switch (text) {
          case "Giriş Yapın":
            context.read<MainPageVM>().setCurrentSelectedIndex(1);
            break;
          case "Çıkış":
            context.read<RegistrationPageVM>().signOut();
            context.read<CartPageVM>().clearCart();
            Get.offAll(RegistrationPage());
            break;
          case "Admin":
            context.read<MainPageVM>().setCurrentSelectedIndex(2);
        }
        Get.back();
      },
      child: ListTile(
          title: Text(text, style: TextStyle()),
          leading: Icon(icontype, color: iconColor)),
    );
  }
}
