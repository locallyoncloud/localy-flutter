import 'package:flutter/material.dart';

class OvalLogo extends StatelessWidget {
  final String imagePath;
  final String bottomText;
  final bool isNetworkImage;
  final double width;
  final TextStyle textStyle;
  final VoidCallback onClick;

  OvalLogo(
      {this.imagePath,
      this.bottomText,
      this.isNetworkImage = true,
      this.width,
      this.textStyle,
      this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> onClick(),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0x14000000),
                offset: Offset(-1.0409498114625029e-15, 17),
                blurRadius: 59,
              ),
            ],
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: isNetworkImage
                ? NetworkImage(imagePath)
                : AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 33,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Center(
              child: Text(
                bottomText,
                style: textStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
