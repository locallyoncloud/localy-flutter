import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';

class SliderDialog extends StatefulWidget {

  double initialImageOpacity, initialIconSize;
  double initialTarget;
  int cardType;

  SliderDialog({this.initialImageOpacity, this.initialIconSize, this.initialTarget,this.cardType = 0});

  @override
  _SliderDialogState createState() => _SliderDialogState();
}

class _SliderDialogState extends State<SliderDialog> {
  double opacityValue;
  double iconSize;
  double cardTarget;

  @override
  void initState() {
    super.initState();
    opacityValue = widget.initialImageOpacity;
    iconSize = widget.initialIconSize;
    cardTarget = widget.initialTarget;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
          width: 300,
          height: 420,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.BG_WHITE),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
            renderDialogContents()
                + [
              RaisedButton(
                onPressed: ()=>changeSliders(),
                color: AppColors.PRIMARY_COLOR,
                child: Text(
                  "Değiştir",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.WHITE
                  ),
                ),
              )
            ],
          )),
    );
  }

  List<Widget> renderDialogContents(){
    switch (widget.cardType){
      case 0:
        return backgroundIOpacitySlider() + IconSizeSlider() + cardTargetSlider();
      default:
        return backgroundIOpacitySlider();
    }
  }

  List<Widget> backgroundIOpacitySlider(){
    return [
      Text(
        "Arkaplan Resmi Opaklığı: ${opacityValue.toStringAsFixed(2)}",
        style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.PRIMARY_COLOR,
            fontSize: 14
        ),
      ),
      Platform.isIOS ?
      CupertinoSlider(
          thumbColor: AppColors.PRIMARY_COLOR,
          value: opacityValue,
          onChanged: (value) {
            setState(() {
              opacityValue = value;
            });
          })
          :
      Slider(
          inactiveColor: AppColors.PRIMARY_COLOR,
          value: opacityValue,
          onChanged: (value) {
            setState(() {
              opacityValue = value;
            });
          }),
      SizedBox(
        height: 10,
      ),
    ];
  }
  List<Widget> IconSizeSlider(){
    return [
      Text(
        "Sembol Boyutu: ${iconSize.toStringAsFixed(2)}",
        style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.PRIMARY_COLOR,
            fontSize: 14
        ),
      ),
      Platform.isIOS ?
      CupertinoSlider(
          thumbColor: AppColors.PRIMARY_COLOR,
          value: iconSize,
          min: 15,
          max: 50,
          onChanged: (value) {
            setState(() {
              iconSize = value;
            });
          })
          :
      Slider(
          inactiveColor: AppColors.PRIMARY_COLOR,
          min: 15,
          max: 50,
          label: iconSize.round().toString(),
          value: iconSize,
          onChanged: (value) {
            setState(() {
              iconSize = value;
            });
          }),
      SizedBox(
        height: 10,
      ),
    ];
  }
  List<Widget> cardTargetSlider(){
    return [
      Text(
        "Kart Hedefi: ${cardTarget.round().toString()}",
        style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.PRIMARY_COLOR,
            fontSize: 14
        ),
      ),
      Platform.isIOS ?
      CupertinoSlider(
          thumbColor: AppColors.PRIMARY_COLOR,
          value: cardTarget,
          min: 1,
          max: 16,
          divisions: 16,
          onChanged: (value) {
            setState(() {
              cardTarget = value;
            });
          })
          :
      Slider(
          inactiveColor: AppColors.PRIMARY_COLOR,
          min: 1,
          max: 16,
          label: cardTarget.round().toString(),
          value: cardTarget,
          divisions: 16,
          onChanged: (value) {
            setState(() {
              cardTarget = value;
            });
          }),
      SizedBox(
        height: 10,
      ),
    ];
  }


  changeSliders() {
    Get.back(result: {
      "opacityValue": opacityValue,
      "iconSize" : iconSize,
      "cardTarget": cardTarget,
    });
  }
}
