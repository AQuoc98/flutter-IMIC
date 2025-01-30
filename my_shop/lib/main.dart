import 'package:flutter/material.dart';
import 'package:my_shop/auth.dart';
import 'package:my_shop/cart_inherited_widget.dart';
import 'package:my_shop/edit_product.dart';
import 'package:my_shop/home_page.dart';
import 'package:my_shop/product_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Map<String, dynamic>> data = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Auth(),
      builder: (context, child) {
        return NotificationListener<CartNotification>(
          onNotification: (notification) {
            setState(() {});
            return true;
          },
          child: CartData(
            data: data,
            child: child ?? const Text('Ok'),
          ),
        );
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case HomePage.routeName:
            return MaterialPageRoute(builder: (context) => const HomePage());
          case ProductDetail.routeName:
            return MaterialPageRoute(
              builder: (context) => ProductDetail(
                id: (settings.arguments as Map)['id'] as String,
              ),
            );
          case EditProduct.routeName:
            return MaterialPageRoute(
              builder: (context) => EditProduct(
                product: settings.arguments as Map<String, Object>?,
              ),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => const Scaffold(
                body: Text('404'),
              ),
            );
        }
      },
    );
  }
}

// Product List
