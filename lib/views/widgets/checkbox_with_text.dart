import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/product.dart';
import 'package:locally_flutter_app/utilities/colors.dart';

class CheckboxWithTitle extends StatefulWidget {
  final Function onChange;
  final Options option;

  CheckboxWithTitle(this.onChange, this.option);

  @override
  _CheckboxWithTitleState createState() => _CheckboxWithTitleState();
}

class _CheckboxWithTitleState extends State<CheckboxWithTitle> {
  bool checkboxStatus;

  @override
  void initState() {
    super.initState();
    checkboxStatus = false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          activeColor: AppColors.PRIMARY_COLOR,
            value: checkboxStatus,
            onChanged: (value) => onCheckboxStateChange(value)
        ),
        Text(
          widget.option.optionValue > 0
              ? "${widget.option.optionName} (+${widget.option.optionValue.toString()}₺ ekle)"
              : widget.option.optionName,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.PRIMARY_COLOR),
        )
      ],
    );
  }
  onCheckboxStateChange(bool value){
    setState(() {
      checkboxStatus = !checkboxStatus;
    });
    widget.onChange(value);
  }
}
