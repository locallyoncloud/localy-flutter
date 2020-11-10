import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/models/LoyaltyProgress.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/widgets/switching_button.dart';
import 'package:supercharged/supercharged.dart';
import 'package:provider/provider.dart';

class CustomerListItem extends StatefulWidget {
  LoyaltyProgress loyaltyProgress;
  int cardType;

  CustomerListItem(this.loyaltyProgress, this.cardType);

  @override
  _CustomerListItemState createState() => _CustomerListItemState();
}

class _CustomerListItemState extends State<CustomerListItem> {
  double itemHeight;
  double listOpacity = 0;
  int textValue = 0;

  @override
  void initState() {
    super.initState();
    itemHeight = widget.loyaltyProgress.pushDates.length>0 ? 100 : 70;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: 0.3.seconds,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: itemHeight,
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      widget.loyaltyProgress.mail.split("@")[0],
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.getMainFont(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.PRIMARY_COLOR),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Entypo.progress_two,
                        color: AppColors.PRIMARY_COLOR,
                      ),
                      Text(
                        widget.loyaltyProgress.progress.round().toString(),
                        style: AppFonts.getMainFont(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.PRIMARY_COLOR),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        AntDesign.gift,
                        color: AppColors.PRIMARY_COLOR,
                      ),
                      Text(
                        widget.loyaltyProgress.gifts.toString(),
                        style: AppFonts.getMainFont(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.PRIMARY_COLOR),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChangingButton(
                        primaryColor: AppColors.PRIMARY_COLOR,
                        isDisabled: widget.loyaltyProgress.gifts>0 ? false : true,
                        approveFunction: () => giveGifts(),
                        textOnchange: (value){
                          textValue = int.parse(value);
                        },
                      ),
                      Visibility(
                        visible: widget.loyaltyProgress.pushDates.length>0 ? true : false,
                        child: InkWell(
                          onTap: () => togglePushDatesVisibility(),
                          child: Text(
                            itemHeight ==100 ? "Göster" : "Gizle",
                            style: AppFonts.getMainFont(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.PRIMARY_COLOR),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Expanded(
                child: AnimatedOpacity(
                  opacity: listOpacity,
                  duration: 0.3.seconds,
                  child: ListView.builder(
                    itemCount: widget.loyaltyProgress.pushDates.length,
                    itemBuilder: (BuildContext context, int index) {
                      var list = widget.loyaltyProgress.pushDates.reversed.toList();
                      return Text(
                        list[index],
                        textAlign: TextAlign.center,
                        style: AppFonts.getMainFont(
                            fontSize: 14,
                            color: AppColors.PRIMARY_COLOR,
                            fontWeight: FontWeight.w900),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  togglePushDatesVisibility() {
    if (itemHeight == 100) {
      setState(() {
        itemHeight = 200;
      });
      Timer(0.35.seconds, () {
        setState(() {
          listOpacity = 1;
        });
      });
    } else {
      if (itemHeight == 200) {
        setState(() {
          listOpacity = 0;
        });
        Timer(0.35.seconds, () {
          setState(() {
            itemHeight = 100;
          });
        });
      }
    }
  }

  giveGifts(){
    context.read<AdminPanelVM>().sendGift((widget.loyaltyProgress.gifts - textValue < 0 ? 0 : widget.loyaltyProgress.gifts - textValue), context.read<RegistrationPageVM>().currentUser.company_id, widget.cardType, widget.loyaltyProgress.mail,);
  }

}
