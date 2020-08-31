import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recycle/controller/AccessMyFirestore.dart';
import 'package:recycle/view/Consts.dart';
import 'package:url_launcher/url_launcher.dart';

class MyInfoController {
  // getter
  get updateStatus => _updateStatus;
  get myinfo_dialogue => _myinfo_dialogue;
  get emailSending => _emailSending;

  Future<void> _emailSending(String s) async {
    String _title = "";
    String _content = "";

    var url = "mailto:$s?subject=$_title&body=$_content";

    if (await canLaunch(url))
      await launch(url);
    else
      throw 'Could not launch $url';

    return;
  }

  Future<Widget> _myinfo_dialogue(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: dialogContent(context),
        );
      },
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.myinfo_dialogContent_avatarRadius +
                Consts.myinfo_dialogContent_padding,
            bottom: Consts.myinfo_dialogContent_padding,
            left: Consts.myinfo_dialogContent_padding,
            right: Consts.myinfo_dialogContent_padding,
          ),
          margin:
              EdgeInsets.only(top: Consts.myinfo_dialogContent_avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius:
                BorderRadius.circular(Consts.myinfo_dialogContent_padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                "2020 공개SW 개발자대회",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '치 워 줘',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '앱 버전: V1.0',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.0,
                ),
              ),
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.center,
                child: FlatButton(
                  color: Colors.grey[200],
                  onPressed: () {
                    Navigator.of(context).pop(); // To close the dialog
                  },
                  child: Text("닫 기"),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Consts.myinfo_dialogContent_padding,
          right: Consts.myinfo_dialogContent_padding,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: Consts.myinfo_dialogContent_avatarRadius,
            child: Image(image: AssetImage('assets/images/Logo.png')),
          ),
        ),
      ],
    );
  }

  void _updateStatus(int v, DocumentSnapshot currentAccount) async {
    // status 0이 들어오면 로그인 -> 로그아웃
    // status 1이 들어오면 로그아웃 -> 로그인
    if (v == 0) {
      await myFirestore.db
          .collection('user')
          .document(currentAccount.documentID)
          .updateData({'status': 0});
      print('status를 정상적으로 0으로 변경했습니다.');
    } else {
      await myFirestore.db
          .collection('user')
          .document(currentAccount.documentID)
          .updateData({'status': 1});
      print('status를 정상적으로 1으로 변경했습니다.');
    }

    return;
  }
}

MyInfoController myinfoC = new MyInfoController();
