import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mortgage_calculator/views/homepage.dart';

class SplashPage extends StatefulWidget{

  Color mainColor;
  SplashPage(Color value){
    mainColor = value;
  }
  @override
  _SplashPage createState()=> new _SplashPage(mainColor);

}

class _SplashPage extends State<SplashPage>{

  bool isStartHomePage = false;
  Color _mainColor;
  _SplashPage(Color value){
    _mainColor = value;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
      onTap: goToHomePage,//设置页面点击事件
      child: Container(
        child: Container(
          child: Image.asset("assets/ic_launcher.png",fit: BoxFit.fitWidth,),
          width: 128,
          height: 128,
        ),

        width: double.infinity,
        height: double.infinity,
        color: Color.fromARGB(255, 255, 255, 255),
        alignment: Alignment.center,
      ),//此处fit: BoxFit.cover用于拉伸图片,使图片铺满全屏
    );
  }

  //页面初始化状态的方法
  @override
  void initState() {
    super.initState();
    //开启倒计时
    countDown();
  }

  void countDown() {
    //设置倒计时三秒后执行跳转方法
    var duration = new Duration(milliseconds: 500);
    new Future.delayed(duration, goToHomePage);
  }

  void goToHomePage(){
    //如果页面还未跳转过则跳转页面
    if(!isStartHomePage){
      //跳转主页 且销毁当前页面
      Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context)=>new HomePage(_mainColor)), (Route<dynamic> rout)=>false);
      isStartHomePage=true;
    }
  }
}