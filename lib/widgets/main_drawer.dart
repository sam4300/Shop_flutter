import 'package:flutter/material.dart';
import 'package:shop/screens/order_screen.dart';
import 'package:shop/screens/user_products.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Drawer(
        child: Column(
          children: [
            AppBar(
              title: Text('Hello Friends'),
            ),
            ListTile(
              leading: Icon(Icons.shop),
              title: Text(
                'Shop',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/');
              },
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
            ),
            ListTile(
                leading: Icon(Icons.payment),
                title: Text(
                  'Orders',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(OrdersScreen.routeName);
                }),
            Divider(
              color: Colors.black,
              thickness: 1,
            ),
            ListTile(
                leading: Icon(Icons.edit),
                title: Text(
                  'Manage Products',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(UserProducts.routeName);
                }),
            Divider(
              color: Colors.black,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
