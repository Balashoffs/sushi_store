import 'package:flutter/material.dart';
import 'package:sushi_store/src/models/type/type_page.dart';

class TypePageScreen extends StatelessWidget {
  final TypePage typePage;

  TypePageScreen(this.typePage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(typePage.pageName),
      ),
      body: ListView.builder(
        itemCount: typePage.pages.length,
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
                  child: Image.network(typePage.pages[index].imgUrl),
                ),
                Text(
                  typePage.pages[index].name,
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
