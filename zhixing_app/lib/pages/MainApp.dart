import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'HomePage.dart';
import 'MySelfPage.dart';
import 'OrderPage.dart';
import 'SliverAppBar1.dart';
import 'TicketPage.dart';


class MainApp extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return MainAppState();
  }

}
class MainAppState extends State<MainApp>{

  List<BottomNavigationBarItem> mNavigationViews;

  var mTitles       = ["首页","抢票","订票","我的"];
  var mNavgatorKey  = GlobalKey<NavigatorState>();
  var mIndex        = 0;
  var mBody;

  void iniData(){
    mBody = IndexedStack(
      children: <Widget>[HomePage(),SliverAppBar1(),HomePage(),HomePage()],
      index: mIndex,
    );
  }

  @override
  void initState() {
    super.initState();
    mNavigationViews = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          activeIcon:Image.asset("images/icon_home_home_sel.png",width: 40.0,height: 40.0,),
          icon:Image.asset("images/icon_home_home.png",width: 40.0,height: 40.0,),
          title: Text(mTitles[0]),
          backgroundColor: Colors.blue
      ),
      BottomNavigationBarItem(

          activeIcon:Image.asset("images/icon_home_mine_sel.png",width: 40.0,height: 40.0,),
          icon:Image.asset("images/icon_home_mine.png",width: 40.0,height: 40.0,),
          title: Text(mTitles[1]),
          backgroundColor: Colors.blue
      ),
      BottomNavigationBarItem(
          activeIcon:Image.asset("images/icon_home_order_sel.png",width: 40.0,height: 40.0,),
          icon:Image.asset("images/icon_home_order.png",width: 40.0,height: 40.0,),
          title: Text(mTitles[2]),
          backgroundColor: Colors.blue
      ),
      BottomNavigationBarItem(
          activeIcon:Image.asset("images/icon_home_qiangpiao_sel.png",width: 40.0,height: 40.0,),
          icon:Image.asset("images/icon_home_qiangpiao.png",width: 40.0,height: 40.0,),
          title: Text(mTitles[3]),
          backgroundColor: Colors.blue
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {

    iniData();
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }


    return MaterialApp(
      navigatorKey: mNavgatorKey,
      theme: ThemeData(primaryColor: Colors.blue, accentColor: Colors.blue),
      home: Scaffold(
        body: mBody,
        bottomNavigationBar: BottomNavigationBar(
            items: mNavigationViews
                .map((BottomNavigationBarItem navigationView) => navigationView).toList(),
            currentIndex: mIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index){
              setState(() {
                mIndex = index;
              });
            }),
      ),


    );
  }

}
