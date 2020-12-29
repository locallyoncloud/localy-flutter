import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';

class DropdownWidget extends StatefulWidget {

  Function onChange;
  List<String> dropdownList;
  String hint;
  Color textColor;

  DropdownWidget({this.onChange, this.dropdownList, this.hint, this.textColor = AppColors.GREY});

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String dropdownValue;

  @override
  void initState() {
    super.initState();
    if(widget.hint == null){
      dropdownValue = widget.dropdownList[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      hint: Text(widget.hint ?? "",style: TextStyle(color: AppColors.GREY),),
      icon: Icon(Icons.arrow_downward),
      iconSize: 16,
      iconEnabledColor: widget.textColor,
      elevation: 16,
      style: TextStyle(color: widget.textColor),
      underline: Container(
        height: 2,
        color: widget.textColor,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
        widget.onChange(dropdownValue);
      },
      items: widget.dropdownList
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}