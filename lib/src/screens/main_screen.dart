import 'package:flutter/material.dart';
import 'package:sushi_store/src/models/main/main_page.dart';
import 'package:sushi_store/src/screens/loading_screen.dart';

class MainPageScreen extends StatelessWidget {
  final MainPage mainPage;
  String url;
  MainPageScreen(this.mainPage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(mainPage.pageName),
      ),
      body: ListView.builder(
        itemCount: mainPage.pages.length,
        itemBuilder: (context, int index) {
          return GestureDetector(
            onTap: (){
              print('${mainPage.pages[index].pageUrl}');
              Navigator.pop(context, {'Type', mainPage.pages[index].pageUrl});
            },
            child: Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 10.0,
                    ),
                    child: Image.network(mainPage.pages[index].imgUrl),
                  ),
                  Text(
                    mainPage.pages[index].name,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
