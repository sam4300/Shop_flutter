import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/order.dart';

import '../widgets/order_single_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders-screen';

  const OrdersScreen({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) =>OrderSingleItem(orderData.orders[index]), itemCount: orderData.orders.length,),
    );
  }
}
