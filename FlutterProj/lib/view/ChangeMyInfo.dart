import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recycle/controller/AccessMyFirestore.dart';
import 'package:recycle/controller/ChangeMyInfoController.dart';
import 'package:recycle/controller/FluttertoastPlugin.dart';
import 'package:recycle/controller/InternetCheckController.dart';
import 'package:recycle/controller/SignUpController.dart';
import 'package:recycle/view/Consts.dart';

class ChangeMyInfo extends StatelessWidget {
  final DocumentSnapshot _currentAccount;

  // 로그인 계정 정보를 받아옴.
  ChangeMyInfo(this._currentAccount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Text(
        '내 정보 변경',
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

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Center(
          child: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          height: 700.0,
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(20.0)),
              Flexible(
                // ID
                child: Container(
                  alignment: Alignment(0.0, 0.0),
                  height: Consts.changemyinfo_Container_height,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1, color: Colors.black12),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: Consts.changemyinfo_Container_width,
                        child: Text(
                          "ID",
                          style: TextStyle(fontSize: Consts.changemyinfo_TextStyle_fontSize, color: Colors.black),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: StreamBuilder<DocumentSnapshot>(
                              stream: myFirestore.db
                                  .collection('user')
                                  .document(_currentAccount.documentID)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  final DocumentSnapshot document =
                                      snapshot.data;
                                  changemyinfoTC.id.text = document['id'];
                                  return TextField(
                                    controller: changemyinfoTC.id,
                                    style: TextStyle(color: Colors.black),
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[300]),
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
              Padding(padding: EdgeInsets.all(Consts.changemyinfo_Padding_size)),
              Flexible(
                // Password
                child: Container(
                  alignment: Alignment(0.0, 0.0),
                  height: Consts.changemyinfo_Container_height,
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
                        width: Consts.changemyinfo_Container_width,
                        child: Text(
                          "PW",
                          style: TextStyle(fontSize: Consts.changemyinfo_TextStyle_fontSize, color: Colors.black),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: StreamBuilder<DocumentSnapshot>(
                              stream: myFirestore.db
                                  .collection('user')
                                  .document(_currentAccount.documentID)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  final DocumentSnapshot document =
                                      snapshot.data;
                                  changemyinfoTC.pw.text = document['pw'];
                                  return TextField(
                                    obscureText: true, //비밀번호 텍스트 필드
                                    controller: changemyinfoTC.pw,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[300]),
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
              Padding(padding: EdgeInsets.all(Consts.changemyinfo_Padding_size)),
              Flexible(
                // name
                child: Container(
                  alignment: Alignment(0.0, 0.0),
                  height: Consts.changemyinfo_Container_height,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1, color: Colors.black12),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: Consts.changemyinfo_Container_width,
                        child: Text(
                          "이름",
                          style: TextStyle(fontSize: Consts.changemyinfo_TextStyle_fontSize, color: Colors.black),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: StreamBuilder<DocumentSnapshot>(
                              stream: myFirestore.db
                                  .collection('user')
                                  .document(_currentAccount.documentID)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  final DocumentSnapshot document =
                                      snapshot.data;
                                  changemyinfoTC.name.text = document['name'];
                                  return TextField(
                                    controller: changemyinfoTC.name,
                                    style: TextStyle(color: Colors.black),
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[300]),
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
              Padding(padding: EdgeInsets.all(Consts.changemyinfo_Padding_size)),
              Flexible(
                // address
                child: Container(
                  alignment: Alignment(0.0, 0.0),
                  height: Consts.changemyinfo_Container_height,
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
                        width: Consts.changemyinfo_Container_width,
                        child: Text(
                          "주소",
                          style: TextStyle(fontSize: Consts.changemyinfo_TextStyle_fontSize, color: Colors.black),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: StreamBuilder<DocumentSnapshot>(
                              stream: myFirestore.db
                                  .collection('user')
                                  .document(_currentAccount.documentID)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  final DocumentSnapshot document =
                                      snapshot.data;
                                  changemyinfoTC.address.text =
                                      document['address'];
                                  return TextField(
                                    readOnly: true,
                                    controller: changemyinfoTC.address,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: null,
                                      border: InputBorder.none,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[300]),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                      child: Container(
                        child: Text(
                          '직접 입력',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      onPressed: () async {
                        myInternetCheck
                            .checkInternetAccess(context)
                            .then((bool onValue) {
                          if (onValue) {
                            signupC.loadMyAddress(context);
                          } else {
                            myInternetCheck.errorMsg(context);
                          }
                        });
                      }),
                  Padding(padding: EdgeInsets.only(left: 35.0)),
                ],
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              Flexible(
                // phone
                child: Container(
                  alignment: Alignment(0.0, 0.0),
                  height: Consts.changemyinfo_Container_height,
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
                        width: Consts.changemyinfo_Container_width,
                        child: Text(
                          "전화번호",
                          style: TextStyle(fontSize: Consts.changemyinfo_TextStyle_fontSize, color: Colors.black),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: StreamBuilder<DocumentSnapshot>(
                              stream: myFirestore.db
                                  .collection('user')
                                  .document(_currentAccount.documentID)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  final DocumentSnapshot document =
                                      snapshot.data;
                                  changemyinfoTC.phoneNum.text =
                                      document['phoneNum'];
                                  return TextField(
                                    controller: changemyinfoTC.phoneNum,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[300]),
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
              Padding(padding: EdgeInsets.all(Consts.changemyinfo_Padding_size)),
              Flexible(
                // Email
                child: Container(
                  alignment: Alignment(0.0, 0.0),
                  height: Consts.changemyinfo_Container_height,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1, color: Colors.black12),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: Consts.changemyinfo_Container_width,
                        child: Text(
                          "이메일",
                          style: TextStyle(fontSize: Consts.changemyinfo_TextStyle_fontSize, color: Colors.black),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: StreamBuilder<DocumentSnapshot>(
                              stream: myFirestore.db
                                  .collection('user')
                                  .document(_currentAccount.documentID)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  final DocumentSnapshot document =
                                      snapshot.data;
                                  changemyinfoTC.email.text = document['email'];
                                  return TextField(
                                    controller: changemyinfoTC.email,
                                    style: TextStyle(color: Colors.black),
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[300]),
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
              Padding(padding: EdgeInsets.all(50.0)),
              SizedBox(
                width: 300,
                child: RaisedButton(
                    child: Text(
                      '변 경',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      //인터넷 연결 상태 확인 후,
                      myInternetCheck.checkInternetAccess(context).then((bool onValue) {
                        if (onValue) {
                          // 변경된 내 정보 수정이 수행됨.
                          changemyinfoC.modifyMyAccount({
                            "address": changemyinfoTC.address.text,
                            "email": changemyinfoTC.email.text,
                            "id": changemyinfoTC.id.text,
                            "name": changemyinfoTC.name.text,
                            "phoneNum": changemyinfoTC.phoneNum.text,
                            "pw": changemyinfoTC.pw.text
                          }, _currentAccount).then((value) {
                            //수행 후 이전 페이지로 돌아가면서,
                            Navigator.of(context).pop();

                            // 알림 메시지 디스플레이.
                            myFlutterToast
                                .showMyToastAlertMsg("내 정보 변경이 완료되었습니다.");
                          });
                        } else {
                          myInternetCheck.errorMsg(context);
                        }
                      });
                    }),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
