import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:supercharged/supercharged.dart';

class ChooseProductSize extends StatefulWidget {

  List<double> widthList;
  Function onChange;

  ChooseProductSize(this.widthList, {this.onChange});

  @override
  _ChooseProductSizeState createState() => _ChooseProductSizeState();
}

class _ChooseProductSizeState extends State<ChooseProductSize> {
  double left = 0;
  double selectedWidth;

  @override
  void initState() {
    super.initState();
    selectedWidth = widget.widthList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
              widget.widthList.length,
              (index) => InkWell(
                    onTap: () {
                      left = 0;
                      setState(() {
                        selectedWidth = widget.widthList[index];
                        for (var i = 0; i < index; i++) {
                          left += widget.widthList[i];
                        }
                      });
                      widget.onChange(index);
                    },
                    child: Container(
                      width: widget.widthList[index],
                      padding: EdgeInsets.only(left: 5),
                      child: AspectRatio(
                          aspectRatio: 0.64,
                          child: Image.asset("assets/png/coffee_cup.png")),
                    ),
                  )),
        ),
        AnimatedPositioned(
          left: left+1,
          bottom:0,
          duration: 300.milliseconds,
          child: AnimatedContainer(
            width: selectedWidth + 3,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.PRIMARY_COLOR)),
            duration: 300.milliseconds,
            child: AspectRatio(aspectRatio: 0.64),
          ),
        )
      ],
    );
  }
}
