import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';

class NumberPicker extends StatefulWidget {
  int maxCount;
  Function onChange, onSubmitClick;
  bool hasSubmitButton;

  NumberPicker(
      {this.maxCount = 99999,
      this.onChange,
      this.onSubmitClick,
      this.hasSubmitButton = false});

  @override
  _NumberPickerState createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {
  int counter;

  @override
  void initState() {
    super.initState();
    counter = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 102,
          height: 35,
          child: Row(
            children: [
              Flexible(
                  child: InkWell(
                onTap: () {
                  if (counter != 1) {
                    setState(() {
                      counter--;
                    });
                    widget.onChange(counter);
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30)),
                    color: AppColors.PRIMARY_COLOR,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x29000000),
                        offset: Offset(7, 6),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      AntDesign.minus,
                      color: AppColors.WHITE,
                      size: 19,
                    ),
                  ),
                ),
              )),
              Flexible(
                  child: Container(
                width: double.infinity,
                height: double.infinity,
                color: AppColors.WHITE,
                child: Center(
                  child: Text(
                    counter.toString(),
                    style: TextStyle(
                        color: AppColors.PRIMARY_COLOR,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              )),
              Flexible(
                  child: InkWell(
                onTap: () {
                  if (counter < widget.maxCount) {
                    setState(() {
                      counter++;
                    });
                    widget.onChange(counter);
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    color: AppColors.PRIMARY_COLOR,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x29000000),
                        offset: Offset(7, 6),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      AntDesign.plus,
                      color: AppColors.WHITE,
                      size: 19,
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
        SizedBox(
          height: widget.hasSubmitButton ? 10 : 0,
        ),
        widget.hasSubmitButton
            ? Builder(
                builder: (BuildContext context) => RaisedButton(
                  onPressed: () {
                    widget.onSubmitClick(context);
                    setState(() {
                      counter = 1;
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: AppColors.PRIMARY_COLOR,
                  child: Text(
                    "Onay",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.WHITE),
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
