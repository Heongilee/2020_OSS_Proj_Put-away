import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recycle/controller/SelectedReservationInfoController.dart';


class SelectedReservationInfo extends StatefulWidget {
  final _currentReservation;

  SelectedReservationInfo(this._currentReservation);
  @override
  _SelectedReservationInfoState createState() => _SelectedReservationInfoState();
}

class _SelectedReservationInfoState extends State<SelectedReservationInfo>{
  @override
  void initState() {
    super.initState();

    selectedreservationinfoTC.address.text = widget._currentReservation["reserveAddress"];
    selectedreservationinfoTC.id.text = widget._currentReservation["reserveId"];
    selectedreservationinfoTC.visitDate.text = widget._currentReservation["reserveVisitDate"];
    selectedreservationinfoTC.reserveDate.text = widget._currentReservation["reserveDate"];
    selectedreservationinfoTC.visitTime.text = widget._currentReservation["reserveVisitTime"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Text(
        '예약 상세 정보',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          }),
      );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          // physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height + 200.0,
            child: Column(
              children: <Widget>[
                  Padding(padding: EdgeInsets.all(8.0)),
                  Flexible(
                    // ID
                    child: Container(
                      alignment: Alignment(0.0, 0.0),
                      height: 45,
                      margin: EdgeInsets.only(left: 30, right: 30, top: 5),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 1, color: Colors.black12),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 100,
                            child: Text(
                              "예약자 아이디",
                              style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(right: 20),
                              child: TextField(
                                readOnly: true,
                                controller: selectedreservationinfoTC.id,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey[300]),
                                ),
                                cursorColor: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    // Address
                    child: Container(
                      alignment: Alignment(0.0, 0.0),
                      height: 45,
                      margin: EdgeInsets.only(left: 30, right: 30, top: 5),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 1, color: Colors.black12),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 100,
                            child: Text(
                              "예약자 주소",
                              style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(right: 20),
                              child: TextField(
                                readOnly: true,
                                controller: selectedreservationinfoTC.address,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey[300]),
                                ),
                                cursorColor: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    // reserveDate
                    child: Container(
                      alignment: Alignment(0.0, 0.0),
                      height: 45,
                      margin: EdgeInsets.only(left: 30, right: 30, top: 5),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 1, color: Colors.black12),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 100,
                            child: Text(
                              "예약 날짜",
                              style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(right: 20),
                              child: TextField(
                                readOnly: true,
                                controller: selectedreservationinfoTC.reserveDate,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey[300]),
                                ),
                                cursorColor: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 30.0)),
                      Text("예약 상세 목록", textScaleFactor: 1.2, style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  _buildListView(widget._currentReservation),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 30.0)),
                      Text("물품 사진", textScaleFactor: 1.2, style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  _buildMyTrashImages(widget._currentReservation),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Flexible(
                    // VisitDate
                    child: Container(
                      alignment: Alignment(0.0, 0.0),
                      height: 45,
                      margin: EdgeInsets.only(left: 30, right: 30, top: 5),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 1, color: Colors.black12),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 100,
                            child: Text(
                              "방문 날짜",
                              style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(right: 20),
                              child: TextField(
                                readOnly: true,
                                controller: selectedreservationinfoTC.visitDate,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey[300]),
                                ),
                                cursorColor: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    // VisitTime
                    child: Container(
                      alignment: Alignment(0.0, 0.0),
                      height: 45,
                      margin: EdgeInsets.only(left: 30, right: 30, top: 5),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 1, color: Colors.black12),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 100,
                            child: Text(
                              "방문 시간",
                              style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(right: 20),
                              child: TextField(
                                readOnly: true,
                                controller: selectedreservationinfoTC.visitTime,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey[300]),
                                ),
                                cursorColor: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _buildListView(DocumentSnapshot myDocumentSnapshot_element) {
    List _currentProducts = myDocumentSnapshot_element['reserveProducts'];
    List _currentDetails = myDocumentSnapshot_element['reserveDetails'];
    return Container(
      width: 300,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Scrollbar(
        child: ListView.builder(
          itemCount: _currentProducts.length * 2,
          itemBuilder: (context, index) {
            if(index.isOdd){
              return Divider();
            }
            else{
              var realIdx = index ~/ 2;

              return _buildListItem(realIdx, _currentProducts, _currentDetails);
            }
          },
        ),
      ),
    );
  }

  Widget _buildListItem(int realIdx, List currentProducts, List currentDetails) {
    return ListTile(
      title: Text(currentProducts[realIdx]),
      subtitle: Text(currentDetails[realIdx]),
    );
  }

  Widget _buildMyTrashImages(myDocumentSnapshot_element) {
    List _currentFiles = myDocumentSnapshot_element['reserveFiles'];

    return Container(
      width: 300,
      height: 300,
      child: Scrollbar(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _currentFiles.length * 2,
          itemBuilder: (context, index) {
            if(index.isOdd){
              return Divider();
            } else{
              var realIdx = index ~/ 2;

              return _buildMyTrashImageItem(realIdx, _currentFiles);
            }
          },
        ),
      ),
    );
  }

  Widget _buildMyTrashImageItem(int realIdx, List currentFiles) {
    return Padding(
      padding: EdgeInsets.only(right: 5.0),
      child: CachedNetworkImage(
        placeholder: (context, url) => CircularProgressIndicator(),
        imageUrl: currentFiles[realIdx],
      ),
    );
  }
}
