import 'package:flutter/material.dart';
import 'package:mortgage_calculator/models/loan.dart';
import 'package:mortgage_calculator/utils/EventBus.dart';
import 'package:mortgage_calculator/views/calculate_page.dart';
import 'package:mortgage_calculator/views/commercial_loan_page.dart';
import 'package:mortgage_calculator/views/providentfund_loan_page.dart';
import 'package:mortgage_calculator/views/syndicated_calculate_page.dart';
import 'package:mortgage_calculator/views/syndicated_loan_page.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  String title="";

  Color mainColor;

  HomePage(Color value){
    mainColor = value;
  }

  @override
  _HomePageState createState() => _HomePageState(mainColor);
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  Loan _commercialLoan = new Loan(0, DateTime.now(), 30, 4.9, '等额本息');
  Loan _providentFundLoan = new Loan(0, DateTime.now(), 30, 3.25, '等额本息');

  Loan _syCommercialLoan = new Loan(0, DateTime.now(), 30, 4.9, '等额本息');
  Loan _syProvidentFundLoan = new Loan(0, DateTime.now(), 30, 3.25, '等额本息');

  Color mainColor;
  Color textColor;
  _HomePageState(Color value){
    mainColor = value;
  }

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: _titles.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  static final _titles = ['商业贷款','公积金贷款','组合贷款'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('贷款分类',style: TextStyle(fontSize: 20),),
        elevation: 0,
        bottom: PreferredSize(
            child: TabBar(
                tabs: [
                  Tab(
                    text: '商业贷款',
                    icon: Icon(Icons.business),
                  ),
                  Tab(
                    text: '公积金贷款',
                    icon: Icon(Icons.account_balance),
                  ),
                  Tab(
                    text: '组合贷款',
                    icon: Icon(Icons.link),
                  )
                ],
              controller: _tabController,
              isScrollable: true,
              indicatorWeight: 5,
            ),
            preferredSize: Size(double.infinity, 70)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: (){
              showModalBottomSheet<Null>(context:context, builder:(BuildContext context) {
                return Container(
                    height: 100,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            child: RaisedButton(
                              onPressed: (){
                                _fireChangeTheme(Colors.yellow);
                                setState(() {
                                  textColor=Colors.black;
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)
                              ),
                              color: Colors.yellow,
                            ),
                            height: 50,
                            width: 50
                          ),
                          SizedBox(width: 10,),
                          Container(
                              child: RaisedButton(
                                onPressed: (){
                                  _fireChangeTheme(Colors.teal);
                                  setState(() {
                                    textColor=Colors.white;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)
                                ),
                                color: Colors.teal,
                              ),
                              height: 50,
                              width: 50
                          ),
                          SizedBox(width: 10,),
                          Container(
                              child: RaisedButton(
                                onPressed: (){
                                  _fireChangeTheme(Colors.indigo);
                                  setState(() {
                                    textColor=Colors.white;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)
                                ),
                                color: Colors.indigo,
                              ),
                              height: 50,
                              width: 50
                          ),
                          SizedBox(width: 10,),
                          Container(
                              child: RaisedButton(
                                onPressed: (){
                                  _fireChangeTheme(Colors.deepPurple);
                                  setState(() {
                                    textColor=Colors.white;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)
                                ),
                                color: Colors.deepPurple,
                              ),
                              height: 50,
                              width: 50
                          ),
                          SizedBox(width: 10,),
                          Container(
                              child: RaisedButton(
                                onPressed: (){
                                  _fireChangeTheme(Colors.pink);
                                  setState(() {
                                    textColor=Colors.white;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)
                                ),
                                color: Colors.pink,
                              ),
                              height: 50,
                              width: 50
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                    )
                  );
              });
            },
          )
        ],
      ),
      body:GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: TabBarView(
            controller: _tabController,
            children: [
              CommercialLoanPage(_commercialLoan),
              ProvidentFundLoanPage(_providentFundLoan),
              SyndicatedLoanPage(_syCommercialLoan,_syProvidentFundLoan)
            ],
          physics: ScrollPhysics(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
          onPressed: (){
          if(_tabController.index==0){
            if(_commercialLoan.amount==0){
              showDialog(context: context,builder: (BuildContext context){
                return AlertDialog(
                  content: Text('请输入贷款金额'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('确定',style: TextStyle(color: Colors.black),),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              });
            }else{
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return CalculatePage(_commercialLoan,textColor);}));
            }
          }else if(_tabController.index==1){
            if(_providentFundLoan.amount==0){
              showDialog(context: context,builder: (BuildContext context){
                return AlertDialog(
                  content: Text('请输入贷款金额'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('确定',style: TextStyle(color: Colors.black),),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              });
            }else{
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return CalculatePage(_providentFundLoan,textColor);
              }));
            }
          }else if(_tabController.index==2){
            if(_syProvidentFundLoan.amount==0&&_syCommercialLoan.amount==0){
              showDialog(context: context,builder: (BuildContext context){
                return AlertDialog(
                  content: Text('请输入贷款金额'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('确定',style: TextStyle(color: Colors.black),),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              });
            }else{
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return SyndicatedCalculatePage(_syCommercialLoan,_syProvidentFundLoan,textColor);
              }));
            }
          }
        })
    );
  }
  
  void _fireChangeTheme(Color value){
    eventBus.fire(ChangeThemeEvent(value));
  }

  Color setTextColor(Color value){
    if(value==Colors.yellow){
      print('1');
      return Colors.green;
    }else{
      print('2');
      return Colors.white;
    }
  }
}