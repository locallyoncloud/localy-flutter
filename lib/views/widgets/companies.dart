import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/enums/order_type.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/cart_page_vm.dart';
import 'package:locally_flutter_app/view_models/company_details_page_vm.dart';
import 'package:locally_flutter_app/view_models/home_page_vm.dart';
import 'package:locally_flutter_app/views/company_details_page/company_logo.dart';

import 'package:locally_flutter_app/views/widgets/logo.dart';
import 'package:provider/provider.dart';
import '../company_details_page/company_details.dart';

class Companies extends StatefulWidget {
  @override
  _CompaniesState createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> {
  ScrollController _controller;
  var companyFuture;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      context.read<HomePageVM>().setCarouselVisibility(_controller.offset>70 ? true : false );
    });
    companyFuture = context.read<HomePageVM>().getCompanyList();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return FutureBuilder(
      future: companyFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Company>> snapshot) {
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(backgroundColor: AppColors.PRIMARY_COLOR,),
          );
        }else{
          return GridView.builder(
              itemCount: snapshot.data.length,
              controller: _controller,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 50.wb, crossAxisSpacing: 10, mainAxisSpacing: 10), itemBuilder: (BuildContext context, int index) {
            return Hero(
              tag: "${index}",
              child: Material(
                child: CompanyLogo(
                  isNetworkImage: true,
                  company: snapshot.data[index],
                  onClick: () => goCompanyDetails(
                    snapshot.data[index],
                    index
                  ),
                ),
              ),
            );
          });
        }
      },
    );
  }
  goCompanyDetails(Company company, int index){
    context.read<CompanyDetailsPageVM>().setSelectedTab(0);
    context.read<CartPageVM>().setCurrentOrderType(OrderType.home);
    context.read<CompanyDetailsPageVM>().setCurrentCompany(company);
    Get.to(CompanyDetails(index: index,));
  }
}
