import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:recycle/model/WasteListAsset.dart';
import 'package:recycle/view/TabPage.dart';

class CustomerFormD {
  // getter
  CalendarCarousel get calendarCarouselNoHeader => _calendarCarouselNoHeader;
  CalendarCarousel get calendarCarousel => _calendarCarousel;
  DateTime get currentDate2 => _currentDate2;
  EventList<Event> get markedDateMap => _markedDateMap;
  DateTime get targetDateTime => _targetDateTime;
  DateTime get currentDate => _currentDate;
  String get currentMonth => _currentMonth;

  // setter
  set calendarCarouselNoHeader(CalendarCarousel c) =>
      _calendarCarouselNoHeader = c;
  set calendarCarousel(CalendarCarousel c) => _calendarCarousel = c;
  set currentDate2(DateTime d2) => _currentDate2 = d2;
  set markedDateMap(EventList<Event> e) => _markedDateMap = e;
  set targetDateTime(DateTime d) => _targetDateTime = d;
  set currentDate(DateTime d) => _currentDate = d;
  set currentMonth(String m) => _currentMonth = m;

  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;

  //현재 날짜 객체 생성후 년 월 일 삽입
  static var now = DateTime.now();
  DateTime _currentDate = DateTime(now.year, now.month, now.day);
  DateTime _currentDate2 = DateTime(now.year, now.month, now.day);
  String _currentMonth =
      DateFormat.yMMM().format(DateTime(now.year, now.month, now.day));
  DateTime _targetDateTime = DateTime(now.year, now.month, now.day);

  DateTime selectedDate; //선택한 날짜

  //날짜에 이벤트 추가하기
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );
}

CustomerFormD customerformD = new CustomerFormD();

class CustomerFormTC {
  // getter
  get address => _address;

  final _address = TextEditingController();
}

CustomerFormTC customerformTC = new CustomerFormTC();

class CustomerFormController {
  // getter
  List<DropdownMenuItem<String>> get dropDownMenuItems => _dropDownMenuItems;
  String get timeSet => _timeSet; //시간을 담는 변수
  List get time => _time;

  get myBanner => _myBanner;

  // setter
  set dropDownMenuItems(List<DropdownMenuItem<String>> d) =>
      _dropDownMenuItems = d;
  set timeSet(String t) => _timeSet = t; //시간을 담는 변수

  List _time = [
    "시간",
    "09:00 ~ 11:00",
    "11:00 ~ 13:00",
    "13:00 ~ 15:00",
    "15:00 ~ 17:00",
    "17:00 ~ 19:00",
    "19:00 ~ 21:00"
  ];
  String _timeSet; //시간을 담는 변수
  WasteListAsset waste_obj;
  List<DropdownMenuItem<String>> _dropDownMenuItems;

  Future<Widget> customerform_dialogue(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('SUCCESS'),
          content: Text('예약이 완료되었습니다.'),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.popUntil(
                      context, ModalRoute.withName(TabPage.routeName));
                },
                child: Text('Confirm')),
          ],
        );
      },
    );
  }

  // * --------------------------- adMob 관련 ------------------------------
  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutter', 'firebase', 'admob'],
    testDevices: <String>[],
  );

  BannerAd _myBanner = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      });
}

CustomerFormController customerformC = new CustomerFormController();
