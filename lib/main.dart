import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mortgage_calculator/utils/EventBus.dart';
import 'package:mortgage_calculator/views/homepage.dart';
import 'package:mortgage_calculator/views/splash_page.dart';

void main(){
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(App());
}


class App extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AppState();
  }

}

class AppState extends State<App>{
  Color mainColor = Colors.yellow;

  // ignore: must_call_super
  void initState() {
    eventBus.on<ChangeThemeEvent>().listen((ChangeThemeEvent data) =>
        this.setColor(data.value)
    );
  }
  
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: mainColor,
        indicatorColor:setTextColor(mainColor),
      ),
      routes: <String,WidgetBuilder>{//配置路径
        '/HomePage':(BuildContext context)  => new HomePage(mainColor),
      },
      home: SplashPage(mainColor),

    );
  }
  
  void setColor(Color value){
    setState(() {
      mainColor = value;
    });
  }

  Color setTextColor(Color value){
    if(value==Colors.yellow){
      return Colors.black;
    }else{
      return Colors.white;
    }
  }
}




