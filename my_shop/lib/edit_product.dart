import 'dart:math';

import 'package:flutter/material.dart';

String generateRandomString(int len) {
  var r = Random();
  String randomString =
      String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
  return randomString;
}

class EditProduct extends StatefulWidget {
  static const routeName = "edit_product";
  const EditProduct({super.key, this.product});
  final Map<String, Object>? product;

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  String? _requiredValidation(String? value) {
    if (value?.isEmpty == true) {
      return 'This field is required';
    }
    return null;
  }

  final Map<String, Object> _product = {};
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.product != null) {
      _product.addAll(widget.product!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product detail'),
          actions: [
            IconButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  _formKey.currentState?.save();
                  if (_product['id'] == null) {
                    _product['id'] = generateRandomString(10);
                  }
                  Navigator.pop(context, _product);
                }
              },
              icon: const Icon(Icons.save),
            )
          ],
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(children: [
                TextFormField(
                  initialValue: _product['title']?.toString(),
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                  validator: _requiredValidation,
                  onSaved: (newValue) {
                    _product['title'] = newValue ?? '';
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: _product['price']?.toString(),
                  decoration: const InputDecoration(
                    hintText: 'Price',
                  ),
                  validator: (value) {
                    if (double.tryParse(value ?? '') == null) {
                      return 'Price must be a number';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _product['price'] = newValue ?? '';
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: _product['description']?.toString(),
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                  validator: _requiredValidation,
                  onSaved: (newValue) {
                    _product['description'] = newValue ?? '';
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: _product['imageUrl'] != null
                            ? DecorationImage(
                                image: NetworkImage(
                                    _product['imageUrl']!.toString()),
                                fit: BoxFit.cover,
                              )
                            : null,
                        border: Border.all(
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TextFormField(
                        initialValue: _product['imageUrl']?.toString(),
                        decoration: const InputDecoration(
                          hintText: 'Image URL',
                        ),
                        validator: _requiredValidation,
                        onSaved: (newValue) {
                          _product['imageUrl'] = newValue ?? '';
                        },
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ));
  }
}
