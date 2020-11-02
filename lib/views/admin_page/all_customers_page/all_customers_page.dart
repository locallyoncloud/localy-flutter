import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/views/admin_page/all_customers_page/customer_list_tab.dart';

class AllCustomersPage extends StatelessWidget {
  @override  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              elevation: 0.1,
              backgroundColor: AppColors.PRIMARY_COLOR,
              title: Text(
                "Tüm Müşteriler",
                style: AppFonts.getMainFont(color: AppColors.WHITE),
              ),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(AntDesign.gift)),
                  Tab(icon: Icon(Foundation.dollar_bill)),
                  Tab(icon: Icon(Ionicons.md_star)),
                ],
              ),
            ),
            body: TabBarView(children: [
              CustomerListTab(0),
              CustomerListTab(1),
              CustomerListTab(2)
            ])),
      ),
    );
  }
}
