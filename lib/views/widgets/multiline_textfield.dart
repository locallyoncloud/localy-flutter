import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';

class MultilineTextField extends StatefulWidget {

  String label;
  Color labelColor;
  Function onChange;

  MultilineTextField(this.label, this.onChange, this.labelColor);

  @override
  _MultilineTextFieldState createState() => _MultilineTextFieldState();
}

class _MultilineTextFieldState extends State<MultilineTextField> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      minLines: 4,
      maxLines: 4,

      style: TextStyle(
        fontSize: 14,
        color: AppColors.GREY,
        fontWeight: FontWeight.w700
      ),
      textInputAction: TextInputAction.done,
      cursorColor: AppColors.PRIMARY_COLOR,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: widget.labelColor
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.PRIMARY_COLOR)
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.PRIMARY_COLOR)
        ),
      ),
      onChanged: (value) => widget.onChange(value),
    );
  }
}
