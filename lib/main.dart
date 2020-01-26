import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app-store.dart';

//void main() => runApp(AppStore());
void main() => runApp(CreateWidgets());

class CreateWidgets extends StatefulWidget {
  @override
  _CreateWidgetsState createState() => _CreateWidgetsState();
}

class _CreateWidgetsState extends State<CreateWidgets> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Stack'),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Container(child: Image.asset('images/main.jpg',)),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: <Widget>[
                        getSvgPicture('images/new.svg'),
                        getSvgPicture('images/vegan.svg'),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                alignment: Alignment.center,
                child: Text('Вег 2', style: TextStyle(fontSize: 36.0),),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                alignment: Alignment.centerLeft,
                child: Text('149 P', style: TextStyle(fontSize: 36.0),),
              ),
              RaisedButton(
                onPressed: (()=>{}),
                child: Text('в корзину'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getSvgPicture(String svgPath){
    final Widget svg = SvgPicture.asset(svgPath);
    return Container(
      margin: EdgeInsets.all(10.0),
      height: 40.0,
      width: 40.0,
      child: svg,
    );
  }
}


