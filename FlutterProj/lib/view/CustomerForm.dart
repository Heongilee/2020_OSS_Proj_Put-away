library flutter_calendar_dooboo;

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:recycle/controller/AccessMyFirestore.dart';
import 'package:recycle/controller/CustomerFormController.dart';
import 'package:recycle/controller/FluttertoastPlugin.dart';
import 'package:recycle/controller/InternetCheckController.dart';
import 'package:recycle/model/AccountSnapshot.dart';
import 'package:recycle/view/TakingPicture.dart';
import 'package:recycle/model/WasteListAsset.dart';
import 'package:recycle/model/ReservationDTO.dart';
import 'package:recycle/model/MyApp_config.dart';

class CustomerForm extends StatefulWidget {
  static const routeName = '/CustomerForm';

  @override
  _CustomerForm createState() => _CustomerForm();
}

class _CustomerForm extends State<CustomerForm> {
  @override
  void initState() {
    customerformC.dropDownMenuItems = getDropDownMenuItems();
    customerformC.timeSet = customerformC.dropDownMenuItems[0].value;

    customerformC.waste_obj = new WasteListAsset();
    super.initState();

    //광고 appId 부분
    String appId = "ca-app-pub-9179900992913670~4602448319";
    FirebaseAdMob.instance.initialize(appId: appId);
    customerformC.myBanner
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
      );
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String time in customerformC.time) {
      items.add(new DropdownMenuItem(value: time, child: new Text(time)));
    }
    return items;
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      customerformC.timeSet = selectedCity;
    });
  }

  Widget build(BuildContext context) {
    final CustomerForm_AccountSnapshot args =
        ModalRoute.of(context).settings.arguments;

    customerformD.calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() {
          customerformD.currentDate2 = date;
        });
        events.forEach((event) => print(event.title));

        customerformD.selectedDate = date;
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: customerformD.markedDateMap,
      height: 420.0,
      selectedDateTime: customerformD.currentDate2,
      targetDateTime: customerformD.targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: Colors.yellow)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      minSelectedDate: customerformD.currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: customerformD.currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          customerformD.targetDateTime = date;
          customerformD.currentMonth =
              DateFormat.yMMM().format(customerformD.targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );
    
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              customerformC.myBanner.dispose();
              Navigator.popUntil(
                  context, ModalRoute.withName(TakingPicture.routeName));
            }),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          '대형 폐기물 수거 신청',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
      ),
      body: _buildBody(args),
    );
  }

  Widget _buildBody(CustomerForm_AccountSnapshot args) {
    return WillPopScope(
      onWillPop: () {
        customerformC.myBanner.dispose();
        Navigator.pop(context);
      },
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              // TODO : 상수값 말고 디바이스 프레임 사이즈 얻어오는 방법 알아보기...
              height: MediaQuery.of(context).size.height + 1000.0,
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10.0)),
                  Flexible(
                    // address
                    child: Container(
                      alignment: Alignment(0.0, 0.0),
                      height: 45,
                      margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 1, color: Colors.black12),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 60,
                            child: Text(
                              "주소",
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(right: 20),
                              child: StreamBuilder<DocumentSnapshot>(
                                  stream: myFirestore.db
                                      .collection('user')
                                      .document(args.currentAccount.documentID)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    } else {
                                      final DocumentSnapshot document =
                                          snapshot.data;
                                      customerformTC.address.text =
                                          document['address'];
                                      return TextField(
                                        readOnly: true,
                                        controller: customerformTC.address,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                          hintText: null,
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              color: Colors.grey[300]),
                                        ),
                                        cursorColor: Colors.blue,
                                      );
                                    }
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    child: customerformD.calendarCarousel,
                  ), // This trailing comma makes auto-formatting nicer for build methods.
                  //custom icon without header
                  Container(
                    margin: EdgeInsets.only(
                      top: 30.0,
                      bottom: 16.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: new Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          customerformD.currentMonth,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        )),
                        FlatButton(
                          child: Text('PREV'),
                          onPressed: () {
                            setState(() {
                              customerformD.targetDateTime = DateTime(
                                  customerformD.targetDateTime.year,
                                  customerformD.targetDateTime.month - 1);
                              customerformD.currentMonth = DateFormat.yMMM()
                                  .format(customerformD.targetDateTime);
                            });
                          },
                        ),
                        FlatButton(
                          child: Text('NEXT'),
                          onPressed: () {
                            setState(() {
                              customerformD.targetDateTime = DateTime(
                                  customerformD.targetDateTime.year,
                                  customerformD.targetDateTime.month + 1);
                              customerformD.currentMonth = DateFormat.yMMM()
                                  .format(customerformD.targetDateTime);
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    child: customerformD.calendarCarouselNoHeader,
                  ),
                  SizedBox(
                    width: 250,
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        child: DropdownButton(
                          value: customerformC.timeSet,
                          items: customerformC.dropDownMenuItems,
                          onChanged: changedDropDownItem,
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10.0)),
                  Text(
                    'Total : ${args.totalPrice} 원',
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(padding: EdgeInsets.all(10.0)),
                  SizedBox(
                    width: 300,
                    child: RaisedButton(
                        child: Text(
                          '제 출',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        onPressed: () {
                          myInternetCheck
                              .checkInternetAccess(context)
                              .then((bool onValue) async {
                            if (onValue) {
                              myFlutterToast
                                  .showMyToastAlertMsg("잠시만 기다려 주세요...");
                              // TODO : URL을 얻어서 같이 업로드함.
                              myReservation
                                  .uploadMyListViewItem(args)
                                  .then((List<String> outputURL) {
                                List<String> _getselectedItem_Products =
                                    new List();
                                List<String> _getselectedItem_Details =
                                    new List();
                                args.selectedListItem
                                    .forEach((Map selectedItem) {
                                  _getselectedItem_Products.add(customerformC
                                      .waste_obj
                                      .trashList[selectedItem.keys.first]
                                      .koreaname);
                                  _getselectedItem_Details
                                      .add(selectedItem.values.first);
                                });
                                myReservation
                                    .insertReservation(new ReservationDTO(
                                  reserveId: args.currentAccount.data['id'],
                                  reserveDate: DateTime.now(),
                                  reserveAddress:
                                      args.currentAccount.data['address'],
                                  reserveState: myReservation
                                      .reservationStateList[0], // 접수 완료
                                  reserveVisitDate: customerformD.selectedDate,
                                  reserveVisitTime: customerformC.timeSet,
                                  reserveProducts: _getselectedItem_Products,
                                  reserveDetails: _getselectedItem_Details,
                                  reserveFiles: outputURL,
                                  clientToken:
                                      myapp_config_instance.clientToken,
                                ).toJson());
                              }).then((value) {
                                customerformC.customerform_dialogue(context);
                              });
                              customerformC.myBanner.dispose();
                            } else {
                              myInternetCheck.errorMsg(context);
                            }
                          });
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
