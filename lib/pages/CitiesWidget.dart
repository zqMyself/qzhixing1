import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert' show json;

import 'package:zhixing/bean/Place.dart';
// ignore: must_be_immutable
class CitiesWidget extends StatefulWidget {
  bool isStart = true;
  String start = "";
  String end ="";
  CitiesWidget({this.isStart,this.start,this.end});


  @override
  State<StatefulWidget> createState() {
    return CitiesStateWidget();
  }

}
const INDEX_BAR_WORDS = [
  "常用", "热门",
  "A", "B", "C", "D", "E", "F", "G",
  "H", "I", "J", "K", "L", "M", "N",
  "O", "P", "Q", "R", "S", "T", "U",
  "V", "W", "X", "Y", "Z"
];

class CitiesStateWidget extends State<CitiesWidget>{
  ScrollController _scrollController;
  ScrollController _scrollController2;
  TextEditingController mStartTextEditingController;
  TextEditingController mEndTextEditingController;
  final Map _letterPosMap = {INDEX_BAR_WORDS[0]:0.0};
  List<CityInfo> _cityList = new List<CityInfo>();
  String  _tag ;
  String  _suspensionTag ;
  bool isShow =true;
  double inputWidthSelect   = 1.0;
  double inputWidthUnSelect = 1.0;
  bool isStartSelect = false;
  bool isEndSelect = false;
  FocusNode  endFcusNode;
  FocusNode  startFcusNode;
  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    isStartSelect =true;
    _scrollController.addListener((){
//      print("offset = ${_scrollController.offset}");
//      print("length = ${_cityList.length}");
//      if(_scrollController.offset.floor() < _cityList.length ){
//        int index = (_scrollController.offset/ 40.5).clamp(0, _cityList.length - 1).floor();
//        if(_cityList[index].tag != null){
////          setState(() {
////            _suspensionTag = _cityList[index].tag;
////          });
////          print("${_cityList[index].tag}");
////        }
//      }

    });
    loadData();

