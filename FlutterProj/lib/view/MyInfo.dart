import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recycle/controller/AccessMyFirestore.dart';
import 'package:recycle/controller/MyInfoController.dart';
import 'package:recycle/view/ChangeMyInfo.dart';
import 'package:recycle/view/Consts.dart';
import 'package:recycle/view/NoticePage.dart';

class UserInfo {
  static final UserInfo _instance = UserInfo._internal();
  String _currentMyID;

  factory UserInfo() {
    return _instance;
  }

  UserInfo._internal();
}

class MyInfo extends StatelessWidget {
  // 로그인
  final DocumentSnapshot _currentAccount;

  MyInfo(this._currentAccount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true, // 제목 가운데로 오게 하기.
      automaticallyImplyLeading: false, // 자동으로 뒤로가기 버튼 만드는거 false...
      backgroundColor: Colors.white,
      title: Text(
        '내정보',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontStyle: FontStyle.italic),
      ),
      actions: <Widget>[
        IconButton(
            color: Colors.black,
            icon: Icon(Icons.exit_to_app),
            // 로그아웃 버튼
            onPressed: () {
              myinfoC.updateStatus(
                  0, _currentAccount); // 로그인 -> 로그아웃으로 상태 전환 후,
              Navigator.pop(context); // 로그인 화면으로 이동!
            }),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<DocumentSnapshot>(
                  stream: myFirestore.db
                      .collection('user')
                      .document(_currentAccount.documentID)
                      .snapshots(),
                  builder: (context, snapshot) {
                    // 스냅샷 데이터 검사는 함수 진입하고 맨 첫 줄에 해야함. 안 그러면 에러 남.
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    final DocumentSnapshot document = snapshot.data;
                    return Text(
                      document['id'] + ' 님 안녕하세요?' ?? '<No message retrived>',
                      textScaleFactor: 2.0,
                    );
                  }),
              Padding(padding: EdgeInsets.all(4.0)),
              StreamBuilder<DocumentSnapshot>(
                  stream: myFirestore.db
                      .collection('user')
                      .document(_currentAccount.documentID)
                      .snapshots(),
                  builder: (context, snapshot) {
                    // 스냅샷 데이터 검사는 함수 진입하고 맨 첫 줄에 해야함. 안 그러면 에러 남.
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    final DocumentSnapshot document = snapshot.data;
                    return Text(
                      document['email'] ?? '<No message retrived>',
                      textScaleFactor: 1.0,
                    );
                  }),
              Padding(
                padding: EdgeInsets.all(24.0),
              ),
              SizedBox(
                height: 35.0,
                child: FloatingActionButton.extended(
                  heroTag: 'Userhelp_key',
                  tooltip: "Hi, This is extended button.",
                  backgroundColor: Consts.myinfo_SizedBox_backgroundColor,
                  foregroundColor: Consts.myinfo_SizedBox_foregroundColor,
                  icon: Icon(Icons.description),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChangeMyInfo(_currentAccount)));
                  },
                  label: Container(
                    width: Consts.myinfo_Container_width,
                    child: Text(
                      '내 정보 변경',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
              ),
              SizedBox(
                height: 35.0,
                child: FloatingActionButton.extended(
                  heroTag: 'noticePage_key',
                  tooltip: "Hi, This is extended button.", //길게 누르면 설명 버튼이 뜸.
                  backgroundColor: Consts.myinfo_SizedBox_backgroundColor,
                  foregroundColor: Consts.myinfo_SizedBox_foregroundColor,
                  icon: Icon(Icons.assignment),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NoticePage()));
                  },
                  label: Container(
                      width: Consts.myinfo_Container_width,
                      child: Text(
                        '공 지 사 항',
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              SizedBox(
                height: 35.0,
                child: FloatingActionButton.extended(
                  heroTag: 'complain_key',
                  tooltip: "Hi, This is extended button.",
                  backgroundColor: Consts.myinfo_SizedBox_backgroundColor,
                  foregroundColor: Consts.myinfo_SizedBox_foregroundColor,
                  icon: Icon(Icons.question_answer),
                  onPressed: () {
                    myinfoC.emailSending("putitaway2020@gmail.com");
                  },
                  label: Container(
                      width: Consts.myinfo_Container_width,
                      child: Text(
                        '1 : 1  문 의',
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              SizedBox(
                height: 35.0,
                child: FloatingActionButton.extended(
                  heroTag: 'help_key',
                  tooltip: "Hi, This is extended button.",
                  backgroundColor: Consts.myinfo_SizedBox_backgroundColor,
                  foregroundColor: Consts.myinfo_SizedBox_foregroundColor,
                  icon: Icon(Icons.help_outline),
                  onPressed: () {
                    myinfoC.myinfo_dialogue(context);
                  },
                  label: Container(
                      width: Consts.myinfo_Container_width,
                      child: Text(
                        '도 움 말',
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
              Padding(padding: EdgeInsets.only()),
            ],
          ),
        ),
      ),
    );
  }
}
