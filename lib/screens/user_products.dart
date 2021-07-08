import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products_provider.dart';
import 'package:shop/screens/edit_products_screen.dart';
import 'package:shop/widgets/main_drawer.dart';
import 'package:shop/widgets/user_product_item.dart';

class UserProducts extends StatelessWidget {
  static const routeName = '/user-products-screen';

  const UserProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductsScreen.routeName);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) => Column(
          children: [
            UserProductItem(
                productsData.items[index].id!,
                productsData.items[index].title,
                productsData.items[index].imageUrl),
            Divider(
              thickness: 0.7,
              color: Colors.black,
            ),
          ],
        ),
        itemCount: productsData.items.length,
      ),
      drawer: MainDrawer(),
    );
  }
}
