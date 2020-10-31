import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/company_details_page_vm.dart';
import 'package:provider/provider.dart';

class BottomTabs extends StatefulWidget {
Function animatePage;

BottomTabs({this.animatePage});

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {

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
                widget.animatePage(0);
              }),
          BottomTabButton(
            icon: MaterialIcons.library_books,
            iconText: "Menü",
            isSelected: context.watch<CompanyDetailsPageVM>().selectedTab == 1 ? true : false,
            onPressed: () {
              context.read<CompanyDetailsPageVM>().setSelectedTab(1);
              widget.animatePage(1);
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