    mStartTextEditingController = TextEditingController.fromValue(TextEditingValue(
        text:widget.start,
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream,
            offset: widget.start.length)
        )
    ));


    mEndTextEditingController = TextEditingController.fromValue(TextEditingValue(
        text:widget.end,
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream,
            offset: widget.end.length)
        )
    ));
    startFcusNode = FocusNode();
    endFcusNode = FocusNode();
    startFcusNode.addListener((){
      if(startFcusNode.hasFocus) {
        setState(() {
          isStartSelect = true;
          isEndSelect   = false;
        });

        print("startFcusNode = ${startFcusNode}");
      }
    });
    endFcusNode.addListener((){
      if(endFcusNode.hasFocus) {
        print("endFcusNode = ${endFcusNode}");
        setState(() {
          isStartSelect = false;
          isEndSelect   = true;
        });


      }
    });
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void loadData() async {
    //加载城市列表
    rootBundle.loadString('assetss/cities.json').then((value) {

      List<dynamic> list = json.decode(value);
      print("value = ${list.length}");

      list.forEach((value) {
        String encode = json.encode(value);
        Map<String,dynamic> map = json.decode(encode);
        List<dynamic> list2 = json.decode(json.encode(map["s"]));
        _cityList.add(CityInfo(tag: map["t"]));
        list2.forEach((value){
          String encode = json.encode(value);
          Map<String,dynamic> map = json.decode(encode);
          _cityList.add(CityInfo(name: map["n"]));
        });
      });
//      _handleList(_cityList);
//
      setState(() {

      });
    });
  }




  ///返回
  void _pop(BuildContext context,CityInfo cityInfo){
    if(cityInfo != null) {
      if(isEndSelect) {
        mEndTextEditingController.text = cityInfo.name;
      }else {
        mStartTextEditingController.text = cityInfo.name;
      }
    }

    if(isEndSelect || cityInfo == null){
      Place place = new Place();
      place.end = mEndTextEditingController.text;
      place.start = mStartTextEditingController.text;
      Navigator.pop(context,place);
    }

  }

  void  _jumpToIndex(String tag) {

    for(int i =0;i< _cityList.length;i++){
      if(_cityList[i].tag !=null && _cityList[i].tag == tag){
        _scrollController.animateTo(i * 40.5,
            duration: new Duration(microseconds: 10), curve: Curves.ease);
      }
    }

  }

  String getLetter(BuildContext context,double tileHeight,  Offset globalPos) {
    RenderBox _box = context.findRenderObject();
    var local =  _box.globalToLocal(globalPos);
    int index = (local.dy~/tileHeight).clamp(0, INDEX_BAR_WORDS.length - 1);
    return INDEX_BAR_WORDS[index];
  }

  ///右侧
  Widget _buildIndexBar(BuildContext context, BoxConstraints constraints) {
    final List<Widget> _letters = INDEX_BAR_WORDS.map((String word) {
      return Expanded(child: Text(word,style: TextStyle(fontSize: 12,color: Colors.black),));
    }).toList();

    final _totalHeight = constraints.biggest.height ;
    final _tileHeight = _totalHeight / _letters.length ;
    return GestureDetector(
      onVerticalDragDown: (DragDownDetails details) {
        setState(() {
          _tag = getLetter(context,_tileHeight,details.globalPosition);
          _jumpToIndex(_tag);
        });
      },
      onVerticalDragEnd: (DragEndDetails details) {
        setState(() {
          _tag = null;
        });
      },
      onVerticalDragCancel: (){
        setState(() {
          _tag = null;

        });
      },
      onVerticalDragUpdate: (DragUpdateDetails details){
        setState(() {
          _tag = getLetter(context,_tileHeight,details.globalPosition);
          _jumpToIndex(_tag);

        });
      },
      child: Column(
        children: _letters,
      ),
    );
  }


  ///标签 or
  Widget _buildSusWidget(String susTag){

    return Container(
      height: 40.0,
      padding: const EdgeInsets.only(left: 15.0),
      color: Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$susTag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xff999999),
        ),
      ),
    );
  }

  ///构建列表 item Widget.
  Widget _buildListItem(CityInfo model) {

      if(model.tag != null ){
        return Offstage(
          offstage: model.tag ==null ? true : false,
          child: _buildSusWidget(model.tag),
        );
      }else {
        return InkWell(
          onTap: (){

            _pop(context,model);
          },
          child:  Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 40.0,
                  padding: EdgeInsets.only(left: 18),
                  alignment: Alignment.centerLeft,
                  child: Text((model.name == null ? "" : model.name),
                    style: TextStyle(color: Colors.black, fontSize: 16),),
                ),
                Container(
                  color: Color.fromARGB(100, 131, 130, 130),
                  margin: EdgeInsets.only(right: 40.0),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 0.5,
                ),
              ],),
          )
        );

      }

  }



  @override
  Widget build(BuildContext context) {
    inputWidthUnSelect =  MediaQuery.of(context).size.width * 0.3;
    inputWidthSelect = MediaQuery.of(context).size.width * 0.6;
    final List<Widget> _body = [
      Container(
        height: 50.0,
        color: Colors.blue,
        child: Row(
          children: <Widget>[
            Container(
              width: isStartSelect ? inputWidthSelect : inputWidthUnSelect,
              margin: EdgeInsets.only(left: 15,right: 10,bottom: 10),
              child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)) ,
                  child:  Column(
                    children: <Widget>[
                  Container(
                  padding: EdgeInsets.only(left: 5.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: 40,
                        maxWidth: 200
                    ),

                    child: TextField(
                      focusNode: startFcusNode,
                      decoration: InputDecoration(
                          border: InputBorder.none
                      ),
                      scrollPadding: EdgeInsets.all(0.0),
                      controller: mStartTextEditingController,
                      onEditingComplete: (){

                      },
                    ),
                  ),
                  ),
                 ],
                ),
              )
            ),
            Container(
                width: isEndSelect ? inputWidthSelect : inputWidthUnSelect,
                margin: EdgeInsets.only(right: 0,bottom: 10),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)) ,
                  child:  Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 5.0),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: 40,
                              maxWidth: 200
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),
                            focusNode: endFcusNode,
                            controller: mEndTextEditingController,
                            onEditingComplete: (){
                              _pop(context,null);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),

      ]),
      ),
      Container(
        margin: EdgeInsets.only(top: 50.0),
        child:  ListView.builder(

          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            return _buildListItem(_cityList[index]);
          },
          itemCount: _cityList.length,
        ),
      ),
      Positioned(
        width: 40,
        right: 0.0,
        top: 50.0,
        bottom: 0.0,
        child: Container(
          color: Color(0xfff3f4f5),
          child: LayoutBuilder(
            builder: _buildIndexBar,
          ),
        ),
      )
    ];//wx_follow
      //wx123456
      _body.add(
          //中间悬浮提示
          Offstage(
          offstage: _tag == null ? true:false ,
          child: Align(
                alignment: Alignment.center,
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Colors.blue,
                  child:Container(
                    alignment: Alignment.center,
                    width: 60,
                    height: 60,
                    padding: EdgeInsets.all(10),
                    child:Text(_tag == null ? "":_tag),
              ),
            ),
          )
     ));
//    _body.add(
//      //顶部悬停提示
//        Offstage(
//          offstage: _suspensionTag == null ? true : false,
//          child: _buildSusWidget(_suspensionTag),
//        )
//    );


    return  Scaffold(
        appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,

        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20.0),
            alignment: Alignment.center,
            child:InkWell(
              onTap: (){
                _pop(context,null);
              },
              child: Text("确定",style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.bold),),
            )

         )
        ],
        title: widget.isStart
            ? Text("出发站",style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold),)
            : Text("到达站",style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold),)
      ),
      body: Container(child: Stack(
        children: _body,
      )),
    );
  }

}

class CityInfo {
  String name;
  String tag;
  String isShow; //是否悬停
  CityInfo({this.name,this.tag});
}

class City{
  String s;
  String n;
}