import 'package:flutter/material.dart';
import 'package:my_shop/home_page.dart';

class ProductDetail extends StatelessWidget {
  final String id;
  static const routeName = 'detail-page';

  const ProductDetail({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final product = products.firstWhere(
      (element) => element['id'] == id,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(product['title'] as String),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.network(product['imageUrl'] as String),
            Text(product['title'] as String),
            Text(product['description'] as String),
          ],
        ),
      ),
    );
  }
}
