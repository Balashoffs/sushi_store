import 'package:http/http.dart'; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart' as dom;
import 'package:sushi_store/src/models/main/main_page.dart';
import 'package:sushi_store/src/models/main/main_page_element.dart';
import 'package:sushi_store/src/models/product/product_page.dart';
import 'package:sushi_store/src/models/product/product_page_element.dart';
import 'package:sushi_store/src/models/type/type_page.dart';
import 'package:sushi_store/src/models/type/type_page_element.dart';

class Parser{
  Future<TypePage> parseType(String urlToPage) async{
    List<TypePageElement> pages = [];
    var htmlPage = await _getHtmlPage(urlToPage);
    var document = parse(htmlPage);
    List<dom.Element> links = document.querySelectorAll('li.grid-item');
    for(var link in links){
      String pageUrl = link.attributes['href'];
      String img = link.querySelector('span.home-menu-item-image').attributes['style'];
      img = img.substring(img.indexOf('\'')+1, img.lastIndexOf('\''));
      var imgUrl = 'https://nsk.mag-sushi.ru$img';
      String name = link.querySelector('span.home-menu-item-title').innerHtml;
      pages.add(TypePageElement(imgUrl: imgUrl, pageUrl: pageUrl, name: name));
    }
    TypePage typePage = null;
    return typePage;
  }

  Future<ProductPage> parseProduct(String urlToPage) async{
    List<ProductPageElement> pages = [];
    ProductPage productPage = null;
    return productPage;
  }

  Future<MainPage> parseMainPage(String urlToPage) async{
    List<MainPageElement> pages = [];
    var htmlPage = await _getHtmlPage(urlToPage);
    var document = parse(htmlPage);
    List<dom.Element> links = document.querySelectorAll('a.home-menu-item');
    for(var link in links){
      String pageUrl = link.attributes['href'];
      String img = link.querySelector('span.home-menu-item-image').attributes['style'];
      img = img.substring(img.indexOf('\'')+1, img.lastIndexOf('\''));
      var imgUrl = 'https://nsk.mag-sushi.ru$img';
      String name = link.querySelector('span.home-menu-item-title').innerHtml;
      pages.add(MainPageElement(imgUrl: imgUrl, pageUrl: pageUrl, name: name));
    }
    MainPage mainPage = MainPage(pageName: 'Меню', pages: pages);
    return mainPage;
  }

  Future <String> _getHtmlPage(String page)async{
    var client = Client();
    Response response = await client.get(page);
    if(response.statusCode == 200){
      print(response.body.length);
      return response.body;
    }else{
      print(response.statusCode);
    }
  }
}