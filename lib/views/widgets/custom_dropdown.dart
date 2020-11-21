import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';

class DropdownWidget extends StatefulWidget {

  Function onChange;
  List<String> dropdownList;

  DropdownWidget({this.onChange, this.dropdownList});

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.dropdownList[0];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 16,
      iconEnabledColor: AppColors.GREY,
      elevation: 16,
      style: TextStyle(color: AppColors.GREY),
      underline: Container(
        height: 2,
        color: AppColors.GREY,
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