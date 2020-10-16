import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/views/widgets/logo.dart';

import '../company_details.dart';

class Companies extends StatefulWidget {
  @override
  _CompaniesState createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> {
  var companyList = [
    {
      "name": "Meet Lab Coffee",
      "logo": "assets/logos/meet_lab_logo.jpg",
    },
    {
      "name": "Meet Lab Coffee",
      "logo": "assets/logos/meet_lab_logo.jpg",
    },
    {
      "name": "Meet Lab Coffee",
      "logo": "assets/logos/meet_lab_logo.jpg",
    },
    {
      "name": "Meet Lab Coffee",
      "logo": "assets/logos/meet_lab_logo.jpg",
    },
    {
      "name": "Meet Lab Coffee",
      "logo": "assets/logos/meet_lab_logo.jpg",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: companyList.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, crossAxisSpacing: 10, mainAxisSpacing: 10), itemBuilder: (BuildContext context, int index) {
          return OvalLogo(
            isNetworkImage: false,
            bottomText: companyList[index]["name"],
            imagePath: companyList[index]["logo"],
            textStyle: AppFonts.getMainFont(fontWeight: FontWeight.w900, color: AppColors.GREY),
            onClick: () => Get.to(CompanyDetails(
              companyDetailName: companyList[index]["name"],
              companyDetailLogo: companyList[index]["logo"],
            )),
          );
    });
  }
}
