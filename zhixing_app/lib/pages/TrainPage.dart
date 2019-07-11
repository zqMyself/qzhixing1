import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:zhixing/widget/BannerView.dart';
//import 'package:common_utils/common_utils.dart';

import 'CalendarWidget.dart';

class TrainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TraninPageState();
  }

}

class TraninPageState extends State<TrainPage> with SingleTickerProviderStateMixin {
  String mDestination = "惠州";
  String mPlaceOfDeparture = "深圳北";

  Animation<double>   animation;
  AnimationController controller;
  double  rotateValue = 0.0;
  bool    isRotate    = false;
  CurvedAnimation curve;
  bool    isForward   = false;
  double  angle       = math.pi / 2;
  double  temp         = 0;
  double begin = 0.0;
  double end = 1000;
  String _time = "";
//      DateUtil.getDateStrByDateTime(DateTime.now(),format: DateFormat.ZH_MONTH_DAY) + " "+  DateUtil.getZHWeekDay(DateTime.now());//2018年09月16日 23时16分15秒
  DateTime currentTime;
  bool isStudent = false, isHighRail = false;
  @override
  Widget build(BuildContext context) {
    return getTrainPage();
  }

  @override
  void initState() {
    super.initState();


  }


  ///调换出发地和目的地
  void travelChange() {


  }



  ///火车票页面
  Widget getTrainPage(){

    return  new Padding(
        padding: const EdgeInsets.only(left: 0.0,right: 0.0,bottom: 0.0,top: 0.0),
        child: ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            Stack(
              children: <Widget>[
                ///背景
                Container(
                  margin: EdgeInsets.only(top: 120),
                  height:100,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Text("_",style: TextStyle(color: Colors.white),
                  ),
                ),
                Column(
                  children: <Widget>[
                    ///中间圆角部分
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                      child:  Material(
                        elevation: 0.19,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        child:Container(
                          padding: EdgeInsets.only(left: 20,bottom: 10,right: 20,top: 10),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Material(
                                  elevation: 0,
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  color: Colors.orange.withAlpha(30),
                                  child: Row(
                                    children: <Widget>[

                                      Icon(Icons.notifications,color: Colors.orange,),
                                      Container(

                                        ///这里的宽度要小于父级的宽度
                                        width:MediaQuery.of(context).size.width-115,
                                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                        child:Text("已经全面上线候补购票功能,了解候补>",
                                          style: TextStyle(color: Colors.orange.withAlpha(150)),
                                          overflow: TextOverflow.ellipsis,),
                                      ),
                                      Container(
                                        alignment: Alignment.topRight,
                                        child: Icon(Icons.clear,color: Colors.grey.withAlpha(120),),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ///出发地
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
//                                    GestureDetector(
//                                      onTap: (){
//                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
//                                          return CitiesWidget(isStart: true,);
//                                        }));
//                                      },
//                                      child:
                                      Container(
                                          width: 100.0,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(mPlaceOfDeparture,style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.bold),),
                                              Container(
                                                margin: EdgeInsets.only(top: 10,bottom: 10),
                                                width: 100.0,
                                                height: 0.1,
                                                color: Colors.grey.withAlpha(150),
                                                child: Text("_"),
                                              )
                                            ],
                                          )
                                      ),
//                                    ),

                                    ///中间转换图标
                                    Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(bottom: 20),
                                      child : GestureDetector(
                                        onTap: (){
                                          travelChange();
                                        },
                                        child:Transform(
                                          alignment: AlignmentDirectional.center,
                                          transform: Matrix4.identity()..rotateZ(angle),
                                          child: Image.asset("images/icon_travel_change.png",width: 30,height: 30,
                                          ),
                                        )
                                      ),
                                    ),
                                    ///目的地
//                                    GestureDetector(
//                                      onTap: (){
//                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
//                                          return CitiesWidget(isStart: false,);
//                                        }));
//                                      },
//                                      child:
                                      Container(
                                          width: 100.0,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                mDestination,
                                                textAlign:TextAlign.right,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 23,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 10,bottom: 10),
                                                width: 100.0,
                                                height: 0.1,
                                                color: Colors.grey.withAlpha(150),
                                                child: Text("_"),
                                              )
                                            ],
                                          )
                                      ),
//                                    ),

                                  ],
                                ),
                              ),
                              ///时间
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child:GestureDetector(
                                  onTap: (){
                                    Navigator.push<DateTime>(context,MaterialPageRoute(builder: (BuildContext context){
                                      return CalendarWidget(dateTime: currentTime,);
                                    })).then((DateTime result){
                                      if(result == null)
                                        return;
                                      currentTime = result;
                                      setState(() {
//                                        _time =  DateUtil.getDateStrByDateTime(result,format: DateFormat.ZH_MONTH_DAY) + " "+  DateUtil.getZHWeekDay(result);//2018年09月16日 23时16分15秒
                                      });
                                    });
                                  },
                                  child: Text(_time,style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.bold),),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                width: MediaQuery.of(context).size.width,
                                height: 0.1,
                                color: Colors.grey.withAlpha(150),
                                child:GestureDetector(
                                  onTap: (){
                                  },
                                  child: Text(""),
                                ),
                              ),

