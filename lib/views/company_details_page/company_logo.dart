import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CompanyLogo extends StatelessWidget {
  final String imagePath;
  final String bottomText;
  final bool isNetworkImage;
  final double width;
  final TextStyle textStyle;
  final VoidCallback onClick;

  CompanyLogo(
      {this.imagePath,
      this.bottomText,
      this.isNetworkImage = true,
      this.width,
      this.textStyle,
      this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0x14000000),
              offset: Offset(-1.0409498114625029e-15, 17),
              blurRadius: 59,
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned.fill(
                child:
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/gif/loading_placeholder.gif",
                    image: imagePath,
                    fit: BoxFit.cover,),
                )),
            Align(
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
            )
          ],
        ),
      ),
    );
  }
}
