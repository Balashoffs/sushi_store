import 'package:flutter/material.dart';
import 'package:sushi_store/src/models/product/product_page.dart';

class ProductPageScreen extends StatelessWidget {
  final ProductPage productPage;

  ProductPageScreen(this.productPage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(productPage.pageName),
      ),
      body: ListView.builder(
        itemCount: productPage.pages.length,
        itemBuilder: (context, int index) {
          return Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  child: Image.network(productPage.pages[index].imgUrl),
                ),
                Text(
                  productPage.pages[index].name,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
