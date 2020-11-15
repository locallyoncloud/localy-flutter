import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/enums/camera_of.dart';
import 'package:locally_flutter_app/models/company.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/utilities/utility_widgets.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:locally_flutter_app/view_models/cart_page_vm.dart';
import 'package:locally_flutter_app/view_models/company_details_page_vm.dart';
import 'package:locally_flutter_app/view_models/home_page_vm.dart';
import 'package:locally_flutter_app/views/company_details_page/company_details.dart';
import 'package:supercharged/supercharged.dart';
import 'package:locally_flutter_app/views/widgets/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRCode extends StatefulWidget {

  CameraOf cameraOf;

  ScanQRCode(this.cameraOf);

  @override
  _ScanQRCodeState createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  final GlobalKey qrKey = GlobalKey();
  var qrText = "";
  QRViewController controller;
  bool isFlashOpen;



  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.BG_WHITE,
        appBar: UtilityWidgets.CustomAppBar(
          Text(
            "QR Kod Okut",
            style: AppFonts.getMainFont(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.PRIMARY_COLOR),
          ),
          null
        ),
        body: QRWidget(widget.cameraOf,qrKey,controller),
      ),
    );
  }

}

class QRWidget extends StatefulWidget {
  CameraOf cameraOf;
  GlobalKey qrKey;
  QRViewController controller;

  QRWidget(this.cameraOf, this.qrKey, this.controller);

  @override
  _QRWidgetState createState() => _QRWidgetState();
}

class _QRWidgetState extends State<QRWidget> {

  bool isFlashOpen;

  @override
  void initState() {
    super.initState();
    isFlashOpen = false;
    /*context.read<AdminPanelVM>().setAdminQrCode("");*/
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            child: QRView(
              key: widget.qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ),
        Positioned(
            bottom: 10,
            left: 5,
            right: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                cameraAction(MaterialIcons.flip, true),
                cameraAction(
                    isFlashOpen
                        ? MaterialCommunityIcons.flashlight_off
                        : MaterialCommunityIcons.flashlight,
                    false)
              ],
            ))
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    widget.controller = controller;
    var count = 0;
    controller.scannedDataStream.listen((scanData) {
      if (scanData != null) {
        count+=1;
        if(count==1){
          if (scanData.split("/").last=="localy") {
            switch (widget.cameraOf){
              case CameraOf.Admin:
                context.read<AdminPanelVM>().setAdminQrCode(scanData);
                Get.back();
                break;
              case CameraOf.Menu:
                sendUserToMenu(scanData);
                break;
            }
          } else {
            Scaffold.of(context).showSnackBar(CustomSnackbar.buildSnackbar(
                AppColors.ERROR, "Lütfen geçerli bir QR kod okutunuz!", context));
            Timer(1.seconds, (){
              count = 0;
            });
          }
        }
      }
    });
  }

  sendUserToMenu(String scanData) async {
    Company scannedCompany = await context.read<HomePageVM>().getCompanyDetails(scanData.split("/")[0]);
    context.read<CartPageVM>().setCurrentSelectedTable(scanData.split("/")[1]);
    context.read<CompanyDetailsPageVM>().setCurrentCompany(scannedCompany, true);
    context.read<CompanyDetailsPageVM>().setSelectedTab(1);
    Get.off(CompanyDetails());
  }

  cameraAction(IconData iconData, bool isFlip) {
    return InkWell(
      onTap: () {
        if (isFlip) {
          widget.controller.flipCamera();
        } else {
          setState(() {
            isFlashOpen = !isFlashOpen;
          });
          widget.controller.toggleFlash();
        }
      },
      child: Icon(
        iconData,
        size: 50,
        color: AppColors.WHITE,
      ),
    );
  }

}

