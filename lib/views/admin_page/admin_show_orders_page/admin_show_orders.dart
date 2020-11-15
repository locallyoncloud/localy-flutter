import 'package:flutter/material.dart';
import 'package:locally_flutter_app/models/order.dart';
import 'package:locally_flutter_app/views/admin_page/admin_show_orders_page/admin_active_orders.dart';
import 'package:locally_flutter_app/views/admin_page/admin_show_orders_page/admin_old_orders.dart';
import 'package:provider/provider.dart';

class AdminShowOrders extends StatefulWidget {
  TabController tabController;

  AdminShowOrders(this.tabController);

  @override
  _AdminShowOrdersState createState() => _AdminShowOrdersState();
}

class _AdminShowOrdersState extends State<AdminShowOrders> {
  List<Order> allOrders , activeOrders = [], oldOrders = [];

  @override
  Widget build(BuildContext context) {
    allOrders = Provider.of<List<Order>>(context);
    if(allOrders!=null){
      activeOrders = allOrders.where((element) => element.orderStatus!=3).toList();
      oldOrders = allOrders.where((element) => element.orderStatus==3).toList();
    }
    return TabBarView(
        controller: widget.tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          AdminActiveOrders(activeOrders),
          AdminOldOrders(oldOrders)
        ]);
  }
}


