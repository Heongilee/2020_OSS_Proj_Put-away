import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recycle/controller/AccessMyFirestore.dart';
import 'package:recycle/controller/InternetCheckController.dart';
import 'package:recycle/controller/SignUpController.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'SIGN UP',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
      ),
      body: signup(context),
    );
  }

//body
  Widget signup(BuildContext context) {
    return SafeArea(
        child: Center(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Flexible(
                // ID
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
                          "ID",
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextField(
                            controller: signupTC.id,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    child: Container(
                      // width: 100,
                      // height: 30,
                      // alignment: Alignment(0.0, 0.0),
                      child: Text(
                        '중복 확인',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    onPressed: () {
                      myInternetCheck
                          .checkInternetAccess(context)
                          .then((bool onValue) {
                        if (onValue) {
                          signupC.checkmyId(context);
                        } else {
                          myInternetCheck.errorMsg(context);
                        }
                      });
                    },
                  ),
                  Padding(padding: EdgeInsets.only(left: 35.0)),
                ],
              ),
              Flexible(
                // Password
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
                          "PW",
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextField(
                            obscureText: true, //비밀번호 텍스트 필드
                            controller: signupTC.pw,
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
                // name
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
                          "이름",
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextField(
                            controller: signupTC.name,
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
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextField(
                            readOnly: true,
                            controller: signupTC.address,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: "직접 입력을 누르세요.",
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
                // etc address
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
                          "나머지 주소",
                          style: TextStyle(
                              fontSize: 11.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextField(
                            readOnly: false,
                            controller: signupTC.remaining_address,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                      child: Container(
                        // width: 100,
                        // height: 30,
                        // alignment: Alignment(0.0, 0.0),
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
              Flexible(
                // phone
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
                          "전화번호",
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextField(
                            controller: signupTC.phoneNum,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey[300]),
                              hintText: "\t\t\'-\' 빼고 입력",
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
                // Email
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
                          "이메일",
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextField(
                            controller: signupTC.email,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                      child: Container(
                        // width: 100,
                        // height: 30,
                        // alignment: Alignment(0.0, 0.0),
                        child: Text(
                          '이메일 인증',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      onPressed: () {
                        myInternetCheck
                            .checkInternetAccess(context)
                            .then((bool onValue) {
                          if (onValue) {
                            // call node emailer
                            signupC.emailSending(context);
                          } else {
                            myInternetCheck.errorMsg(context);
                          }
                        });
                      }),
                  Padding(padding: EdgeInsets.only(left: 35.0)),
                ],
              ),
              Flexible(
                // 인증코드
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
                          "인증코드",
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextField(
                            controller: signupTC.confirm,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    child: Container(
                      // width: 100,
                      // height: 30,
                      // alignment: Alignment(0.0, 0.0),
                      child: Text(
                        '인증 확인',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    onPressed: () async {
                      signupC.checkmyAuthCode().then((onValue) {
                        if (onValue) {
                          signupTC.valid_condition_List[1] = true;

                          signupC.signupC_dialogue(context, "AUTH_SUCCESS");
                        } else {
                          signupC.signupC_dialogue(context, "ERROR");
                        }
                      });
                    },
                  ),
                  Padding(padding: EdgeInsets.only(left: 35.0)),
                ],
              ),
              Padding(padding: EdgeInsets.all(20.0)),
              RaisedButton(
                child: Container(
                  width: 100,
                  // height: 30,
                  // alignment: Alignment(0.0, 0.0),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                onPressed: () {
                  var my_switch_value = signupC.checkValidInput();
                  switch (my_switch_value) {
                    // 전부 유효한 입력의 경우... (이 경우에만 회원가입을 진행한다.)
                    case 0:
                      myInternetCheck
                          .checkInternetAccess(context)
                          .then((onValue) {
                        if (onValue) {
                          var doc =
                              myFirestore.db.collection('user').document();

                          doc.setData({
                            "id": signupTC.id.text,
                            "pw": signupTC.pw.text,
                            "name": signupTC.name.text,
                            "address": signupTC.address.text +
                                " " +
                                signupTC.remaining_address.text,
                            "phoneNum": signupTC.phoneNum.text,
                            "email": signupTC.email.text,
                          }).then((value) {
                            signupC.signupC_dialogue(context, "REG_NO_0");
                          });
                        } else {
                          myInternetCheck.errorMsg(context);
                        }
                      });
                      break;
                    case 1:
                      signupC.signupC_dialogue(context, "REG_NO_1");
                      break;
                    case 2:
                      signupC.signupC_dialogue(context, "REG_NO_2");
                      break;
                    case 3:
                      signupC.signupC_dialogue(context, "REG_NO_3");
                      break;
                    default:
                      break;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
