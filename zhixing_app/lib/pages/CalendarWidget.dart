import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
// ignore: must_be_immutable
class CalendarWidget extends StatefulWidget {
  DateTime  dateTime;
  CalendarWidget({this.dateTime});
  @override
  State<StatefulWidget> createState() {
    return CalendarWidgetState();
  }
}

class CalendarWidgetState extends State<CalendarWidget>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("选择日期",style: TextStyle(color: Colors.black,fontSize: 14),),
      ),
      body: getCaluendarWidget(),
    );
  }

  Widget getCaluendarWidget() {
      return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: CalendarCarousel<Event>(
            onDayPressed: (DateTime date, List<Event> events) {
              this.setState(() => widget.dateTime = date);
              events.forEach((event) => print(event.title));
              print("${date.toIso8601String()}");
              Navigator.pop(context,date);
            },
            todayButtonColor: Colors.transparent,
            todayBorderColor: Colors.transparent,
            todayTextStyle:TextStyle(
              color: Colors.black,
            ),
            weekdayTextStyle:TextStyle(
              color: Colors.blue,
            ),
            weekendTextStyle: TextStyle(
              color: Colors.black,
            ),

            selectedDayButtonColor: Colors.blue,
            selectedDayBorderColor: Colors.blue,
            thisMonthDayBorderColor: Colors.transparent,
            daysHaveCircularBorder:true,
            weekFormat: false,
            height: 420.0,
            selectedDateTime: widget.dateTime,
          ));
    }
}

