import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/extensions/clone_object.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/admin_page/admin_money_loyalty_card.dart';
import 'package:locally_flutter_app/views/admin_page/loyalty_edit_button.dart';
import 'package:locally_flutter_app/views/admin_page/no_card_found.dart';
import 'package:locally_flutter_app/views/admin_page/tab_dialogs/background_color_dialog.dart';
import 'package:locally_flutter_app/views/admin_page/tab_dialogs/select_icon_dialog.dart';
import 'package:locally_flutter_app/views/admin_page/tab_dialogs/slider_dialog.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';


class LoyaltyCardsSecondTab extends StatefulWidget {
  List<LoyaltyCard> loyaltyCardList;

  LoyaltyCardsSecondTab({this.loyaltyCardList});

  @override
  _LoyaltyCardsSecondTabState createState() => _LoyaltyCardsSecondTabState();
}

class _LoyaltyCardsSecondTabState extends State<LoyaltyCardsSecondTab> {
  LoyaltyCard loyaltyCardFromDB;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.loyaltyCardList.length > 0) {
      loyaltyCardFromDB =
          LoyaltyCard.fromJsonMap(widget.loyaltyCardList[0].toJson().clone);
    }
  }

@override
  void didUpdateWidget(covariant LoyaltyCardsSecondTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.loyaltyCardList.length != oldWidget.loyaltyCardList.length){
      setState(() {
        loyaltyCardFromDB = LoyaltyCard.fromJsonMap(widget.loyaltyCardList[0].toJson().clone);
      });
    }
  }
