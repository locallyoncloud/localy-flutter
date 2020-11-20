import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:locally_flutter_app/utilities/colors.dart';

class CustomAlertDialog extends StatelessWidget {
  String title, content;
  Function yesFunction, noFunction;


  CustomAlertDialog(
      {this.title, this.content, this.yesFunction, this.noFunction});

  @override
  Widget build(BuildContext context) {
    return GetPlatform.isIOS
        ? CupertinoAlertDialog(
            title: Text(
              title,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: AppColors.PRIMARY_COLOR),
            ),
            content: Text(
              content,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.PRIMARY_COLOR),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () => yesFunction(),
                child: Text("Evet",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.GREY)),
              ),
              CupertinoDialogAction(
                onPressed: () => noFunction(),
                child: Text("Hayır",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.GREY)),
              )
            ],
          )
        : AlertDialog(
            title: Text(
              title,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: AppColors.PRIMARY_COLOR),
            ),
            content: Text(
              content,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.PRIMARY_COLOR),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => yesFunction(),
                child: Text("Evet",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.GREY)),
              ),
              TextButton(
                onPressed: () => noFunction(),
                child: Text("Hayır",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.GREY)),
              )
            ],
          );
  }
}
