import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mortgage_calculator/models/loan.dart';

// ignore: must_be_immutable
class SyndicatedLoanPage extends StatefulWidget{
  Loan commercialLoan;
  Loan providentFundLoan;
  SyndicatedLoanPage(Loan value1,Loan value2){
    commercialLoan = value1;
    providentFundLoan = value2;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SyndicatedLoanState(commercialLoan,providentFundLoan);
  }
}

class SyndicatedLoanState extends State<SyndicatedLoanPage>{
  Loan _commercialLoan;
  Loan _providentFundLoan;

  SyndicatedLoanState(Loan value1,Loan value2){
    _commercialLoan = value1;
    _providentFundLoan = value2;
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
        child: ListView(
          children: <Widget>[
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20,0,20,0),
                  child: ListTile(leading: Text('商业贷款',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),),
                )
              ),
            ),
            Container(
              child:Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child:ListTile(
                                leading: Text('还款金额（万元）',style: TextStyle(fontSize: 16),),
                                trailing: FlatButton(
                                  onPressed: (){
                                    _showCommercialAmountPicker(context);
                                  },
                                  child: Text(_commercialLoan.amount.toStringAsFixed(2)+"万元",style: TextStyle(fontSize: 16),),),
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
                                    _showRatePicker(context,_commercialLoan);
                                  },
                                  child: Text(_commercialLoan.rate.toStringAsFixed(2)+"%",style: TextStyle(fontSize: 16),),),
                              ),
                              height: 40,
                              width: double.infinity,
                            ),
                          ],
                        ),)
                  )
              ),
              width: double.infinity,
              height: 120,
            ),
            Container(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20,0,20,0),
                    child: ListTile(leading: Text('公积金贷款',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),),
                  )
              ),
            ),
            Container(
              child:Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child:ListTile(
                                leading: Text('还款金额（万元）',style: TextStyle(fontSize: 16),),
                                trailing: FlatButton(
                                  onPressed: (){
                                    _showProvidentFundlAmountPicker(context);
                                  },
                                  child: Text(_providentFundLoan.amount.toStringAsFixed(2)+"万元",style: TextStyle(fontSize: 16),),),
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
                                    _showRatePicker(context,_providentFundLoan);
                                  },
                                  child: Text(_providentFundLoan.rate.toStringAsFixed(2)+"%",style: TextStyle(fontSize: 16),),),
                              ),
                              height: 40,
                              width: double.infinity,
                            ),
                          ],
                        ),)
                  )
              ),
              width: double.infinity,
              height: 120,
            ),
            Container(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20,0,20,0),
                    child: ListTile(leading: Text('还款方式明细',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),),
                  )
              ),
            ),
            Container(
              child:Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          children: <Widget>[
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
                                          _commercialLoan.startDate = value;
                                          _providentFundLoan.startDate = value;
                                        });
                                      }
                                    });
                                  },
                                  child: Text(_commercialLoan.startDate.year.toString()+"-"+ _commercialLoan.startDate.month.toString()+"-"+ _commercialLoan.startDate.day.toString(),style: TextStyle(fontSize: 16),),),
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
                                  child: Text(_commercialLoan.year.toString()+"年",style: TextStyle(fontSize: 16),),),
                              ),
                              height: 40,
                              width: double.infinity,
                            ),
                            Divider(),
                            Container(
                              child: ListTile(
                                leading: Text('还款方式',style: TextStyle(fontSize: 16),),
                                trailing: DropdownButton<String>(
                                  value: _commercialLoan.type,
                                  onChanged: (String value){
                                    setState(() {
                                      _commercialLoan.type = value;
                                      _providentFundLoan.type = value;
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
                        ),
                      )
                  )
              ),
              width: double.infinity,
              height: 180,
            ),
          ],
        ),

      ),



//      floatingActionButton: FloatingActionButton(
//        onPressed: (){
//          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
//            return SyndicatedCalculatePage(_commercialLoan,_providentFundLoan);
//          }));
//        print(_providentFundLoan.toJson());
//        print(_commercialLoan.toJson());
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
            _commercialLoan.year=position+1;
            _providentFundLoan.year = position+1;
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

  void _showRatePicker(BuildContext cxt,Loan loan){
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
          loan.rate = num1+num2*0.1+num3*0.01;
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
          loan.rate = num1+num2*0.1+num3*0.01;
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
          loan.rate = num1+num2*0.1+num3*0.01;
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

  void _showCommercialAmountPicker(BuildContext cxt){

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
          _commercialLoan.amount = num2*100+num3*10+num4+num5*0.1+num6*0.01;
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
          _commercialLoan.amount = num2*100+num3*10+num4+num5*0.1+num6*0.01;
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
          _commercialLoan.amount = num2*100+num3*10+num4+num5*0.1+num6*0.01;
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
          _commercialLoan.amount = num2*100+num3*10+num4+num5*0.1+num6*0.01;
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
          _commercialLoan.amount = num2*100+num3*10+num4+num5*0.1+num6*0.01;
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

  void _showProvidentFundlAmountPicker(BuildContext cxt){

    int num3=0;
    int num4=0;
    int num5=0;
    int num6=0;

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

    final picker3  = CupertinoPicker(itemExtent: 40,
      onSelectedItemChanged: (position){
        setState(() {
          num3 = position;
          _providentFundLoan.amount = num3*10+num4+num5*0.1+num6*0.01;
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
          _providentFundLoan.amount = num3*10+num4+num5*0.1+num6*0.01;
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
          _providentFundLoan.amount = num3*10+num4+num5*0.1+num6*0.01;
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
          _providentFundLoan.amount = num3*10+num4+num5*0.1+num6*0.01;
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