@override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("CHANGE GİRDİ!!");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: loyaltyCardFromDB != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => showSimpleDialog(
                          "Değişiklik Sıfırlama",
                          "Yaptığınız değişiklikleri sıfırlamak istediğinize eminmisiniz?",
                          true),
                      child: Container(
                        width: 85,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border:
                                Border.all(color: AppColors.ERROR, width: 2)),
                        child: Center(
                          child: Text(
                            "Sıfırla",
                            style: AppFonts.getMainFont(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.ERROR),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => showSimpleDialog("Değişiklik Onayı",
                          "Yaptığınız değişiklikleri onaylıyormusunuz?", false),
                      child: Container(
                        width: 85,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border:
                                Border.all(color: AppColors.GREEN, width: 2)),
                        child: Center(
                          child: Text(
                            "Onayla",
                            style: AppFonts.getMainFont(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.GREEN),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                AdminMoneyLoyaltyCard(loyaltyCardFromDB),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Wrap(
                    runSpacing: 10,
                    children: [
                      LoyaltyEditButton(
                        iconData: Foundation.background_color,
                        text: "Arka Plan Rengi",
                        onClick: () => openBgColorDialog(context, "background"),
                      ),
                      LoyaltyEditButton(
                        iconData: Platform.isIOS
                            ? Ionicons.logo_apple
                            : Ionicons.logo_android,
                        text: "Mini Logo",
                        onClick: () => pickNewImage(true),
                      ),
                      LoyaltyEditButton(
                        iconData: Ionicons.md_image,
                        text: "Arka Plan Resim",
                        onClick: () => pickNewImage(false),
                      ),
                      LoyaltyEditButton(
                        iconData: MaterialCommunityIcons.format_text,
                        text: "Yazı Rengi",
                        onClick: () => openBgColorDialog(context, "text"),
                      ),
                      LoyaltyEditButton(
                        iconData: MaterialCommunityIcons.format_color_fill,
                        text: "Sembol Rengi",
                        onClick: () => openBgColorDialog(context, "icon"),
                      ),
                      LoyaltyEditButton(
                        iconData: AntDesign.setting,
                        text: "Diğer Ayarlar",
                        onClick: () => openSliderDialog(context),
                      ),
                    ],
                  ),
                )
              ],
            )
          : NoCardFound(1),
    );
  }

  openBgColorDialog(BuildContext context, String whichColorPick) {
    showDialog(
        context: context,
        builder: (_) => BackgroundColorDialog(
          initialColor: AppColors.hexToColor(whichColorPick == "background" ? loyaltyCardFromDB.backgroundColor : whichColorPick == "icon" ? loyaltyCardFromDB.iconColor : loyaltyCardFromDB.textColor),
            )).then((value) {
      setState(() {
        switch (whichColorPick) {
          case "background":
            loyaltyCardFromDB.backgroundColor = AppColors.colorToHex(value ??
                AppColors.hexToColor(loyaltyCardFromDB.backgroundColor));
            break;
          case "icon":
            loyaltyCardFromDB.iconColor = AppColors.colorToHex(
                value ?? AppColors.hexToColor(loyaltyCardFromDB.iconColor));
            break;
          case "text":
            loyaltyCardFromDB.textColor = AppColors.colorToHex(
                value ?? AppColors.hexToColor(loyaltyCardFromDB.textColor));
            break;
        }
      });
    });
  }

  pickNewImage(bool isMiniLogoImage) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    String downloadUrl;
    if (pickedFile != null) {
      downloadUrl = isMiniLogoImage
          ? await context
              .read<AdminPanelVM>()
              .uploadFile(pickedFile.path, "${loyaltyCardFromDB.uid}_mini_logo")
          : await context
              .read<AdminPanelVM>()
              .uploadFile(pickedFile.path, "${loyaltyCardFromDB.uid}_bg_logo");

      setState(() {
        if (isMiniLogoImage) {
          loyaltyCardFromDB.miniLogo = downloadUrl;
        } else {
          loyaltyCardFromDB.logo = downloadUrl;
        }
      });
    }
  }


  openSliderDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => SliderDialog(
              initialIconSize: loyaltyCardFromDB.iconSize,
              initialImageOpacity: loyaltyCardFromDB.imageOpacity,
              initialTarget: loyaltyCardFromDB.target.toDouble(),
              cardType: 1,
            )).then((value) {
      if (value != null) {
        setState(() {
          loyaltyCardFromDB.iconSize = value["iconSize"];
          loyaltyCardFromDB.imageOpacity = value["opacityValue"];
          loyaltyCardFromDB.target = value["cardTarget"].round();
        });
      }
    });
  }

  showSimpleDialog(
    String title,
    String content,
    bool isReset,
  ) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Platform.isIOS
            ? CupertinoAlertDialog(
                title: Text(
                  title,
                  style: AppFonts.getMainFont(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: AppColors.PRIMARY_COLOR),
                ),
                content: Text(
                  content,
                  style: AppFonts.getMainFont(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.PRIMARY_COLOR),
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    onPressed: () {
                      if (isReset) {
                        setState(() {
                          loyaltyCardFromDB = LoyaltyCard.fromJsonMap(
                              widget.loyaltyCardList[0].toJson().clone);
                        });
                      } else {
                        updateCard();
                      }
                      Get.back();
                    },
                    child: Text("Evet",
                        style: AppFonts.getMainFont(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.GREY)),
                  ),
                  CupertinoDialogAction(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Hayır",
                        style: AppFonts.getMainFont(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.GREY)),
                  )
                ],
              )
            : AlertDialog(
                title: Text(
                  title,
                  style: AppFonts.getMainFont(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: AppColors.PRIMARY_COLOR),
                ),
                content: Text(
                  content,
                  style: AppFonts.getMainFont(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.PRIMARY_COLOR),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      if (isReset) {
                        setState(() {
                          loyaltyCardFromDB = LoyaltyCard.fromJsonMap(
                              widget.loyaltyCardList[0].toJson().clone);
                        });
                      } else {
                        updateCard();
                      }
                      Get.back();
                    },
                    child: Text("Evet",
                        style: AppFonts.getMainFont(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.GREY)),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Hayır",
                        style: AppFonts.getMainFont(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.GREY)),
                  )
                ],
              ));
  }

  updateCard() async {
    await context.watch<AdminPanelVM>().addLoyaltyCard(loyaltyCardFromDB);
  }

  addnewLoyaltyCard() async {
    var uuid = Uuid().v4();
    LoyaltyCard newLoyaltyCard = LoyaltyCard(
        uid: uuid,
        backgroundColor: "#000000",
        textColor: "#FFFFFF",
        iconColor: "",
        backgroundImage: "https://firebasestorage.googleapis.com/v0/b/localy-d8280.appspot.com/o/placeholder_image.jpg?alt=media&token=60820f73-af25-43a4-89a7-f9027dd3523c",
        company_id: context.read<RegistrationPageVM>().currentUser.company_id,
        iconData: IconDataInfo(fontFamily: "",codePoint: 0),
        isActive: false,
        logo: "https://firebasestorage.googleapis.com/v0/b/localy-d8280.appspot.com/o/placeholder_image.jpg?alt=media&token=60820f73-af25-43a4-89a7-f9027dd3523c",
        miniLogo: "https://firebasestorage.googleapis.com/v0/b/localy-d8280.appspot.com/o/placeholder_image.jpg?alt=media&token=60820f73-af25-43a4-89a7-f9027dd3523c",
        sector: "Sektör Gir",
        target: 8,
        type: 1,
        iconSize: 24,
        imageOpacity: 0.8
    );
    await context.read<AdminPanelVM>().addLoyaltyCard(newLoyaltyCard);
  }
}
