import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';

class CustomAppBar extends StatelessWidget {
  Widget centerWidget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 10,
      backgroundColor: AppColors.WHITE,
      centerTitle: true,
      title: centerWidget,
    );
  }
}

