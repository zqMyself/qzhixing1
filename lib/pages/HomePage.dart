import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zhixing/widget/BannerView.dart';
import 'package:zhixing/widget/QTabBar.dart';

import 'TrainPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return  HomePageState();
  }

}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  List<Choice> tabs = [];
  TabController mTabController;
  int mCurrentPosition = 0;
  ScrollController _controller = new ScrollController();
  double mOpacity = 0;
  double mOpacity2 = 1;
  double mBackGroundWidth = 280;

  @override
  void initState() {
    super.initState();

    initData();
    tabs.add(Choice(title: '火车票',
        icon: "images/ic_home_tab_train.png",
        iconSel: "images/ic_home_tab_train_sel.png",
        position: 0));
    tabs.add(Choice(title: '机票',
        icon: "images/ic_home_tab_flight.png",
        iconSel: "images/ic_home_tab_flight_sel.png",
        position: 1));
    tabs.add(Choice(title: '酒店',
        icon: "images/ic_home_tab_hotel.png",
        iconSel: "images/ic_home_tab_hotel_sel.png",
        position: 2));
    mTabController = new TabController(vsync: this, initialIndex : 0,length: tabs.length);
    mTabController.animation.addStatusListener((listener){
      print("listener = ${listener.index}");

    });

    //判断TabBar是否切换
    mTabController.animation.addListener(() {
      print("mTabController.index  = ${mTabController.index}");
      if (mTabController.indexIsChanging) {
        setTab(mTabController.index);
      }
    });
  }

  void initData() {
    _controller.addListener(() {
      setState(() {
        //设置标题tab 透明度 0 ~ 1
        //1、设置百分比 将范围设置在0 ~ 1
        if (_controller.offset >= 100) {
          mOpacity = 1;
          mOpacity2 = 0;
        } else if (_controller.offset > 10 && _controller.offset < 100) {
          mOpacity = _controller.offset * 0.01;
          mOpacity2 = 1 - _controller.offset * 0.01;
          mBackGroundWidth  = 280 -  (_controller.offset);

        } else {
          mOpacity = 0;
          mOpacity2 = 1;
          mBackGroundWidth  = 280 -  (_controller.offset);
        }
//        //动态设置圆角背景的大小
//        if (_controller.offset < 30) {
//        }
      });

    });
  }

  Widget getTitleColumn() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: (() {
              setTab(0);
            }),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 5.0),
                  child: Image.asset(
                    "images/ic_home_tab_train_small.png", width: 20.0,
                    height: 60.0,),
                ),

                Text("火车票",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          GestureDetector(
            onTap: (() {
              setTab(1);
            }),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 5.0),
                  child: Image.asset(
                    "images/ic_home_tab_flight_small.png",
                    width: 20.0,
                    height: 20.0,),
                ),
                Text("机票",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: (() {
              setTab(2);
            }),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 5.0),
                  child: Image.asset(
                    "images/ic_home_tab_hotel_small.png", width: 20.0,
                    height: 20.0,),
                ),

                Text("酒店",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
              ],
            ),
          )
        ],
      ),
    );
  }


  Widget getTopColumn() {
    return Container(

      width: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: getRow()
      );
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
        Material(
          borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(35,20),bottomRight: Radius.elliptical(35,20)),
          color: Colors.blue,
          child: Container(
            width: double.infinity,
            height:mBackGroundWidth,
          ),
        ),
        NestedScrollView(
          controller: _controller,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
              centerTitle: true,
              pinned: true,
              elevation: 0,
              primary: true,
              expandedHeight: 130.0,
              titleSpacing: 0.0,
              title: Opacity(
                   opacity: mOpacity, child: new Container(
                  color: Colors.transparent,
                  child: getTitleColumn()
              ),
              ),
//              TabBar(
//                  indicatorWeight: 0.1,
//                  controller: mTabController,
//                  tabs: tabs.map((Choice choice){
//                return Tab(
//                  text: "",
//                );
//              }).toList()),
              flexibleSpace:
              Opacity(opacity: mOpacity2,
                  child:new Column(
                    children: <Widget>[
                      Expanded(
                        child: new Container(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white.withAlpha(90),
                              elevation: 0,
                              child:
                              new Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  height: 30.0,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.search,color: Colors.white.withAlpha(200),),
                                      Text("可搜索火车.酒店.门票",
                                        style: TextStyle(color: Colors.white.withAlpha(200)),
                                      ),

                                    ],
                                  ),
                              )
                          ),
                        ),
                      ),
                      Expanded(
                        child: new Container(
                          alignment: Alignment.bottomCenter,
                          color: Colors.transparent,
                          child: getTopColumn(),
                        ),
                      ),
                    ],
                  )
              ),
            )
            ];
          },
          body: new TabBarView(
                children: tabs.map((Choice choice) {
                    return  getPageView(choice.position);
                    }).toList(),
                controller: mTabController,
                ),
          ),
      ],
      )
    );
  }



  @override
  void dispose() {
    super.dispose();
    mTabController.dispose();

  }


  void setTab(int position) {

    setState(() {
        mTabController.index = position;
        mCurrentPosition = position;
    });
  }
  ///获取垂直布局的TabItem
  Widget getColumn(Choice choice) {

    return   GestureDetector(
      onTap: ((){
        setTab(choice.position);
      }),
      child:Column(

        mainAxisAlignment:MainAxisAlignment.center ,
        children:  <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: mCurrentPosition == choice.position
                ? Image.asset(  choice.iconSel,width: 50.0,height: 35.0,)
                : Image.asset(  choice.icon,width: 50.0,height: 35.0,
            ),
          ),
          Container(
          width: 60,
          alignment: Alignment.center,
          child:  Text(choice.title,style: mCurrentPosition == choice.position
              ? TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white )
              : TextStyle(fontSize: 15,color: Colors.white.withAlpha(180) ),
            ),
          )
        ],
      ),);
  }


  ///获取水平布局的Tab
  Widget  getRow() {
    return  new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tabs.map((Choice choice) {
      return getColumn(choice);
    }).toList());
  }

  ///添加page
  Widget getPageView(int pos){

    switch(pos){
      case 0 :
        return TrainPage();
      case 1 :
        return TrainPage();
      case 2 :
        return TrainPage();
    }
  }



}









class Choice {
  const Choice({ this.title, this.icon,this.iconSel, this.position});
  final String title;
  final int position;
  final String icon;
  final String iconSel;
}
