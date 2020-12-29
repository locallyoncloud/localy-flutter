import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/order.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/views/widgets/no_data_found.dart';

class AdminOldOrders extends StatelessWidget {

  List<Order> oldOrderList;

  AdminOldOrders(this.oldOrderList);

  @override
  Widget build(BuildContext context) {
    return oldOrderList == null || oldOrderList.length == 0 ?
    NoDataFoundPage('assets/animations/no_data_found.json', "Sipariş bulunmamaktadır.")        : Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: oldOrderList.length,
        itemBuilder: (BuildContext context, int index) {
          var date = DateTime.fromMillisecondsSinceEpoch(oldOrderList[index].orderTime.millisecondsSinceEpoch);
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
                          oldOrderList[index].companyName,
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
                                    text: "${oldOrderList[index].paymentType}",
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
                          itemCount: oldOrderList[index].cartProduct.length,
                          itemBuilder: (BuildContext context, int productIndex) {
                            return Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
/*                                  Expanded(
                                    flex: 59,
                                    child: Text(
                                      "${oldOrderList[index].cartProduct[productIndex].product.name}(${oldOrderList[index].cartProduct[productIndex].productSize})",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.GREY,
                                          fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  )*/
                                  Expanded(
                                      flex: 15,
                                      child: Text(
                                        "${oldOrderList[index].cartProduct[productIndex].count.toString()} adt",
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
                                        "${oldOrderList[index].cartProduct[productIndex].price.toStringAsFixed(2)}₺",
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
                                text: "${oldOrderList[index].address}",
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
                                text: "${oldOrderList[index].userMail}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.GREY,
                                    fontWeight: FontWeight.w900
                                )
                            )
                          ]
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
                                    text: "${oldOrderList[index].totalPrice.toStringAsFixed(2)}₺",
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