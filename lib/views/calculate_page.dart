import 'package:flutter/material.dart';
import 'package:mortgage_calculator/models/loan.dart';
import 'dart:math';

// ignore: must_be_immutable
class CalculatePage extends StatefulWidget{
  Loan loan;
  Color textColor;
  CalculatePage(Loan value,Color value2){
    loan = value;
    textColor = value2;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CalculateState(loan,textColor);
  }
}

class CalculateState extends State<CalculatePage>{
  Loan _loan;
  Color _textColor;
  List<double> monthAmounts = new List<double>();
  CalculateState(Loan value,Color value2){
    _loan = value;
    _textColor = value2;
  }

  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('明细'),
        elevation: 0,
        bottom: PreferredSize(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(_title(_loan),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: _textColor),)
                  ],
                ),
                Row(children: <Widget>[
                  Text('¥',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: _textColor),),
                  Text(getMonthAmount(_loan,0).toStringAsFixed(2),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: _textColor),),
                  Text('元',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: _textColor),)
                ],),
                Row(
                    children: <Widget>[
                      Container(
                        child: Text('贷款总额',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: _textColor),),
                        alignment: Alignment.center,
                        width: 80,
                        height: 30,),
                      SizedBox(width: 10,),
                      Container(
                        child: Text('利率',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: _textColor),),
                        alignment: Alignment.center,
                        width: 80,
                        height: 30,),
                      SizedBox(width: 10,),
                      Container(
                        child: Text('贷款年限',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: _textColor),),
                        alignment: Alignment.center,
                        width: 80,
                        height: 30,),
                    ],),
                Row(children: <Widget>[
                  Container(
                    child: Text(_loan.amount.toStringAsFixed(2)+'万',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,color: _textColor),),
                    alignment: Alignment.center,
                    width: 80,
                    height: 30,),
                  SizedBox(width: 10,),
                  Container(
                    child: Text(_loan.rate.toStringAsFixed(2)+'%',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,color: _textColor),),
                    alignment: Alignment.center,
                    width: 80,
                    height: 30,),
                  SizedBox(width: 10,),
                  Container(
                    child: Text(_loan.year.toString()+'年',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,color: _textColor),),
                    alignment: Alignment.center,
                    width: 80,
                    height: 30,),
                ],),
                Row(
                  children: <Widget>[
                    Text('贷款方式：'+_loan.type,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300,color: _textColor),),
                  ],
                ),
                Divider(color: _textColor),
                Row(
                  children: <Widget>[
                    Text('累计利息（元）：'+getTotalRateAmount(_loan).toStringAsFixed(2),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: _textColor),),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('累计还款总额（元）：'+getTotalAmount(_loan).toStringAsFixed(2),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: _textColor),),
                  ],
                ),
                Divider(color: _textColor),
                Row(
                  children: <Widget>[
                    Container(
                      child: Text('期数',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: _textColor),),
                      alignment: Alignment.center,
                      width: 30,
                      height: 20,
                    ),
                    Container(
                      child: Text('月供',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: _textColor),),
                      alignment: Alignment.center,
                      width: 65,
                      height: 20,
                    ),
                    Container(
                      child: Text('本金',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: _textColor),),
                      alignment: Alignment.center,
                      width: 65,
                      height: 20,
                    ),
                    Container(
                      child: Text('利息',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: _textColor),),
                      alignment: Alignment.center,
                      width: 65,
                      height: 20,
                    ),
                    Container(
                      child: Text('剩余贷款',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: _textColor),),
                      alignment: Alignment.center,
                      width: 95,
                      height: 20,
                    ),
                  ],
                ),
                SizedBox(height: 10,)

              ],),
        ),
            preferredSize: Size(double.infinity, 250)
        ),
      ),
      body: ListView(
        children: _buildBodyTable(_loan),
      ),
    );
  }

  double getTotalRateAmount(Loan loan){
    var realAmount = loan.amount*10000;
    double monthRate = loan.rate/1200;
    int totalMonth = loan.year*12;
    if(loan.type=='等额本息'){
      double totalRateAmount = (totalMonth*realAmount*monthRate*pow((1+monthRate), totalMonth))/(pow(1+monthRate, totalMonth)-1)-realAmount;
      return totalRateAmount;
    }else{
      double totalRateAmount = realAmount*monthRate*(totalMonth+1)/2;
      return totalRateAmount;
    }
  }

  double getMonthAmount(Loan loan,int index){
    var realAmount = loan.amount*10000.0;
    double monthRate = loan.rate/1200;
    int totalMonth = loan.year*12;
    if(loan.type=='等额本息'){
      double monthAmount = realAmount*monthRate*pow(1+monthRate, totalMonth)/(pow(1+monthRate, totalMonth)-1);
      return monthAmount;
    }else{
      if(index==0){
        double monthAmount = realAmount/totalMonth +realAmount*monthRate;
        return monthAmount;
      }else{
        double monthAmount = realAmount/totalMonth+getRestAmount(loan, index-1)*monthRate;
        return monthAmount;
      }

    }
  }



  double getMonthRateAmount(Loan loan,int index){
    var realAmount = loan.amount*10000.0;
    double monthRate = loan.rate/1200;
    if(loan.type=='等额本息'){
      double monthRateAmount = (realAmount*monthRate-getMonthAmount(loan,index))*pow(1+monthRate, index)+getMonthAmount(loan,index);
      return monthRateAmount;
    }else{
      double monthRateAmount = getRestAmount(loan, index-1)*monthRate;
      return monthRateAmount;
    }
  }


  double getRestAmount(Loan loan,int index){
    double realAmount = loan.amount*10000.0;
    int totalMonth = loan.year*12;
    double monthRate = loan.rate/1200;
    if(loan.type=='等额本息'){
      for(int i=0;i<index+1;i++){
        realAmount+= (realAmount*monthRate-getMonthAmount(loan,index))*pow(1+monthRate, index);
      }
      return realAmount;
    }else{
        realAmount=realAmount - realAmount/totalMonth*(index+1);
      return realAmount;
    }
  }

  double getTotalAmount(Loan loan){
    var realAmount = loan.amount*10000;
    double monthRate = loan.rate/1200;
    int totalMonth = loan.year*12;
    if(loan.type=='等额本息'){
      double totalAmount = (totalMonth*realAmount*monthRate*pow((1+monthRate), totalMonth))/(pow(1+monthRate, totalMonth)-1);
      return totalAmount;
    }else{
      double totalAmount = realAmount + getTotalRateAmount(loan);
      return totalAmount;
    }
  }

  String _title(Loan loan){
    if(loan.type=='等额本息'){
      return '每月月供';
    }else{
      return '首月月供';
    }
  }


  List<Widget> _buildBodyTable(Loan loan){
    List<Widget> list = new List<Widget>();
    list.add(SizedBox(height: 10,));
    int totalMonth = loan.year*12;
    for(int i=0;i<totalMonth;i++){
      var item = Padding(
        padding: EdgeInsets.fromLTRB(20,0,20,0),
        child: Row(

          children: <Widget>[
            Container(
              child: Text((i+1).toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300),),
              alignment: Alignment.center,
              width: 30,
              height: 20,
            ),
            Container(
              child: Text(getMonthAmount(loan,i).toStringAsFixed(2),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300),),
              alignment: Alignment.center,
              width: 65,
              height: 20,
            ),
            Container(
              child: Text((getMonthAmount(loan,i)-getMonthRateAmount(loan, i)).toStringAsFixed(2),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,),),
              alignment: Alignment.center,
              width: 65,
              height: 20,
            ),
            Container(
              child: Text(getMonthRateAmount(loan, i).toStringAsFixed(2),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,),),
              alignment: Alignment.center,
              width: 65,
              height: 20,
            ),
            Container(
              child: Text(getRestAmount(loan, i).toStringAsFixed(2),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,),),
              alignment: Alignment.center,
              width: 95,
              height: 20,
            ),
          ],
        ),);
      list.add(item);
      list.add(Divider());
    }
    return list;
  }

  String getLoanDate(DateTime date){
    return date.year.toString()+'-'+date.month.toString();
  }
}