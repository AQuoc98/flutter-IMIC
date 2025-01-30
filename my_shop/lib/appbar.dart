import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int count;

  const CustomAppBar({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.purple,
      title: Text('MyShop'),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      actions: [
        Badge.count(
          count: count,
          alignment: Alignment.topLeft,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
        ),
        IconButton(
          onPressed: () async {
            // final result =
            //     await Navigator.of(context).pushNamed(EditProduct.routeName);
            // if (result is Map) {
            //   products.add(result as Map<String, Object>);
            //   setState(() {});
            // }
          },
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        )
      ],
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
