import 'package:flutter/material.dart';
import 'package:sushi_store/src/screens/loading_screen.dart';

class AppStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LoadingScreen(urlToPage: 'https://nsk.mag-sushi.ru/rolly', sitePosition: 'Type',),
      ),
    );
  }
}
