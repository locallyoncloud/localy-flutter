import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locally_flutter_app/models/loyalty_card.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:locally_flutter_app/views/admin_page/admin_collection_loyalty_card.dart';
import 'package:locally_flutter_app/utilities/extensions/clone_object.dart';
import 'package:locally_flutter_app/views/admin_page/loyalty_edit_button.dart';
import 'package:locally_flutter_app/views/admin_page/no_card_found.dart';
import 'package:locally_flutter_app/views/admin_page/tab_dialogs/background_color_dialog.dart';
import 'package:locally_flutter_app/views/admin_page/tab_dialogs/select_icon_dialog.dart';
import 'package:locally_flutter_app/views/admin_page/tab_dialogs/slider_dialog.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class LoyaltyCardsFirstTab extends StatefulWidget {
  List<LoyaltyCard> loyaltyCardList;

  LoyaltyCardsFirstTab({this.loyaltyCardList});

  @override
  _LoyaltyCardsFirstTabState createState() => _LoyaltyCardsFirstTabState();
}

class _LoyaltyCardsFirstTabState extends State<LoyaltyCardsFirstTab> {
  LoyaltyCard loyaltyCardFromDB;
  final picker = ImagePicker();
  bool editingEnabled = false;

  @override
  void initState() {
    super.initState();
    if (widget.loyaltyCardList.length > 0) {
      loyaltyCardFromDB =
          LoyaltyCard.fromJsonMap(widget.loyaltyCardList[0].toJson().clone);
    }
  }

  @override
  void didUpdateWidget(covariant LoyaltyCardsFirstTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.loyaltyCardList.length != oldWidget.loyaltyCardList.length) {
      setState(() {
        loyaltyCardFromDB =
            LoyaltyCard.fromJsonMap(widget.loyaltyCardList[0].toJson().clone);
      });
    }
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
                  children: editingEnabled
                      ? [
                          InkWell(
                            onTap: () => showSimpleDialog(
                                "Değişiklik Sıfırlama",
                                "Yaptığınız değişiklikleri sıfırlamak istediğinize eminmisiniz?",
                                (){
                                  setState(() {
                                    loyaltyCardFromDB = LoyaltyCard.fromJsonMap(
                                        widget.loyaltyCardList[0].toJson().clone);
                                  });
                                },
                                (){
                                  Get.back();
                                }
                            ),
                            child: Container(
                              width: 85,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: AppColors.ERROR, width: 2)),
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
                            onTap: () => showSimpleDialog(
                                "Değişiklik Onayı",
                                "Yaptığınız değişiklikleri onaylıyormusunuz?",
                                  (){
                                    updateCard();
                            },
                                (){
                                  Get.back();
                                }
                            ),
                            child: Container(
                              width: 85,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: AppColors.GREEN, width: 2)),
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
                        ]
                      : [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                loyaltyCardFromDB.isActive
                                    ? "Kart aktif"
                                    : "Kart aktif değil",
                                style: AppFonts.getMainFont(
                                    fontSize: 14,
                                    color: loyaltyCardFromDB.isActive
                                        ? AppColors.GREEN
                                        : AppColors.ERROR,
                                    fontWeight: FontWeight.w700),
                              ),
                              Checkbox(
                                value:
                                    loyaltyCardFromDB.isActive ? true : false,
                                checkColor: loyaltyCardFromDB.isActive
                                    ? AppColors.GREEN
                                    : AppColors.ERROR,
                                onChanged: (bool value) {
                                  showSimpleDialog(
                                      "Kart Durumu",
                                      loyaltyCardFromDB.isActive ? "Kartı deaktif duruma getirmek istediğinize eminmisiniz?"
                                          : "Kartı aktif duruma getirmek istediğinize eminmisiniz?",
                                      ()=>toggleCardStatus(value),
                                      ()=>Get.back()
                                  );
                                },
                              )
                            ],
                          ),
                    RaisedButton(
                      onPressed: (){
                        setState(() {
                          editingEnabled = true;
                        });
                      },
                      color: AppColors.PRIMARY_COLOR,
                      child: Text(
                        "Değiştir",
                        style: AppFonts.getMainFont(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.WHITE
                        ),
                      ),
                    )

                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                AdminCollectionLoyaltyCard(loyaltyCardFromDB),
                SizedBox(
                  height: 20,
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
                        iconData: AntDesign.select1,
                        text: "Sembol",
                        onClick: () => selectIconDialog(context),
                      ),
                      LoyaltyEditButton(
                        iconData: MaterialCommunityIcons.format_color_fill,
                        text: "Sembol Rengi",
                        onClick: () => openBgColorDialog(context, "icon"),
                      ),
                      LoyaltyEditButton(
                        iconData: MaterialCommunityIcons.format_text,
                        text: "Yazı Rengi",
                        onClick: () => openBgColorDialog(context, "text"),
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
          : NoCardFound(0),
    );
  }

  toggleCardStatus(value){
    context.read<AdminPanelVM>().toggleCardStatus(loyaltyCardFromDB);
    setState(() {
      loyaltyCardFromDB.isActive = value;
    });
  }

  openBgColorDialog(BuildContext context, String whichColorPick) {
    showDialog(
        context: context,
        builder: (_) => BackgroundColorDialog(
              initialColor: AppColors.hexToColor(whichColorPick == "background"
                  ? loyaltyCardFromDB.backgroundColor
                  : whichColorPick == "icon"
                      ? loyaltyCardFromDB.iconColor
                      : loyaltyCardFromDB.textColor),
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

  selectIconDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => SelectIconDialog())
        .then((value) {
      if (value != null) {
        setState(() {
          loyaltyCardFromDB.iconData = value;
        });
      }
    });
  }

  openSliderDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => SliderDialog(
              initialIconSize: loyaltyCardFromDB.iconSize,
              initialImageOpacity: loyaltyCardFromDB.imageOpacity,
              initialTarget: loyaltyCardFromDB.target.toDouble(),
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
    Function yesFunction,
    Function noFunction,
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
                      yesFunction();
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
                      noFunction();
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
                      yesFunction();
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
                      noFunction();
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
    await context.read<AdminPanelVM>().addLoyaltyCard(loyaltyCardFromDB);
    setState(() {
      editingEnabled = false;
    });
  }


}
