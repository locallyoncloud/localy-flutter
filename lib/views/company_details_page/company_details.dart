import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/utilities/utility_widgets.dart';
import 'package:locally_flutter_app/view_models/company_details_page_vm.dart';
import 'package:locally_flutter_app/views/company_details_page/bottom_tabs.dart';
import 'package:locally_flutter_app/views/company_details_page/loyalty_tab.dart';
import 'package:locally_flutter_app/views/company_details_page/menu_tab/menu_tab.dart';
import 'package:provider/provider.dart';

class CompanyDetails extends StatefulWidget {

  int index;

  CompanyDetails({this.index});

  @override
  _CompanyDetailsState createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  PageController tabsPageController;

  @override
  void initState() {
    super.initState();
    tabsPageController = PageController(initialPage: context.read<CompanyDetailsPageVM>().selectedTab);
  }

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
        appBar:UtilityWidgets.CustomAppBar(Text(
          context.watch<CompanyDetailsPageVM>().currentCompany.name,
          style: TextStyle(
            color: AppColors.PRIMARY_COLOR,
            fontSize: 17,
            fontWeight: FontWeight.w700
          ),
        ), null),
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
                  ///Hero animasyonu için index gönderiyoruz.
                  LoyaltyTab(widget.index),
                  MenuTab(),
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
