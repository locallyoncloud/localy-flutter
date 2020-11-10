import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/utility_widgets.dart';
import 'package:locally_flutter_app/views/admin_page/all_customers_page/customer_list_tab.dart';

class Customers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: UtilityWidgets.CustomAppBar(
              Text(
                "Tüm Müşteriler",
                style: AppFonts.getMainFont(
                    color: AppColors.PRIMARY_COLOR,
                    fontSize: 17,
                    fontWeight: FontWeight.w700),
              ),
              TabBar(
                tabs: [
                  Tab(icon: Icon(AntDesign.gift,color: AppColors.PRIMARY_COLOR,)),
                  Tab(icon: Icon(Foundation.dollar_bill,color: AppColors.PRIMARY_COLOR,)),
                  Tab(icon: Icon(Ionicons.md_star,color: AppColors.PRIMARY_COLOR,)),
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
