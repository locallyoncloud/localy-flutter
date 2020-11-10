
import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';

class UtilityWidgets{

  static  PreferredSizeWidget CustomAppBar(Widget centerWidget, PreferredSizeWidget bottom){
    return AppBar(
      elevation: 10,
      backgroundColor: AppColors.WHITE,
      centerTitle: true,
      title: centerWidget,
      bottom: bottom ?? null,
      iconTheme: IconThemeData(
        color: AppColors.PRIMARY_COLOR, //change your color here
      ),
    );
  }
}