                              ///火车类型
                              Container(
                                margin: EdgeInsets.only(top: 10,bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 150.0,
                                      child:CheckboxListTile(
                                          title: Text('高铁动车',textAlign:TextAlign.right,style: TextStyle(fontSize: 15),),
                                          value: isHighRail,
                                          onChanged: (bool){
                                            setState(() {
                                              isHighRail = bool;
                                            });
                                          },
                                      ),
                                    ),
                                    Container(
                                      width: 150.0,
                                      child:CheckboxListTile(
                                        title: Text('学生票',textAlign:TextAlign.right,style: TextStyle(fontSize: 15),),
                                        value: isStudent,
                                        onChanged: (bool){
                                          setState(() {
                                            isStudent = bool;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ///火车查询按钮
                              Material(
                                elevation: 0.1,
                                borderRadius: BorderRadius.all(Radius.circular(35)),
                                color: Colors.blue,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(10),
                                  child:Text("火车票查询",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                                ),
                              ),
                              ///历史记录
                              Container(
                                alignment: Alignment.center,
                                height: 40.0,
                                child:ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.only(right: 20),
                                        child:Row(
                                          children: <Widget>[
                                            Text("深圳北",style: TextStyle(color: Colors.grey),),
                                            Icon(Icons.trending_flat,color: Colors.grey,),
                                            Text("广州南",style: TextStyle(color: Colors.grey),),
                                          ],
                                        )
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(right: 20),
                                        child:Row(
                                          children: <Widget>[
                                            Text("深圳北",style: TextStyle(color: Colors.grey),),
                                            Icon(Icons.trending_flat,color: Colors.grey,),
                                            Text("广州南",style: TextStyle(color: Colors.grey),),
                                          ],
                                        )
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(right: 20),
                                        child:Row(
                                          children: <Widget>[
                                            Text("深圳北",style: TextStyle(color: Colors.grey),),
                                            Icon(Icons.trending_flat,color: Colors.grey,),
                                            Text("广州南",style: TextStyle(color: Colors.grey),),
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              ///其他
                            ],
                          ),
                        ),
                      ),
                    ),
                    ///底部其他业务
                    Container(

                      margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 60.0,
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:  <Widget>[
                                Image.asset("images/ic_new_home_bus.png",width: 30.0,height: 30.0,),
                                Container(

                                  margin: EdgeInsets.only(top: 10),
                                  child: Text("汽车/船票",style: TextStyle(color: Colors.grey,fontSize: 12.0),),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 60.0,
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:  <Widget>[
                                Image.asset("images/ic_new_home_bus.png",width: 30.0,height: 30.0,),
                                Container(

                                  margin: EdgeInsets.only(top: 10),
                                  child: Text("打车",style: TextStyle(color: Colors.grey,fontSize: 12.0),),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 60.0,
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:  <Widget>[
                                Image.asset("images/ic_new_home_bus.png",width: 30.0,height: 30.0,),
                                Container(

                                  margin: EdgeInsets.only(top: 10),
                                  child: Text("旅游",style: TextStyle(color: Colors.grey,fontSize: 12.0),),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 60.0,
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:  <Widget>[
                                Image.asset("images/ic_new_home_bus.png",width: 30.0,height: 30.0,),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text("景点门票",style: TextStyle(color: Colors.grey,fontSize: 12.0),),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 10.0,
                      color: Colors.grey.withAlpha(10),
                      child: Text("",),
                    ),
                    ///会员未领取提示
                    Container(
                      padding: EdgeInsets.only(left: 20,top: 10),
                      alignment: Alignment.center,
                      child: Row(
                        children: <Widget>[
                          Image.asset("images/icon_member_crown_silver.png",width: 20.0,height: 20.0,),
                          Container(
                            margin: EdgeInsets.only(left: 5,right: 5),
                            child: Text("白金会员",style: TextStyle(color: Colors.black45,fontSize: 18),),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 220,
                            margin: EdgeInsets.only(right: 5),
                            child: Text(
                              "您有一份带领取的任务奖励",
                              style: TextStyle(color: Colors.grey,fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(right: 5),
                              child: Text(
                                "立即领取 >",
                                style: TextStyle(color: Colors.grey,fontSize: 14),
                              )
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width,
                      height: 1.0,
                      color: Colors.grey.withAlpha(10),
                      child: Text("",),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height:40.0,
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child:  Image.asset("images/icon_member_crown_dack.png",width: 20,height: 20,),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 60,
                            height:34.0,
                            child: Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("上海-南昌",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text("7月6日特价机票",style: TextStyle(color: Colors.grey.withAlpha(200),fontSize: 12),),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: SizedBox(
                                    width: 60,
                                    child: Row(
                                      children: <Widget>[
                                        Image.asset("images/icon_member_crown_dack.png",width: 15,height: 15,),
                                        Container(
                                          child: Text("￥210",style: TextStyle(color: Colors.orange.withAlpha(200),fontSize: 16),),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text("甄选低价",style: TextStyle(color: Colors.grey.withAlpha(200),fontSize: 12),),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ///广告
                    Container(
                      alignment: Alignment.center,
                      height: 70.0,
                      child: BannerView(
                        data: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 10,left: 10,right: 10),
                            child:new ClipRRect(
                              borderRadius: BorderRadius.circular(40.0),
                              child: new Image.asset("images/rn_robticket_sp_discount_cancel_explain.png",fit: BoxFit.fill),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10,left: 10,right: 10),
                            child:new ClipRRect(
                              borderRadius: BorderRadius.circular(40.0),
                              child: new Image.asset("images/rn_robticket_sp_discount_cancel_explain.png",fit: BoxFit.fill),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10,left: 10,right: 10),
                            child:new ClipRRect(
                              borderRadius: BorderRadius.circular(40.0),
                              child: new Image.asset("images/rn_robticket_sp_discount_cancel_explain.png",fit: BoxFit.fill),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ],
            )
          ],
        )
    );
  }
}