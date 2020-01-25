import 'package:flutter/material.dart';
import 'package:sushi_store/src/models/product/product_page_element.dart';

class ProductPageScreen extends StatelessWidget {
  final ProductPageElement productPageElement;

  ProductPageScreen(this.productPageElement);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(productPageElement.pageName),
      ),
      body: Container(),
    );
  }
}
