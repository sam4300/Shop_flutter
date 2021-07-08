import 'dart:math';
import 'package:flutter/material.dart';

import 'package:shop/providers/order.dart';
import 'package:intl/intl.dart';

class OrderSingleItem extends StatefulWidget {
  final OrderItem order;

  const OrderSingleItem(this.order);

  @override
  _OrderSingleItemState createState() => _OrderSingleItemState();
}

class _OrderSingleItemState extends State<OrderSingleItem> {
  var _clicked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('\$ ${widget.order.amount}'),
            subtitle:
                Text(DateFormat('dd MM yyyy hh:mm').format(widget.order.date)),
            trailing: IconButton(
              icon:
                  _clicked ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _clicked = !_clicked;
                });
              },
            ),
          ),
          if (_clicked)
            Container(
              height: min(widget.order.products.length * 40.0, 180),
              child: ListView(
                children: widget.order.products
                    .map((product) => Padding(
                          padding:
                              const EdgeInsets.only(left: 8, bottom: 1, top: 8),
                          child: Row(
                            children: [
                              Text(product.title),
                              Spacer(),
                              Text('${product.quantity}x\$${product.price}')
                            ],
                          ),
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
