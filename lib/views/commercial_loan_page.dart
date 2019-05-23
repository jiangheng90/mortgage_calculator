import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mortgage_calculator/models/loan.dart';
import 'package:mortgage_calculator/views/calculate_page.dart';


class CommercialLoanPage extends StatefulWidget{
  Loan loan;
  CommercialLoanPage(Loan value){
    loan = value;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CommercialLoanState(loan);
  }
}

class CommercialLoanState extends State<CommercialLoanPage>{
  Loan _loan;

  CommercialLoanState(Loan value){
    _loan = value;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          child:Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                    children: <Widget>[
                      SizedBox(height: 20,),
                      Container(
                        child:ListTile(
                          leading: Text('还款金额（万元）',style: TextStyle(fontSize: 16),),
                          trailing: FlatButton(
                            onPressed: (){
                              _showAmountPicker(context);
                            },
                            child: Text(_loan.amount.toStringAsFixed(2)+"万元",style: TextStyle(fontSize: 16),),),
                        ),
                        height: 40,
                        width: double.infinity,
                      ),
                      Divider(),
                      Container(
                        child:ListTile(
                          leading: Text('开始还款日期',style: TextStyle(fontSize: 16),),
                          trailing: FlatButton(
                            onPressed: (){
                              showDatePicker(
                                  context: this.context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(DateTime.now().year),
                                  lastDate: DateTime(DateTime.now().year+100)).then((DateTime value){
                                    if(value!=null){
                                      setState(() {
                                        _loan.startDate = value;
                                      });
                                    }
                              });
                            },
                            child: Text(_loan.startDate.year.toString()+"-"+ _loan.startDate.month.toString()+"-"+ _loan.startDate.day.toString(),style: TextStyle(fontSize: 16),),),
                        ),
                        height: 40,
                        width: double.infinity,
                      ),
                      Divider(),
                      Container(
                        child:ListTile(
                          leading: Text('还款年限（年）',style: TextStyle(fontSize: 16),),
                          trailing: FlatButton(
                            onPressed: (){
                              _showYearPicker(context);
                            },
                            child: Text(_loan.year.toString()+"年",style: TextStyle(fontSize: 16),),),
                        ),
                        height: 40,
                        width: double.infinity,
                      ),
                      Divider(),
                      Container(
                        child: ListTile(
                          leading: Text('还款利率（%）',style: TextStyle(fontSize: 16),),
                          trailing: FlatButton(
                            onPressed: (){
                              _showRatePicker(context);
                            },
                            child: Text(_loan.rate.toStringAsFixed(2)+"%",style: TextStyle(fontSize: 16),),),
                        ),
                        height: 40,
                        width: double.infinity,
                      ),
                      Divider(),
                      Container(
                        child: ListTile(
                          leading: Text('还款方式',style: TextStyle(fontSize: 16),),
                          trailing: DropdownButton<String>(
                            value: _loan.type,
                            onChanged: (String value){
                              setState(() {
                                _loan.type = value;
                              });
                            },
                            items: <String>['等额本息','等额本金'].map<DropdownMenuItem<String>>((String value){
                              return DropdownMenuItem(
                                value: value,
                                child: Container(
                                  child: Text(value,style: TextStyle(fontSize: 16),),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        alignment: Alignment.center,
                        height: 40,
                        width: double.infinity,
                      ),
                    ],
                  ),)

              )
          ),
          width: double.infinity,
          height: 360,
        ),
      ),



//      floatingActionButton: FloatingActionButton(
//        onPressed: (){
//          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
//            return CalculatePage(_loan);
//          }));
//        },
//        tooltip: '计算房贷',
//        child: Icon(Icons.done),
//      ),
    );
  }

  void _showYearPicker(BuildContext cxt){
    List<Widget> items = new List<Widget>();
    for(int i=1;i<31;i++){
      items.add(FlatButton(
        child: Text(i.toString()+"年",style: TextStyle(fontSize: 20,),),
        onPressed: (){},
      ),);
    }

    final picker  = CupertinoPicker(itemExtent: 40,
        onSelectedItemChanged: (position){
      setState(() {
        _loan.year=position+1;
      });
        },
        backgroundColor: Colors.white,
        children: items
    );

    showCupertinoModalPopup(context: cxt, builder: (cxt){
      return Container(
        child: picker,
        color: Colors.white,
        height: 200,
      );
    });
  }

  void _showRatePicker(BuildContext cxt){
    int num1=0;
    int num2=0;
    int num3=0;

    List<Widget> items1 = new List<Widget>();
    for(int i=0;i<10;i++){
      items1.add(FlatButton(
        child: Text(i.toString(),style: TextStyle(fontSize: 20,),),
        onPressed: (){},
      ),);
    }

    List<Widget> items2 = new List<Widget>();
    for(int i=0;i<10;i++){
      items2.add(FlatButton(
        child: Text(i.toString(),style: TextStyle(fontSize: 20,),),
        onPressed: (){},
      ),);
    }

    List<Widget> items3 = new List<Widget>();
    for(int i=0;i<10;i++){
      items3.add(FlatButton(
        child: Text(i.toString(),style: TextStyle(fontSize: 20,),),
        onPressed: (){},
      ),);
    }

    final picker1  = CupertinoPicker(itemExtent: 40,
        onSelectedItemChanged: (position){
          setState(() {
            num1 = position;
            _loan.rate = num1+num2*0.1+num3*0.01;
          });
        },
        backgroundColor: Colors.white,
        children: items1,
        looping: true,
    );

    final picker2  = CupertinoPicker(itemExtent: 40,
        onSelectedItemChanged: (position){
          setState(() {
            num2 = position;
            _loan.rate = num1+num2*0.1+num3*0.01;
          });
        },
        backgroundColor: Colors.white,
        children: items2,
        looping: true,
    );

    final picker3  = CupertinoPicker(itemExtent: 40,
        onSelectedItemChanged: (position){
          setState(() {
            num3 = position;
            _loan.rate = num1+num2*0.1+num3*0.01;
          });
        },
        backgroundColor: Colors.white,
        children: items3,
        looping: true,
    );

    showCupertinoModalPopup(context: cxt, builder: (cxt){
      return Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: picker1,
              height: 200,
              width: 50,
            ),
            Container(
              child: FlatButton(onPressed: null, child: Text('.',style: TextStyle(fontSize: 18),),),
              alignment: Alignment.center,
              height: 200,
              width: 20,
            ),
            Container(
              child: picker2,
              height: 200,
              width: 50,
            ),
            Container(
              child: picker3,
              height: 200,
              width: 50,
            ),
            Container(
              child: FlatButton(onPressed: null, child: Text('%',style: TextStyle(fontSize: 18),),),
              alignment: Alignment.center,
              height: 200,
              width: 20,
            ),
          ],
        ),
        width: double.infinity,
        color: Colors.white,
        height: 200,
      );
    });
  }

  void _showAmountPicker(BuildContext cxt){

    int num2=0;
    int num3=0;
    int num4=0;
    int num5=0;
    int num6=0;


    List<Widget> items2 = new List<Widget>();
    for(int i=0;i<10;i++){
      items2.add(FlatButton(
        child: Text(i.toString(),style: TextStyle(fontSize: 20,),),
        onPressed: (){},
      ),);
    }

    List<Widget> items3 = new List<Widget>();
    for(int i=0;i<10;i++){
      items3.add(FlatButton(
        child: Text(i.toString(),style: TextStyle(fontSize: 20,),),
        onPressed: (){},
      ),);
    }

    List<Widget> items4 = new List<Widget>();
    for(int i=0;i<10;i++){
      items4.add(FlatButton(
        child: Text(i.toString(),style: TextStyle(fontSize: 20,),),
        onPressed: (){},
      ),);
    }

    List<Widget> items5 = new List<Widget>();
    for(int i=0;i<10;i++){
      items5.add(FlatButton(
        child: Text(i.toString(),style: TextStyle(fontSize: 20,),),
        onPressed: (){},
      ),);
    }

    List<Widget> items6 = new List<Widget>();
    for(int i=0;i<10;i++){
      items6.add(FlatButton(
        child: Text(i.toString(),style: TextStyle(fontSize: 20,),),
        onPressed: (){},
      ),);
    }

    final picker2  = CupertinoPicker(itemExtent: 40,
      onSelectedItemChanged: (position){
        setState(() {
          num2 = position;
          _loan.amount = num2*100+num3*10+num4+num5*0.1+num6*0.01;
        });
      },
      backgroundColor: Colors.white,
      children: items2,
      looping: true,
    );

    final picker3  = CupertinoPicker(itemExtent: 40,
      onSelectedItemChanged: (position){
        setState(() {
          num3 = position;
          _loan.amount = num2*100+num3*10+num4+num5*0.1+num6*0.01;
        });
      },
      backgroundColor: Colors.white,
      children: items3,
      looping: true,
    );

    final picker4  = CupertinoPicker(itemExtent: 40,
      onSelectedItemChanged: (position){
        setState(() {
          num4 = position;
          _loan.amount = num2*100+num3*10+num4+num5*0.1+num6*0.01;
        });
      },
      backgroundColor: Colors.white,
      children: items4,
      looping: true,
    );

    final picker5  = CupertinoPicker(itemExtent: 40,
      onSelectedItemChanged: (position){
        setState(() {
          num5 = position;
          _loan.amount = num2*100+num3*10+num4+num5*0.1+num6*0.01;
        });
      },
      backgroundColor: Colors.white,
      children: items5,
      looping: true,
    );

    final picker6  = CupertinoPicker(itemExtent: 40,
      onSelectedItemChanged: (position){
        setState(() {
          num6 = position;
          _loan.amount = num2*100+num3*10+num4+num5*0.1+num6*0.01;
        });
      },
      backgroundColor: Colors.white,
      children: items6,
      looping: true,
    );

    showCupertinoModalPopup(context: cxt, builder: (cxt){
      return Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text('¥',style: TextStyle(fontSize: 18,color: Colors.black,decoration: TextDecoration.none),),
              alignment: Alignment.center,
              height: 200,
              width: 20,
            ),
            Container(
              child: picker2,
              height: 200,
              width: 30,
            ),
            Container(
              child: picker3,
              height: 200,
              width: 30,
            ),
            Container(
              child: picker4,
              height: 200,
              width: 30,
            ),
            Container(
              child:  Text('.',style: TextStyle(fontSize: 18,color: Colors.black,decoration: TextDecoration.none),textAlign: TextAlign.center,),
              alignment: Alignment.center,
              height: 200,
              width: 10,
            ),
            Container(
              child: picker5,
              height: 200,
              width: 30,
            ),
            Container(
              child: picker6,
              height: 200,
              width: 30,
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              child: Text('万元',style: TextStyle(fontSize: 18,color: Colors.black,decoration: TextDecoration.none),),
              alignment: Alignment.center,
              height: 200,
              width: 40,
            ),
          ],
        ),
        width: double.infinity,
        color: Colors.white,
        height: 200,
      );
    });
  }
}
