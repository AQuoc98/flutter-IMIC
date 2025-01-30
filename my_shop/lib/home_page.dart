import 'package:flutter/material.dart';
import 'package:my_shop/appbar.dart';
import 'package:my_shop/cart_inherited_widget.dart';
import 'package:my_shop/edit_product.dart';
import 'package:my_shop/product_detail.dart';

final products = [
  {
    'id': 'VuLm2UGhzBCSr2',
    'title': 'Product 1',
    'price': 3,
    'description': 'product 1 description',
    'imageUrl': 'https://picsum.photos/id/237/200/300',
    'quantity': 1,
  },
  {
    'id': 'cvHAzDTPfaIJ',
    'title': 'Product 2',
    'price': 4,
    'description': 'product 2 description',
    'imageUrl': 'https://picsum.photos/id/2/200/300',
    'quantity': 1,
  },
  {
    'id': 'OlXtnvXbOsvMM1MPGJ',
    'title': 'Product 3',
    'price': 5,
    'description': 'product 3 description',
    'imageUrl': 'https://picsum.photos/id/3/200/300',
    'quantity': 1,
  }
];

class HomePage extends StatefulWidget {
  static const routeName = '/homepage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(count: CartData.of(context)?.totalItems ?? 0),
      body: GridView.builder(
        itemCount: products.length,
        padding: EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetail.routeName,
                arguments: {
                  'id': product['id'],
                },
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GridTile(
                footer: GridTileBar(
                  backgroundColor: Colors.black87,
                  title: Text(product['title'] as String),
                  subtitle: Text(product['description'] as String),
                  leading: IconButton(
                    onPressed: () async {
                      final result = await Navigator.of(context)
                          .pushNamed(EditProduct.routeName, arguments: product);
                      if (result is Map) {
                        final index = products.indexWhere(
                            (element) => element['id'] == result['id']);
                        products[index] = result as Map<String, Object>;
                        setState(() {});
                      }
                    },
                    icon: const Icon(
                      Icons.edit,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      CartData.of(context)?.addItemToCart(context, product);
                    },
                    icon: const Icon(
                      Icons.add_shopping_cart_outlined,
                    ),
                  ),
                ),
                child: Image.network(product['imageUrl'] as String),
              ),
            ),
          );
        },
      ),
    );
  }
}
