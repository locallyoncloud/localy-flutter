import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';

class PercentageSettingDialog extends StatefulWidget {
  String initialPercentage;

  PercentageSettingDialog({this.initialPercentage});

  @override
  _PercentageSettingDialogState createState() => _PercentageSettingDialogState();
}

class _PercentageSettingDialogState extends State<PercentageSettingDialog> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialPercentage);
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
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.WHITE),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Feather.percent,
                      color: AppColors.PRIMARY_COLOR,
                    ),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: ()=>changePercentage(),
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
          )
      ),
    );
  }

  changePercentage() {
    Get.back(result: _controller.value.text);
  }
}
