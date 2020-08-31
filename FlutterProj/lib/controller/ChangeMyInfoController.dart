import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recycle/controller/AccessMyFirestore.dart';

class ChangeMyInfoTC {
  // 싱글톤
  static final ChangeMyInfoTC _instance = ChangeMyInfoTC._internal();

  factory ChangeMyInfoTC() {
    return _instance;
  }

  ChangeMyInfoTC._internal() {
    // 초기화
  }

  // getter
  get id => _id;
  get pw => _pw;
  get name => _name;
  get address => _address;
  get phoneNum => _phoneNum;
  get email => _email;
  // get confirm => _confirm;

  final _id = TextEditingController();
  final _pw = TextEditingController();
  final _name = TextEditingController();
  final _address = TextEditingController();
  final _phoneNum = TextEditingController();
  final _email = TextEditingController();
  // final _confirm = TextEditingController();
}

ChangeMyInfoTC changemyinfoTC = new ChangeMyInfoTC();

class ChangeMyInfoController {
  // getter
  get modifyMyAccount => _modifyMyAccount;

  Future<void> _modifyMyAccount(
      Map<String, dynamic> userInfo, DocumentSnapshot currentAccount) async {
    var doc =
        myFirestore.db.collection('user').document(currentAccount.documentID).updateData({
      "address": userInfo['address'],
      "email": userInfo['email'],
      "id": userInfo['id'],
      "name": userInfo['name'],
      "phoneNum": userInfo['phoneNum'],
      "pw": userInfo['pw'],
    });

    // TODO : modify....
    return;
  }
}

ChangeMyInfoController changemyinfoC = new ChangeMyInfoController();
