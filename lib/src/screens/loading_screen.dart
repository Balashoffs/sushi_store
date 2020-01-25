import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sushi_store/src/models/main/main_page.dart';
import 'package:sushi_store/src/models/product/product_page_element.dart';
import 'package:sushi_store/src/models/section/section_page.dart';
import 'package:sushi_store/src/parser/parser.dart';
import 'package:sushi_store/src/screens/main_screen.dart';
import 'package:sushi_store/src/screens/product_screen.dart';
import 'package:sushi_store/src/screens/section_screen.dart'; //

class LoadingScreen extends StatefulWidget {
  Parser parser = Parser();
  final String urlToPage;
  final String sitePosition;
  LoadingScreen({Key key, this.urlToPage, this.sitePosition}):super(key:key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitDoubleBounce(
          color: Colors.lightBlue,
          size: 100.0,
        ),
    );
  }


  @override
  Future<void> initState() {
    switch(widget.sitePosition){
      case 'Menu':
        widget.parser.parseMainPage(widget.urlToPage).then((mainPage){
          Navigator.push(context, MaterialPageRoute<Map<String, String>>(builder: (context){
            return MainPageScreen(MainPage(pageName: mainPage.pageName, pages: mainPage.pages));
          }));
        });
        break;
      case 'Type':
        widget.parser.parseSection(widget.urlToPage).then((pageType){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return SectionPageScreen(SectionPage(pageName: pageType.pageName, pages: pageType.pages));
          }));
        });
        break;
      case 'Product':
        widget.parser.parseProductPage(widget.urlToPage).then((pageProduct){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return ProductPageScreen(ProductPageElement(
                pageName: pageProduct.pageName,
                mainImgUrl: pageProduct.mainImgUrl,
                description: pageProduct.description,
                newPrice: pageProduct.newPrice,
                oldPrice: pageProduct.oldPrice,
                productLabelsMap: pageProduct.productLabelsMap));
          }));
        });
        break;
    }
  }

}
