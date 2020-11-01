import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/widgets/number_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:provider/provider.dart';

class ScanQR extends StatefulWidget {
  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  QRViewController controller;
  bool isFlashOpen;
  bool showUserInfo;

  @override
  void initState() {
    super.initState();
    isFlashOpen = false;
    showUserInfo= false;
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
            title: Text(
              "QR Kod Okut",
              style: AppFonts.getMainFont(color: AppColors.WHITE),
            ),
          ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.wb),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 200,
                width: 200,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
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
              ),
              SizedBox(
                height: 20,
              ),
              qrText.length>0 ?
              StreamBuilder<DocumentSnapshot>(
                  stream: context.watch<AdminPanelVM>().getLoyaltyProgressStatus(qrText),
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                    if(snapshot.connectionState == ConnectionState.active){
                      if(!snapshot.hasData){
                        return Text('Lütfen QR kodu okutunuz',
                            style: AppFonts.getMainFont(
                                color: AppColors.PRIMARY_COLOR,
                                fontSize: 16,
                                fontWeight: FontWeight.w700));
                      }else{
                        return Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Müşteri mail adresi: ${qrText.split("/")[0]}",
                                style: AppFonts.getMainFont(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.PRIMARY_COLOR),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Mevcut durum: ${snapshot.data.data()["progress"].toString()}",
                                style: AppFonts.getMainFont(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.PRIMARY_COLOR),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Hediye sayısı: ${snapshot.data.data()["gifts"].toString()}",
                                style: AppFonts.getMainFont(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.PRIMARY_COLOR),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Önceki QR okutma tarihleri:",
                                style: AppFonts.getMainFont(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.PRIMARY_COLOR,
                                    textDecoration: TextDecoration.underline),
                              ),
                              Expanded(
                                  child: ListView.builder(
                                    itemCount: snapshot.data.data()["pushDates"].length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                          snapshot.data.data()["pushDates"][index],
                                          style: AppFonts.getMainFont(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.PRIMARY_COLOR),
                                        ),
                                      );
                                    },
                                  ))
                            ],
                          ),
                        );
                      }
                    }else{
                      return CircularProgressIndicator();
                    }
                  }
              ) : Container()
            ],
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData != null) {
        setState(() {
          qrText = scanData;
        });
        openAddPointDialog(context);
      }
    });
  }

  openAddPointDialog(BuildContext context) {
    controller.pauseCamera();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                  width: 300,
                  height: 300,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.BG_WHITE),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Ürün adedi:",
                        style: AppFonts.getMainFont(
                          fontSize: 14,
                          color: AppColors.PRIMARY_COLOR,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      NumberPicker(),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        onPressed: () => Get.back(),
                        color: AppColors.PRIMARY_COLOR,
                        child: Text(
                          "Ekle",
                          style: AppFonts.getMainFont(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.WHITE),
                        ),
                      )
                    ],
                  )),
            )).then((value) {
      controller.resumeCamera();
      add();
    });
  }

  add() async {
   await context.read<AdminPanelVM>().addLoyalty(
        qrText,
        context.read<RegistrationPageVM>().currentUser.company_id,
        context.read<AdminPanelVM>().pickedNumber);
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
      ),
    );
  }
}
