import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:locally_flutter_app/view_models/notifications_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:provider/provider.dart';

class PushNotifications extends StatefulWidget {
  @override
  _PushNotificationsState createState() => _PushNotificationsState();
}

class _PushNotificationsState extends State<PushNotifications> {
  String title = "", content="";

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return Container(
      color: AppColors.BG_WHITE,
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Aktif loyalty kartınıza abone olmuş tüm müşterilerinize bildirim gönderin.",
            textAlign: TextAlign.center,
            style: AppFonts.getMainFont(
                fontSize: 14,
                color: AppColors.PRIMARY_COLOR,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 80.wb,
            height: 44,
            child: TextField(
              cursorColor: AppColors.PRIMARY_COLOR,
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.title,
                  color: AppColors.PRIMARY_COLOR,
                ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1,color: AppColors.PRIMARY_COLOR)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: AppColors.PRIMARY_COLOR)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(width: 2,color: AppColors.PRIMARY_COLOR)),
                  labelText: "Bildirim Başlığı",
                  labelStyle: AppFonts.getMainFont(
                      fontSize: 14,
                      color: AppColors.PRIMARY_COLOR,
                      fontWeight: FontWeight.w700)),
              style: AppFonts.getMainFont(
                  fontSize: 14,
                  color: AppColors.GREY,
                  fontWeight: FontWeight.w700),
              onChanged: (value){

                setState(() {
                  title = value;
                });

              },
            ),
          )
,
          SizedBox(
            height: 20,
          ),
          Container(
            width: 80.wb,
            height: 44,
            child: TextField(
              cursorColor: AppColors.PRIMARY_COLOR,
              decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.content_paste,
                    color: AppColors.PRIMARY_COLOR,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1,color: AppColors.PRIMARY_COLOR)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: AppColors.PRIMARY_COLOR)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(width: 2,color: AppColors.PRIMARY_COLOR)),
                  labelText: "Bildirim İçeriği",
                  labelStyle: AppFonts.getMainFont(
                      fontSize: 14,
                      color: AppColors.PRIMARY_COLOR,
                      fontWeight: FontWeight.w700)),
              style: AppFonts.getMainFont(
                  fontSize: 14,
                  color: AppColors.GREY,
                  fontWeight: FontWeight.w700),
                onChanged: (value){
                setState(() {
                  content = value;
                });

                }
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 80.wb,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: AppColors.SUCCESS_GREEN,
              onPressed: ()=>sendNotifications(context),
              child: Text(
                "GÖNDER",
                style: AppFonts.getMainFont(
                  fontSize: 14,
                  color: AppColors.WHITE,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  sendNotifications(BuildContext context) async {
    context.read<RegistrationPageVM>().isLoadingVisible =true;
    List<String> allCustomerUids = await context.read<AdminPanelVM>().getAllNotificationIdsForCard(context.read<RegistrationPageVM>().currentUser.company_id);
    dynamic notificationResponse;
    notificationResponse = await context.read<NotificationsVM>().postCampaignNotification(allCustomerUids,title,content);
    context.read<RegistrationPageVM>().isLoadingVisible =false;
  }
}
