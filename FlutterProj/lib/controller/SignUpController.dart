import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kopo/kopo.dart';
import 'package:random_string/random_string.dart';
import 'package:recycle/controller/AccessMyFirestore.dart';
import 'package:http/http.dart' as http;
import 'package:recycle/model/MyHTTPhost.dart';

class SignUpTC {
  static final SignUpTC _instance = SignUpTC._internal();

  factory SignUpTC() {
    return _instance;
  }

  SignUpTC._internal() {
    // Init
  }

  final _id = TextEditingController();
  final _pw = TextEditingController();
  final _name = TextEditingController();
  final _address = TextEditingController();
  final _remaining_address = TextEditingController();
  final _phoneNum = TextEditingController();
  final _email = TextEditingController();
  final _confirm = TextEditingController();
  String _authcode;

  // 0 : id,  1 : authentication code
  List<bool> _valid_condition_List = [false, false];

  // getter
  get id => _id;
  get pw => _pw;
  get name => _name;
  get address => _address;
  get remaining_address => _remaining_address;
  get phoneNum => _phoneNum;
  get email => _email;
  get confirm => _confirm;
  get authcode => _authcode;
  get valid_condition_List => _valid_condition_List;

  // setter
  set authcode(String c) => _authcode = c;
}

SignUpTC signupTC = new SignUpTC();

class SignUpController {
  // getter
  get checkmyId => _checkmyId;
  get checkmyAuthCode => _checkmyAuthCode;
  get signupC_dialogue => _signupC_dialogue;
  get checkValidInput => _checkValidInput;
  get loadMyAddress => _loadMyAddress;
  get emailSending => _emailSending;

  _emailSending(BuildContext context) async {
    signupTC.authcode = randomAlpha(6);
    print('코드값은 ? ' + signupTC.authcode);

    // POST 방식으로 서버에 이메일 전송 요청.
    var res = await http
        .post(API_PREFIX + "/create-mailer",
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              "code": signupTC.authcode,
              "email": signupTC.email.text
            }))
        .catchError((err) {
      print(err);
    });
    if (res.statusCode == 201) {
      print(res.statusCode);
      signupC_dialogue(context, "EMAIL_SUCCESS");
    } else {
      print("Connection Failed...");
    }
  }

  // 도로명 주소 불러오는 Kopo 라이브러리 사용.
  Future<void> _loadMyAddress(BuildContext context) async {
    KopoModel model = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Kopo(),
        ));
    print(model?.toJson());
    if (model?.toJson()?.isNotEmpty) {
      signupTC.address.text =
          '${model.address} ${model.buildingName}${model.apartment == 'Y' ? '아파트' : ''} ${model.zonecode} ';
      print('My Address is' + signupTC.address.text);
    }

    return;
  }

  // 유효한 입력인지 검사하는 메소드
  int _checkValidInput() {
    if (signupTC.valid_condition_List[0] && signupTC.valid_condition_List[1]) {
      return 0;
    } else if (signupTC.valid_condition_List[0] &&
        !signupTC.valid_condition_List[1]) {
      return 1;
    } else if (!signupTC.valid_condition_List[0] &&
        signupTC.valid_condition_List[1]) {
      return 2;
    } else if (!signupTC.valid_condition_List[0] &&
        !signupTC.valid_condition_List[1]) {
      return 3;
    }
  }

  // 중복확인 시, 중복되는 아이디가 있는지 체크함.
  Future<void> _checkmyId(BuildContext context) async {
    if (signupTC.id.text.length == 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text('아이디를 입력하세요.'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Confirm')),
            ],
          );
        },
      );
    } else {
      final QuerySnapshot result = await myFirestore.db
          .collection('user')
          .where('id', isEqualTo: signupTC.id.text)
          .limit(1)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 1) {
        // 중복되는 아이디가 존재함.
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('중복 오류'),
              content: Text('이미 존재하는 아이디 입니다.'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Confirm')),
              ],
            );
          },
        );
      } else {
        signupTC.valid_condition_List[0] = true;
        // 중복되는 아이디가 존재하지 않음.
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: null,
              content: Text('사용 가능한 아이디 입니다.'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      // 아이디 유효함 ON.
                      signupTC.valid_condition_List[0] = true;

                      Navigator.of(context).pop();
                    },
                    child: Text('Confirm')),
              ],
            );
          },
        );
      }
    }

    return;
  }

  // 인증코드가 맞는지 체크하는 메소드.
  Future<bool> _checkmyAuthCode() async {
    return (signupTC.confirm.text == signupTC.authcode) ? true : false;
  }

  Future<Widget> _signupC_dialogue(BuildContext context, String status) async {
    String tmp_title, tmp_content;

    if (status == 'AUTH_SUCCESS') {
      tmp_title = "SUCCESS";
      tmp_content = "인증이 완료되었습니다!";
    } else if (status == 'ERROR') {
      // ERROR
      tmp_title = "ERROR";
      tmp_content = "인증코드가 유효하지 않습니다.";
    } else if (status == 'REG_NO_0') {
      // 회원 가입 성공
      tmp_title = "SUCCESS";
      tmp_content = "회원가입이 완료되었습니다.";
    } else if (status == 'REG_NO_1') {
      // 인증코드만 불 일치하는 경우...
      tmp_title = "ERROR";
      tmp_content = "인증코드를 다시 확인해주세요.";
    } else if (status == 'REG_NO_2') {
      // 아이디 검사가 이루어지지 않은 경우...
      tmp_title = "ERROR";
      tmp_content = "아이디 중복을 체크 해주세요.";
    } else if (status == 'REG_NO_3') {
      // 전부 이루어지지 않은 경우...
      tmp_title = "ERROR";
      tmp_content = "아이디와 인증코드를 \n다시 확인해주세요.";
    } else if (status == 'EMAIL_SUCCESS') {
      tmp_title = "SUCCESS";
      tmp_content = "이메일을 정상적으로 전송했습니다.";
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tmp_title),
          content: Text(tmp_content),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Confirm')),
          ],
        );
      },
    );
  }
}

SignUpController signupC = new SignUpController();
