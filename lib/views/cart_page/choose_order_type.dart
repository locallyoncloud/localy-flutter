import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/view_models/cart_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/user_profile_page/add_address_dialog.dart';
import 'package:locally_flutter_app/views/widgets/custom_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

class ChooseOrderType extends StatefulWidget {
  @override
  _ChooseOrderTypeState createState() => _ChooseOrderTypeState();
}

class _ChooseOrderTypeState extends State<ChooseOrderType> {
  String orderPhase = "chooseOrder";
  AnimationController typeSelectionController;
  AnimationController comeGetController;

  @override
  void initState() {
    super.initState();
    print("GİRDİ!!");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CartPageVM>().setCurrentOrderAddress(context.read<RegistrationPageVM>().currentUser.address.length>0 ? context.read<RegistrationPageVM>().currentUser.address[0] : "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 100),
      child: renderContents(),
    );
  }

  renderContents() {
    switch (orderPhase) {
      case "chooseOrder":
        return FadeOut(
          manualTrigger: true,
          controller: (controller) => typeSelectionController = controller,
          child: Container(
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                renderTypeOption("assets/svg/hand_in.svg", "Gelip Alacağım"),
                Container(
                  height: 60,
                  width: 1,
                  color: AppColors.GREY,
                ),
                renderTypeOption("assets/svg/home_order.svg", "Eve Gelsin")
              ],
            ),
          ),
        );
      case "comeGetSelected":
        return FadeIn(
          manualTrigger: true,
          controller: (controller) => comeGetController = controller,
          child: InkWell(
            onTap: () {
              setState(() {
                orderPhase = "chooseOrder";
              });
            },
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppColors.PRIMARY_COLOR,
                          ),
                          onPressed: () {
                            setState(() {
                              orderPhase = "chooseOrder";
                            });
                          }),
                      Text(
                        "Geri Dön",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.PRIMARY_COLOR),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Siparişinizi kaç dakika sonra teslim almak istersiniz?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.GREY,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: DropdownWidget(
                      dropdownList: [
                        "5dk",
                        "10dk",
                        "15dk",
                        "20dk",
                        "25dk",
                        "30dk",
                        "35dk",
                        "40dk",
                        "45dk",
                        "50dk",
                        "55dk",
                        "60dk"
                      ],
                      onChange: (value) => context.read<CartPageVM>().setCurrentOrderDeliveryTime(value),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      case "homeOrderSelected":
        return FadeIn(
          manualTrigger: true,
          controller: (controller) => comeGetController = controller,
          child: InkWell(
            onTap: () {
              setState(() {
                orderPhase = "chooseOrder";
              });
            },
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget> [
                      Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: AppColors.PRIMARY_COLOR,
                              ),
                              onPressed: () {
                                setState(() {
                                  orderPhase = "chooseOrder";
                                });
                              }),
                          Text(
                            "Geri Dön",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.PRIMARY_COLOR),
                          )
                        ],
                      ),
                    ] +
                    renderAddress(),
              ),
            ),
          ),
        );
    }
  }

  renderTypeOption(String imagePath, String text) {
    return Expanded(
      child: InkWell(
        onTap: () => selectOrderType(text == "Gelip Alacağım" ? "Gel Al Sipariş": "Paket Servis Sipariş"),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              imagePath,
              color: AppColors.GREY,
              width: 40,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 14,
                  color: AppColors.GREY,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }

  renderAddress() {
    return context.watch<RegistrationPageVM>().currentUser.address.length == 0
        ? [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Kayıtlı adresiniz bulunmamaktadır. Adres eklemek istermisiniz?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.GREY,
                    decoration: TextDecoration.underline),
              ),
            ),
      SizedBox(
        height: 10,
      ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () => openAddAddressDialog(context),
                child: Text(
                  "Evet",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: AppColors.SUCCESS_GREEN,
                      ),
                ),
              ),
            )
          ]
        : [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Siparişinize hangi adresinize getirelim?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.GREY,
                    decoration: TextDecoration.underline),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: DropdownWidget(
                dropdownList: context.watch<RegistrationPageVM>().currentUser.address.map((e) => e.name).toList(),
                onChange: (value) => context.read<CartPageVM>().setCurrentOrderAddress(context.read<RegistrationPageVM>().currentUser.address.where((element) => element.name == value).first),
              ),
            )
          ];
  }

  selectOrderType(String text) {
    typeSelectionController.forward();
    context.read<CartPageVM>().setOrderDeliveryType(text);
    if (text == "Gel Al Sipariş") {
      Timer(0.3.seconds, () {
        setState(() {
          orderPhase = "comeGetSelected";
        });
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          comeGetController.forward();
        });
      });
    } else {
      Timer(0.3.seconds, () {
        setState(() {
          orderPhase = "homeOrderSelected";
        });
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          comeGetController.forward();
        });
      });
    }
  }

  openAddAddressDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => AddAddressDialog()).then((value) => WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CartPageVM>().setCurrentOrderAddress(context.read<RegistrationPageVM>().currentUser.address.length>0 ? context.read<RegistrationPageVM>().currentUser.address[0] : "");
    }));
  }
}
