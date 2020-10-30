import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:provider/provider.dart';

class NumberPicker extends StatefulWidget {


  @override
  _NumberPickerState createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 102,
      height: 35,
      child: Row(
        children: [
          Flexible(
              child: InkWell(
                onTap: (){
                  if(context.read<AdminPanelVM>().pickedNumber!=null){
                    context.read<AdminPanelVM>().decrementPickedNumber();
                  }else{
                    setState(() {
                      if(counter!=1){
                        counter--;
                      }
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
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
              )
          ),
          Flexible(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: AppColors.WHITE,
                child: Center(
                  child: Text(
                    context.watch<AdminPanelVM>().pickedNumber == null ? counter.toString() : context.watch<AdminPanelVM>().pickedNumber.toString() ,
                    style: AppFonts.getMainFont(
                      color: AppColors.PRIMARY_COLOR,
                      fontSize: 15,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              )
          ),
          Flexible(
              child: InkWell(
                onTap: (){
                  if(context.read<AdminPanelVM>().pickedNumber!=null){
                    context.read<AdminPanelVM>().incrementPickedNumber();
                  }else{
                    setState(() {
                      counter++;
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
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
              )
          )
        ],
      ),
    );
  }
}
