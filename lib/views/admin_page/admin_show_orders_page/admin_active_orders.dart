import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/order.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/views/admin_page/admin_show_orders_page/order_status_indicators.dart';
import 'package:locally_flutter_app/views/widgets/no_data_found.dart';

class AdminActiveOrders extends StatelessWidget {

  List<Order> activeOrderList;

  AdminActiveOrders(this.activeOrderList);

  @override
  Widget build(BuildContext context) {
    return activeOrderList == null || activeOrderList.length == 0 ?
    NoDataFoundPage('assets/animations/empty_cart_anim.json',
        "Aktif sipariş bulunmamaktadır.")
        : Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: activeOrderList.length,
        itemBuilder: (BuildContext context, int index) {
          var date = DateTime.fromMillisecondsSinceEpoch(activeOrderList[index].orderTime.millisecondsSinceEpoch);
          date = date.add(Duration(hours: 3));
          return(
              Card(
                elevation: 5,
                margin: EdgeInsets.only(top: 20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          activeOrderList[index].deliveryType,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.SECONDARY_COLOR
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(text: TextSpan(
                              text: "Ödeme Şekli: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.SECONDARY_COLOR,
                                  fontWeight: FontWeight.w700
                              ),
                              children: [
                                TextSpan(
                                    text: "${activeOrderList[index].paymentType}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.GREY,
                                        fontWeight: FontWeight.w900
                                    )
                                )
                              ]
                          ),
                          ),
                          RichText(text: TextSpan(
                              text: "Tarih/saat: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.SECONDARY_COLOR,
                                  fontWeight: FontWeight.w700
                              ),
                              children: [
                                TextSpan(
                                    text: "${date.day}/${date.month}/${date.year}  ${date.hour}:${date.minute}:${date.second}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.GREY,
                                        fontWeight: FontWeight.w900
                                    )
                                )
                              ]
                          ),
                          )
                        ],
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
                                      "${activeOrderList[index].cartProduct[productIndex].product.name}(${activeOrderList[index].cartProduct[productIndex].productSize})",
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
                      RichText(text: TextSpan(
                          text: "Adres: ",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.SECONDARY_COLOR,
                              fontWeight: FontWeight.w700
                          ),
                          children: [
                            TextSpan(
                                text: "${activeOrderList[index].address}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.GREY,
                                    fontWeight: FontWeight.w900
                                )
                            )
                          ]
                      ),
                      ),
                      RichText(text: TextSpan(
                          text: "Müşteri Mail Adresi: ",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.SECONDARY_COLOR,
                              fontWeight: FontWeight.w700
                          ),
                          children: [
                            TextSpan(
                                text: "${activeOrderList[index].userMail}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.GREY,
                                    fontWeight: FontWeight.w900
                                )
                            )
                          ]
                      ),
                      ),
                      RichText(text: TextSpan(
                          text: "Sipariş Notu: ",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.SECONDARY_COLOR,
                              fontWeight: FontWeight.w700
                          ),
                          children: [
                            TextSpan(
                                text: "${activeOrderList[index].extraNote}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.GREY,
                                    fontWeight: FontWeight.w900
                                )
                            )
                          ]
                      ),
                      ),
                      activeOrderList[index].deliveryTime.length>0 ? RichText(text: TextSpan(
                          text: "Teslim zamanı: ",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.SECONDARY_COLOR,
                              fontWeight: FontWeight.w700
                          ),
                          children: [
                            TextSpan(
                                text: "${activeOrderList[index].deliveryTime} sonra",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.GREY,
                                    fontWeight: FontWeight.w900
                                )
                            )
                          ]
                      ),
                      ) : Container(),
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
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      OrderStatusIndicator(activeOrderList[index].orderStatus,activeOrderList[index].uid)
                    ],
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}
