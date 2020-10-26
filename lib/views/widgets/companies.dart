import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/home_page_vm.dart';

import 'package:locally_flutter_app/views/widgets/logo.dart';
import 'package:provider/provider.dart';
import '../company_details_page/company_details.dart';

class Companies extends StatefulWidget {
  @override
  _CompaniesState createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> {
  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      context.read<HomePageVM>().setCarouselVisibility(_controller.offset>70 ? true : false );
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.watch<HomePageVM>().getCompanyList(),
      builder: (BuildContext context, AsyncSnapshot<List<Company>> snapshot) {
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(backgroundColor: AppColors.PRIMARY_COLOR,),
          );
        }else{
          return GridView.builder(
              itemCount: snapshot.data.length,
              controller: _controller,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, crossAxisSpacing: 10, mainAxisSpacing: 10), itemBuilder: (BuildContext context, int index) {
            return Hero(
              tag: "${index}asd",
              child: Material(
                child: OvalLogo(
                  isNetworkImage: true,
                  bottomText: snapshot.data[index].name,
                  imagePath: snapshot.data[index].logo,
                  textStyle: AppFonts.getMainFont(fontWeight: FontWeight.w900, color: AppColors.GREY),
                  onClick: () => Get.to(CompanyDetails(
                    company: snapshot.data[index],
                  )),
                ),
              ),
            );
          });
        }
      },
    );
  }
}
