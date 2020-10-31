import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/company_details_page_vm.dart';
import 'package:locally_flutter_app/views/company_details_page/bottom_tabs.dart';
import 'package:locally_flutter_app/views/company_details_page/loyalty_tab.dart';
import 'package:locally_flutter_app/views/company_details_page/menu_tab/menu_tab.dart';

import 'package:provider/provider.dart';

class CompanyDetails extends StatefulWidget {
  Company company;
  int index;

  CompanyDetails({this.company, this.index});

  @override
  _CompanyDetailsState createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  PageController tabsPageController = PageController();

  @override
  void dispose() {
    tabsPageController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    ScreenSize.recalculate(context);
    return Scaffold(
      backgroundColor: AppColors.BG_WHITE,
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: AppColors.PRIMARY_COLOR,
          title: Text(
            context.watch<CompanyDetailsPageVM>().currentCompany.name,
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PageView(
                controller: tabsPageController,
                onPageChanged: (num) {
                  context.read<CompanyDetailsPageVM>().setSelectedTab(num);
                },
                children: [
                  LoyaltyTab(widget.index),
                  MenuTab(company: widget.company,),
                ],
              ),
            ),
            BottomTabs(animatePage:(index)=>animateToPage(index) ,)
          ],
        )
    );
  }
  animateToPage(int index){
    tabsPageController.animateToPage(index, duration: Duration(milliseconds: 500),curve: Curves.ease);
  }
}
