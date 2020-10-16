import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';

class CompanyDetails extends StatelessWidget {
  final companyDetailName;
  final companyDetailLogo;

  CompanyDetails({this.companyDetailName, this.companyDetailLogo});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: AppColors.PRIMARY_COLOR,
          title: Text(
            'Localy',
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
          children: [
            Center(
              child: Container(
                height: 200,
                child: Image.asset(companyDetailLogo, fit: BoxFit.contain)
              ),
            )
          ],
        )
      ),
    );
  }
}
