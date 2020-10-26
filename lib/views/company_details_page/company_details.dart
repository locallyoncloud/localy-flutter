import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/company_details_page_vm.dart';
import 'package:locally_flutter_app/views/company_details_page/bottom_tabs.dart';
import 'package:locally_flutter_app/views/company_details_page/loyalty_tab.dart';
import 'package:locally_flutter_app/views/company_details_page/menu_tab.dart';
import 'package:provider/provider.dart';

class CompanyDetails extends StatefulWidget {
  Company company;

  CompanyDetails({this.company});

  @override
  _CompanyDetailsState createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  PageController tabsPageController = PageController();


  @override
  Widget build(BuildContext context) {

    ScreenSize.recalculate(context);
    return Scaffold(
      backgroundColor: AppColors.BG_WHITE,
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: AppColors.PRIMARY_COLOR,
          title: Text(
            widget.company.name,
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
                  LoyaltyTab(company: widget.company,),
                  MenuTab(),
                ],
              ),
            ),
            BottomTabs(tabsPageController)
          ],
        )
    );
  }
}
