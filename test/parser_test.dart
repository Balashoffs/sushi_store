import 'package:flutter_test/flutter_test.dart';
import 'package:sushi_store/src/models/product/product_page_element.dart';
import 'package:sushi_store/src/models/section/section_page.dart';
import 'package:sushi_store/src/parser/parser.dart';

void main(){
  Parser p = Parser();
  test('Section parser', () async {

    SectionPage sp = await p.parseSection('https://nsk.mag-sushi.ru/rolly');
    expect(sp.pageName, 'Роллы');
  });

  test('Product parser', () async{
    ProductPageElement ppe = await p.parseProductPage('https://nsk.mag-sushi.ru/zapechennie-rolly?product_id=443');
    expect(ppe.pageName, 'Креветка&Краб');
  });
}