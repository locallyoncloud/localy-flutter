import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
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

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BG_WHITE,
      body: Column(
        children: <Widget>[
          Container(
            width:double.infinity,
            height: 300,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            child: Center(
              child: Text('Lütfen QR kodu okutunuz plzzzzz'
              ,style: AppFonts.getMainFont(
                  color: AppColors.PRIMARY_COLOR,
                  fontSize: 16,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      print(scanData);
      if( scanData!=null ){
        setState(() {
          qrText = scanData;
        });
        openAddPointDialog(context);
      }
    });
  }

  openAddPointDialog(BuildContext context){
    showDialog(context: context,
      builder: (_) =>
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
                width: 300,
                height: 420,
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
                      onPressed: ()=>add(),
                      color: AppColors.PRIMARY_COLOR,
                      child: Text(
                        "Ekle",
                        style: AppFonts.getMainFont(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.WHITE
                        ),
                      ),
                    )
                  ],
                )),
          )
    );
  }

  add() async {
    await context.read<AdminPanelVM>().addLoyalty(qrText, context.read<RegistrationPageVM>().currentUser.company_id, context.read<AdminPanelVM>().pickedNumber);
  }


}
