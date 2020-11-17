import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';

class RadioButtonGroup extends StatefulWidget {
  List<String> radioList;
  Function onChange;

  RadioButtonGroup(this.radioList, this.onChange);

  @override
  _RadioButtonGroupState createState() => _RadioButtonGroupState();
}

class _RadioButtonGroupState extends State<RadioButtonGroup> {
  dynamic selectedOption;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.radioList
            .map((e) => Flexible(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(
                      left: widget.radioList.indexOf(e) == 0 ? 0 : 10),
                child: RadioListTile(
                      activeColor: AppColors.PRIMARY_COLOR,
                      title: Text(
                        e,
                        style: AppFonts.getMainFont(
                            fontSize: 14,
                            color: AppColors.GREY,
                            fontWeight: FontWeight.w700),
                      ),
                      value: e,
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value;
                        });
                        widget.onChange(value);
                      }),
              ),
            ))
            .toList());
  }
}
