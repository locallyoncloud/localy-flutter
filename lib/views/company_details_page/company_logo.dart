import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/company_details_page_vm.dart';
import 'package:locally_flutter_app/view_models/home_page_vm.dart';
import 'package:provider/provider.dart';

class CompanyLogo extends StatelessWidget {
  final bool isNetworkImage;
  final Company company;
  final double width;
  final VoidCallback onClick;

  CompanyLogo(
      {this.company, this.isNetworkImage = true, this.width, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0x14000000),
              offset: Offset(-1.0409498114625029e-15, 17),
              blurRadius: 59,
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned.fill(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage.assetNetwork(
                placeholder: "assets/gif/loading_placeholder.gif",
                image: company.logo,
                fit: BoxFit.cover,
              ),
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 33,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Center(
                  child: Text(
                    company.name,
                    style: TextStyle(
                        fontWeight: FontWeight.w900, color: AppColors.GREY),
                  ),
                ),
              ),
            ),
            company.orderType == "home" || company.orderType == "home/table"
                ? Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 60,
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.motorcycle,
                            color: AppColors.GREY,
                            size: 26,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: context
                                          .watch<CompanyDetailsPageVM>()
                                          .isAvailableForService(
                                              context
                                                  .watch<HomePageVM>()
                                                  .currentPosition,
                                              Position(
                                                  latitude: double.parse(
                                                      company.location.lat),
                                                  longitude: double.parse(
                                                      company.location.long)),
                                              company.maxOrderDistance)
                                      ? AppColors.SUCCESS_GREEN.withOpacity(0.7)
                                      : AppColors.ERROR.withOpacity(0.7),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20))),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                      text:
                                          "${company.maxOrderDistance / 1000}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.WHITE,
                                          fontWeight: FontWeight.w900),
                                      children: [
                                        TextSpan(
                                            text: "km",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: AppColors.WHITE,
                                                fontWeight: FontWeight.w700))
                                      ]),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
