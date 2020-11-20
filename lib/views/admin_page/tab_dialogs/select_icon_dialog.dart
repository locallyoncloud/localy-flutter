import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';

class SelectIconDialog extends StatefulWidget {

  @override
  _SelectIconDialogState createState() => _SelectIconDialogState();
}

class _SelectIconDialogState extends State<SelectIconDialog> {
  List<IconData> iconDataList = [FontAwesome.coffee, Ionicons.ios_restaurant, Ionicons.ios_shirt, FontAwesome.glass, Ionicons.md_glasses, FontAwesome.star,MaterialCommunityIcons.diamond_stone,FontAwesome.book,Fontisto.laboratory, FontAwesome.hourglass, FontAwesome.heart, MaterialIcons.computer];

  int selectedIndex = 0;

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
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(iconDataList.length,(i)=>
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: selectedIndex == i ? AppColors.GREY : Colors.transparent, width: 2)
                      ),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            selectedIndex = i;
                          });
                        },
                        child: Icon(
                            iconDataList[i]
                        ),
                      ),
                    )
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: ()=>changeIcon(),
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

  changeIcon() {
    Get.back(result: IconDataInfo(fontFamily: iconDataList[selectedIndex].fontFamily,codePoint:iconDataList[selectedIndex].codePoint ));
  }
}
