import 'package:flutter/material.dart';

class CartNotification extends Notification {}

final cartNotification = CartNotification();

class CartData extends InheritedWidget {
  const CartData({super.key, required this.data, required super.child});

  final List<Map<String, dynamic>> data;

  static CartData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CartData>();
  }

  void addItemToCart(BuildContext context, Map<String, dynamic> item) {
    data.add(item);
    cartNotification.dispatch(context);
  }

  get totalItems => data.fold(
        0,
        (previousValue, element) => previousValue + element['quantity'] as int,
      );

  @override
  bool updateShouldNotify(CartData oldWidget) {
    return true;
  }
}
