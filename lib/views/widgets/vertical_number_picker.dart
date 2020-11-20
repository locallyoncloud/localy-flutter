import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';

class VerticalNumberPicker extends StatefulWidget {
  int maxCount;
  Function onChange;
  int initialCounter;

  VerticalNumberPicker({this.maxCount = 99999, this.onChange, this.initialCounter = 1});

  @override
  _NumberPickerState createState() => _NumberPickerState();
}

class _NumberPickerState extends State<VerticalNumberPicker> {
  int counter;

  @override
  void initState() {
    super.initState();
    counter = widget.initialCounter;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => decreaseCounter(),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.WHITE,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(0, 6),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.remove,
                  color: AppColors.GREY,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            counter.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.PRIMARY_COLOR,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: () => increaseCounter(),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.SECONDARY_COLOR
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: AppColors.GREY,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  decreaseCounter(){
    if (counter != 1) {
      setState(() {
        counter--;
      });
      widget.onChange(counter);
    }
  }
  increaseCounter(){
    if (counter < widget.maxCount) {
      setState(() {
        counter++;
      });
      widget.onChange(counter);
    }
  }
}
