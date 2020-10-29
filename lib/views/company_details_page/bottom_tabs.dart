import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/company_details_page_vm.dart';
import 'package:provider/provider.dart';

class BottomTabs extends StatelessWidget {
  final PageController tabsPageController;

  BottomTabs(this.tabsPageController);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.PRIMARY_COLOR.withOpacity(0.2),
              spreadRadius: 1.0,
              blurRadius: 30.0,
            )
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabButton(
              icon: MaterialIcons.loyalty,
              iconText: "Loyalty",
              isSelected: context.watch<CompanyDetailsPageVM>().selectedTab == 0 ? true : false,
              onPressed: () {
                context.read<CompanyDetailsPageVM>().setSelectedTab(0);
                tabsPageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
              }),
          BottomTabButton(
            icon: MaterialIcons.library_books,
            iconText: "Menü",
            isSelected: context.watch<CompanyDetailsPageVM>().selectedTab == 1 ? true : false,
            onPressed: () {
              context.read<CompanyDetailsPageVM>().setSelectedTab(1);
              tabsPageController.animateToPage(1, duration: Duration(milliseconds: 500),curve: Curves.ease);
            },
          ),
        ],
      ),
    );
  }
}


class BottomTabButton extends StatelessWidget {
  final IconData icon;
  final String iconText;
  final bool isSelected;
  final Function onPressed;

  BottomTabButton({this.icon, this.iconText, this.isSelected, this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool _isSelected = isSelected ?? false;
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: _isSelected ? AppColors.PRIMARY_COLOR : Colors.transparent,
              width: 2.0
            )
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon, size: 25, color: _isSelected ? AppColors.PRIMARY_COLOR : AppColors.GREY),
            Text(iconText, style: AppFonts.getMainFont(color: AppColors.GREY, fontSize: 14, fontWeight: FontWeight.w700))
          ],
        ),
      ),
    );
  }
}