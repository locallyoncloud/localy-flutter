import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:supercharged/supercharged.dart';
import 'package:provider/provider.dart';

class RegistrationTabs extends StatefulWidget {
  bool isSignInSelected;
  Color activeColor, passiveColor;
  double tabsWidth;
  Function onTabChange;

  @override
  _RegistrationTabsState createState() => _RegistrationTabsState();

  RegistrationTabs({this.tabsWidth ,this.isSignInSelected, this.passiveColor = Colors.green, this.activeColor = Colors.red, this.onTabChange});
}

class _RegistrationTabsState extends State<RegistrationTabs> {
  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedPositioned(
          duration: 0.2.seconds,
          left: !widget.isSignInSelected ? 0 : widget.tabsWidth / 2,
          child: Container(
            width: widget.tabsWidth / 2,
            height: 44,
            decoration: BoxDecoration(
                color: widget.passiveColor,
                borderRadius: BorderRadius.all(Radius.circular(4))),
          ),
        ),
        Container(
          height: 44,
          width: widget.tabsWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                    widget.onTabChange(0);
                },
                child: Container(
                  width: widget.tabsWidth / 2,
                  height: 36,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: widget.passiveColor.withOpacity(0.4), width: 2),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          bottomLeft: Radius.circular(6))),
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: 0.3.seconds,
                      style: !widget.isSignInSelected
                          ? TextStyle(
                          fontSize: 14,
                          color: widget.activeColor,
                          fontWeight: FontWeight.w800)
                          : TextStyle(
                          fontSize: 14,
                          color: widget.passiveColor,
                          fontWeight: FontWeight.w800),
                      child: Text("Üye Ol"),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                    widget.onTabChange(1);

                },
                child: Container(
                  width: widget.tabsWidth / 2,
                  height: 36,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: widget.passiveColor.withOpacity(0.4), width: 2),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(6),
                          bottomRight: Radius.circular(6))),
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: 0.3.seconds,
                      style: widget.isSignInSelected
                          ? TextStyle(
                          fontSize: 14,
                          color: widget.activeColor,
                          fontWeight: FontWeight.w800)
                          : TextStyle(
                          fontSize: 14,
                          color: widget.passiveColor,
                          fontWeight: FontWeight.w800),
                      child: Text("Giriş"),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
