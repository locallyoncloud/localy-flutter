import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/widgets/animated_down_arrow.dart';
import 'package:locally_flutter_app/views/widgets/number_picker.dart';
import 'package:locally_flutter_app/views/widgets/snackbar.dart';
import 'package:locally_flutter_app/views/widgets/switching_button.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

class CustomerInfo extends StatefulWidget {

  @override
  _CustomerInfoState createState() => _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> {
  bool isExpanded;
  double cardHeight;
  double listOpacity;
  int textValue = 0;
  LoyaltyProgress customerProgress;
  int pickedNumber;
  double doubleProgress;
  bool resetPicker = false;


  @override
  void initState() {
    super.initState();
    isExpanded = true;
    cardHeight = 32.hb;
    listOpacity = 0;
    pickedNumber = 1;
    doubleProgress = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    customerProgress = Provider.of<LoyaltyProgress>(context);
    return customerProgress == null
        ? CircularProgressIndicator()
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: 300.milliseconds,
                height: cardHeight,
                constraints: BoxConstraints(maxWidth: 450),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Müşteri mail adresi",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.PRIMARY_COLOR),
                        ),
                        Text(
                          "${ context
                              .watch<AdminPanelVM>()
                              .lastReadAdminQrCode
                              .split("/")[0]}",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.PRIMARY_COLOR),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            renderMiniColumn(
                                customerProgress.progress.round() > 0
                                    ? Entypo.progress_two
                                    : Entypo.progress_empty,
                                customerProgress.progress.round().toString()),
                            renderMiniColumn(Feather.target, context
                                .watch<AdminPanelVM>()
                                .lastReadAdminQrCode
                                .split("/")[2]),
                            renderMiniColumn(AntDesign.gift,
                                customerProgress.gifts.toString())
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                              togglePushDatesVisibility();
                            },
                            child: AnimatedDownArrow(
                              AppColors.PRIMARY_COLOR,
                              closedText: "Kapat",
                              openedText: "Önceki Okumaları Göster",
                              isExpanded: isExpanded,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        AnimatedOpacity(
                          duration: 300.milliseconds,
                          opacity: listOpacity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tarih",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.PRIMARY_COLOR),
                              ),
                              Text(
                                "Saat",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.PRIMARY_COLOR),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: AnimatedOpacity(
                            duration: 300.milliseconds,
                            opacity: listOpacity,
                            child: ListView.builder(
                              itemCount: customerProgress.pushDates.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        customerProgress.pushDates.reversed
                                            .toList()[index]
                                            .split(" ")[0],
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.PRIMARY_COLOR),
                                      ),
                                      Text(
                                        customerProgress.pushDates.reversed
                                            .toList()[index]
                                            .split(" ")[1],
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.PRIMARY_COLOR),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      renderAddLoyalty(),
                      SizedBox(
                        height: 10,
                      ),
                      Builder(
                        builder: (BuildContext context) =>
                            RaisedButton(
                              onPressed: (){
                                add(context);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              color: AppColors.PRIMARY_COLOR,
                              child: Text(
                                "Onay",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.WHITE
                                ),
                              ),
                            )
                        ,
                      )
                    ],
                  ),
                  ChangingButton(
                    primaryColor: AppColors.PRIMARY_COLOR,
                    isDisabled: customerProgress.gifts > 0 ? false : true,
                    maxNumber: customerProgress.gifts,
                    approveFunction: () => giveGifts(),
                    cardType: int.parse(context.watch<AdminPanelVM>().lastReadAdminQrCode.split("/")[1]),
                    textOnchange: (value) {
                      textValue = int.parse(value);
                    },
                  )
                ],
              ),
            ],
          );
  }

  renderAddLoyalty(){
    if(int.parse(context.watch<AdminPanelVM>().lastReadAdminQrCode.split("/")[1]) == 0){
      return NumberPicker(
        onChange: (value){
          pickedNumber = value;
        },
        reset: resetPicker,
      );
    }else{
      return Container(
          width: 100,
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              suffixIcon: Text(
                "₺",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.PRIMARY_COLOR
                ),
              ),
            ),
            onChanged: (value){
              doubleProgress = double.parse(value);
            },
          )
      );
    }
  }

  add(BuildContext context) async {
    await context.read<AdminPanelVM>().addLoyalty(
        context.read<AdminPanelVM>().lastReadAdminQrCode,
        context.read<RegistrationPageVM>().currentUser.company_id,
        pickedNumber,
        doubleProgress
    );
    setState(() {
      resetPicker = !resetPicker;
    });
    Scaffold.of(context).showSnackBar(CustomSnackbar.buildSnackbar(AppColors.SUCCESS_GREEN, "Müşteriye loyalty başarıyla eklendi!!!",context));
  }

  giveGifts(){
    context.read<AdminPanelVM>().sendGift(
      int.parse(context.read<AdminPanelVM>().lastReadAdminQrCode.split("/")[1]) == 0 ?
      (customerProgress.gifts -textValue)<0 ? 0 :(customerProgress.gifts -textValue) : (customerProgress.progress - textValue),
      context.read<RegistrationPageVM>().currentUser.company_id,
      int.parse(context
        .read<AdminPanelVM>()
        .lastReadAdminQrCode
        .split("/")[1]), customerProgress.mail,);
  }

  renderMiniColumn(IconData iconData, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          iconData,
          color: AppColors.PRIMARY_COLOR,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.PRIMARY_COLOR),
        )
      ],
    );
  }

  togglePushDatesVisibility() {
    if (!isExpanded) {
      setState(() {
        cardHeight = 50.hb;
      });
      Timer(0.35.seconds, () {
        setState(() {
          listOpacity = 1;
        });
      });
    } else {
      setState(() {
        listOpacity = 0;
      });
      Timer(0.35.seconds, () {
        setState(() {
          cardHeight = 32.hb;
        });
      });
    }
  }
}
