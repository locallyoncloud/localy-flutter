import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:locally_flutter_app/enums/text_type.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

class RegistrationTextfield extends StatefulWidget {

  String placeholder;
  IconData iconData;
  Color iconColor;
  bool hideText;
  TextfieldType textfieldType;
  bool hasSuffixEyeIcon;
  String value;

  RegistrationTextfield({this.placeholder, this.iconData, this.iconColor, this.hideText = false, this.textfieldType, this.hasSuffixEyeIcon = false, this.value});

  @override
  _RegistrationTextfieldState createState() => _RegistrationTextfieldState();
}

class _RegistrationTextfieldState extends State<RegistrationTextfield> {
  TextEditingController _controller;
  FocusNode _textFocusNode = FocusNode();
  bool hidePassword;
  ValueKey keyOne = ValueKey("show");
  ValueKey keyTwo = ValueKey("hidden");

  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _controller= TextEditingController(text: widget.value);
    hidePassword = widget.hideText;
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
      cursorColor: AppColors.WHITE,
      style: AppFonts.getMainFont(
        color: AppColors.WHITE,
        fontSize: 14,
        fontWeight: FontWeight.w700
      ),
      obscureText: hidePassword,
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
        suffixIcon: widget.hasSuffixEyeIcon ? GestureDetector(
          onTap: (){
            setState(() {
              hidePassword = !hidePassword;
            });
          },
          child: AnimatedSwitcher(
            duration: 0.5.seconds,
            child: hidePassword ? Icon(
              MaterialCommunityIcons.eye,
              key: keyOne,
              color: AppColors.WHITE,
            ):
            Icon(
              MaterialCommunityIcons.eye_off,
              key: keyTwo,
              color: AppColors.WHITE,
            ),
          ),
        ) : null,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.WHITE.withOpacity(0.4)
            )
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.WHITE
            )
        )
      ),
      onChanged: (value){
        context.read<RegistrationPageVM>().onTextfieldChange(widget.textfieldType, value);
      },
    );
  }
}
