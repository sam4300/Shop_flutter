import 'package:flutter/material.dart';

class CartSingleItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;

  const CartSingleItem({
    required this.quantity,
    required this.price,
    required this.title,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            radius: 28,
            child: FittedBox(
                child: Text(
              '\$ $price',
              style: TextStyle(fontSize: 20),
            )),
          ),
          title: Text(title),
          subtitle: Text('Total: \$${quantity * price}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
