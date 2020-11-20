import 'package:flutter/material.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/view_models/admin_panel_page_vm.dart';
import 'package:provider/provider.dart';

class OrderStatusIndicator extends StatefulWidget {

  int orderStatus;
  String orderUid;

  OrderStatusIndicator(this.orderStatus, this.orderUid);

  @override
  _OrderStatusIndicatorState createState() => _OrderStatusIndicatorState();
}

class _OrderStatusIndicatorState extends State<OrderStatusIndicator> {
  String buttonText = "";
  Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    switch (widget.orderStatus){
      case 0:
        buttonText = "SİPARİŞİ ONAYLA";
        backgroundColor = Color(0xffEFAD4D);
        break;
      case 1:
        buttonText = "SİPARİŞİ YOLA ÇIKAR";
        backgroundColor = Color(0xffE56936);
        break;
      case 2:
        buttonText = "SİPARİŞİ TESLİM ET";
        backgroundColor = Color(0xff2D4D96);
        break;
      case 3:
        buttonText = "SİPARİŞ TESLİM EDİLDİ";
        backgroundColor = AppColors.SUCCESS_GREEN;
        break;
    }
    return InkWell(
      onTap:widget.orderStatus !=3 ? (){
      context.read<AdminPanelVM>().incrementOrderStatus(widget.orderUid);
      } : null,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor,
        ),
        child: Center(
          child: Text(
              buttonText,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.WHITE,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
      ),
    );
  }
}


