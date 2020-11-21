import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/order.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/views/widgets/no_data_found.dart';
import 'package:provider/provider.dart';

class ActiveOrder extends StatelessWidget {
  List<Order> activeOrderList;

  ActiveOrder(this.activeOrderList);

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return activeOrderList != null && activeOrderList.length!=0 ?
    Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: activeOrderList.length,
        itemBuilder: (BuildContext context, int index) {
          return(
              Card(
                elevation: 5,
                margin: EdgeInsets.only(top: 20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        activeOrderList[index].companyName,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.SECONDARY_COLOR
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                          children: renderOrderStatus(activeOrderList[index].orderStatus)
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 100,
                        child: ListView.builder(
                          itemCount: activeOrderList[index].cartProduct.length,
                          itemBuilder: (BuildContext context, int productIndex) {
                            return Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 59,
                                    child: Text(
                                      activeOrderList[index].cartProduct[productIndex].product.name,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.GREY,
                                          fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 15,
                                      child: Text(
                                        "${activeOrderList[index].cartProduct[productIndex].count.toString()} adt",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.DISABLED_GREY,
                                            fontWeight: FontWeight.w700
                                        ),
                                      )
                                  ),
                                  Expanded(
                                      flex: 26,
                                      child: Text(
                                        "${activeOrderList[index].cartProduct[productIndex].price.toStringAsFixed(2)}₺",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.DISABLED_GREY,
                                            fontWeight: FontWeight.w700
                                        ),
                                        textAlign: TextAlign.end,
                                      )
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: RichText(
                          text: TextSpan(
                              text: "Toplam  ",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.DISABLED_GREY,
                              ),
                              children: [
                                TextSpan(
                                    text: "${activeOrderList[index].totalPrice.toStringAsFixed(2)}₺",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.GREY,
                                        fontWeight: FontWeight.w700
                                    )
                                )
                              ]
                          )
                          ,),
                      )
                    ],
                  ),
                ),
              )
          );
        },
      ),
    )
        :
    NoDataFoundPage('assets/animations/no_data_found.json', "Aktif siparişiniz bulunmamaktadır.");
  }
  renderOrderStatus(int orderStatus){
    IconData iconData;
    String text;
    switch (orderStatus){
      case 0:
        iconData = Icons.pending;
        text = "Sipariş Onay Bekliyor";
        break;
      case 1:
        iconData = Icons.food_bank;
        text = "Sipariş Hazırlanıyor";
        break;
      case 2:
        iconData = Icons.pedal_bike;
        text = "Sipariş Yolda";
        break;
      case 3:
        iconData = Icons.done_outline;
        text = "Sipariş Teslim Edildi";
        break;
    }
    return [
      Icon(
          iconData,
          color: AppColors.DISABLED_GREY
      ),
      SizedBox(
        width: 10,
      ),
      Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: AppColors.DISABLED_GREY,
          fontWeight: FontWeight.w700,
        ),
      )
    ];
  }
}
