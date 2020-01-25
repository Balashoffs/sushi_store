import 'package:http/http.dart'; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart' as dom;
import 'package:sushi_store/src/models/main/main_page.dart';
import 'package:sushi_store/src/models/main/main_page_element.dart';
import 'package:sushi_store/src/models/product/product_page_element.dart';
import 'package:sushi_store/src/models/section/section_page.dart';
import 'package:sushi_store/src/models/section/section_page_element.dart';

class Parser{
  //Get list of chose product's type - section , for example 'Роллы - https://nsk.mag-sushi.ru/rolly'
  Future<SectionPage> parseSection(String urlToPage) async{
    List<SectionPageElement> pages = [];
    String pageName = '';
    var htmlPage = await _getHtmlPage(urlToPage);
    var document = parse(htmlPage);
    List<dom.Element> titles = document.querySelectorAll('ul.wrap > li > a');

    for(dom.Element e in titles){
      if(e.attributes['href'] == urlToPage){
        pageName = e.nodes[0].text;
      }
    }

    List<dom.Element> links = document.querySelectorAll('li.grid-item');
    for(var link in links){
      String pageUrl = link.querySelector('a').attributes['href'];
      String mainImgUrl = link.querySelector('img.category-item-image').attributes['src'];
      String name = link.querySelector('span.category-item-title').text ;
      String price = link.querySelector('span.price-current').text;
      List<dom.Element> elements = link.querySelectorAll('img.product-label');
      Map<String, String> additionalImageUrlMap = <String, String>{};
      for(dom.Element e in elements){
        additionalImageUrlMap.putIfAbsent(e.attributes['alt'], ()=> e.attributes['src']);
      }
      pages.add(SectionPageElement(
          price: price,
          additionalImageUrl: additionalImageUrlMap,
          mainImgUrl: mainImgUrl,
          pageUrl: pageUrl,
          name: name)
      );
    }
    return SectionPage(pages: pages, pageName: pageName);
  }

  //Get information about chose food, for example 'Вег 2 - https://nsk.mag-sushi.ru/yaponskaya-kuhnya/rolly?product_id=898'
  Future<ProductPageElement> parseProductPage(String urlToPage) async{
    var htmlPage = await _getHtmlPage(urlToPage);
    var document = parse(htmlPage);
    List<dom.Element> elements = document.querySelectorAll('div.product-label > img');
    Map<String, String> additionalImageUrl = {};
    for(dom.Element e in elements){
      additionalImageUrl.putIfAbsent(e.attributes['alt'], ()=>e.attributes['src']);
    }
    var mainImgXpath = document.querySelector('div.product-image > div > img:last-child');
    var mainImgUrl = mainImgXpath.attributes['src'];
    var pageName = mainImgXpath.attributes['alt'];
    String oldPrice = document.querySelector('span.price-old').text;
    var newPrice = document.querySelector('span.price-current > span').text;
    var product_desc = document.querySelectorAll('div.product-desc > p');
    StringBuffer product_descSB = StringBuffer();
    for(dom.Element e in product_desc){
      product_descSB.write('${e.text} ');
    }
    String description = product_descSB.toString();
    var weight = document.querySelector('div.product-desc > div.weight > p > span').text;
    return ProductPageElement(
      productLabelsMap: additionalImageUrl,
      oldPrice: oldPrice,
      newPrice: newPrice,
      description: description,
      mainImgUrl: mainImgUrl,
      pageName: pageName,
      weight: weight);
  }

  //Get list of food categories, for example 'Меню - https://nsk.mag-sushi.ru/';

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