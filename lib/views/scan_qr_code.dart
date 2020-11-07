import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/enums/camera_of.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
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
  void initState() {
    super.initState();
    isFlashOpen = false;
    /*context.read<AdminPanelVM>().setAdminQrCode("");*/
  }

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
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: AppColors.PRIMARY_COLOR,
          centerTitle: true,
          title: Text(
            "QR Kod Okut",
            style: AppFonts.getMainFont(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.WHITE),
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                child: QRView(
                  key: qrKey,
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
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    var count = 0;
    controller.scannedDataStream.listen((scanData) {
      if (scanData != null) {
        count+=1;
        if (scanData.split("/").length > 4 && scanData.split("/")[5]=="localy" && count == 1) {
          switch (widget.cameraOf){
            case CameraOf.Admin:
                context.read<AdminPanelVM>().setAdminQrCode(scanData);
                Get.back();
              break;
            case CameraOf.Menu:
              // TODO: Handle this case.
              break;
          }
        } else {
          Scaffold.of(context).showSnackBar(CustomSnackbar.buildSnackbar(
              AppColors.ERROR, "Lütfen geçerli bir QR kod okutunuz!", context));
        }
      }
    });

  }
  cameraAction(IconData iconData, bool isFlip) {
    return InkWell(
      onTap: () {
        if (isFlip) {
          controller.flipCamera();
        } else {
          setState(() {
            isFlashOpen = !isFlashOpen;
          });
          controller.toggleFlash();
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
