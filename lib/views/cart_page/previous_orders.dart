import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/order.dart';
import 'package:locally_flutter_app/utilities/colors.dart';
import 'package:locally_flutter_app/utilities/fonts.dart';
import 'package:locally_flutter_app/utilities/screen_sizes.dart';
import 'package:locally_flutter_app/view_models/home_page_vm.dart';
import 'package:locally_flutter_app/view_models/registration_page_vm.dart';
import 'package:locally_flutter_app/views/widgets/no_data_found.dart';
import 'package:provider/provider.dart';

class PreviousOrders extends StatelessWidget {
  List<Order> orderList;

  PreviousOrders(this.orderList);

  @override
  Widget build(BuildContext context) {
    ScreenSize.recalculate(context);
    return Container(
      color: AppColors.BG_WHITE,
      width: 100.wb,
      height: 100.hb,
      padding: EdgeInsets.all(10),
      child: orderList !=null && orderList.length!=0 ?
      ListView.builder(
        itemCount: orderList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.only(top: 20),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    orderList[index].companyName,
                    style: AppFonts.getMainFont(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.SECONDARY_COLOR
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.local_shipping,
                        color: AppColors.DISABLED_GREY,
                      ),
                      Text(
                        "Teslim Edildi",
                        style: AppFonts.getMainFont(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.DISABLED_GREY
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
                      itemCount: orderList[index].cartProduct.length,
                      itemBuilder: (BuildContext context, int productIndex) {
                        return Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 59,
                                child: Text(
                                  orderList[index].cartProduct[productIndex].product.name,
                                  style: AppFonts.getMainFont(
                                      fontSize: 14,
                                      color: AppColors.GREY,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 15,
                                  child: Text(
                                    "${orderList[index].cartProduct[productIndex].count.toString()} adt",
                                    style: AppFonts.getMainFont(
                                        fontSize: 14,
                                        color: AppColors.DISABLED_GREY,
                                        fontWeight: FontWeight.w700
                                    ),
                                  )
                              ),
                              Expanded(
                                  flex: 26,
                                  child: Text(
                                    "${orderList[index].cartProduct[productIndex].price.toStringAsFixed(2)}₺",
                                    style: AppFonts.getMainFont(
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
                          style: AppFonts.getMainFont(
                            fontSize: 12,
                            color: AppColors.DISABLED_GREY,
                          ),
                          children: [
                            TextSpan(
                                text: "${orderList[index].totalPrice.toStringAsFixed(2)}₺",
                                style: AppFonts.getMainFont(
                                    fontSize: 14,
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
          );
        },
      )
          :
      NoDataFoundPage('assets/animations/no_data_found.json', "Önceden verilmiş sipariş bulunmamaktadır.")      ,
    );
  }
}


