import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';

class RegistrationTextfield extends StatefulWidget {

  String placeholder;
  IconData iconData;
  Color iconColor;
  bool hideText;

  RegistrationTextfield({this.placeholder, this.iconData, this.iconColor, this.hideText = false});

  @override
  _RegistrationTextfieldState createState() => _RegistrationTextfieldState();
}

class _RegistrationTextfieldState extends State<RegistrationTextfield> {
  TextEditingController _controller= TextEditingController();
  FocusNode _textFocusNode = FocusNode();
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _textFocusNode.addListener(() {
      setState(() {
        _focused = _textFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _textFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _textFocusNode,
      keyboardType: TextInputType.emailAddress,
      style: AppFonts.getMainFont(
        color: AppColors.WHITE,
        fontSize: 14,
        fontWeight: FontWeight.w700
      ),
      obscureText: widget.hideText,
      decoration: InputDecoration(
        labelText: widget.placeholder,
        labelStyle: AppFonts.getMainFont(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.WHITE
        ),
        prefixIcon: Icon(
          widget.iconData,
          color: widget.iconColor,
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.WHITE.withOpacity(0.4)
            )
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.WHITE
            )
        )
      ),
    );
  }
}
