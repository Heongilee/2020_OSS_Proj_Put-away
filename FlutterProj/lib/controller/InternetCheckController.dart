import 'dart:io';

import 'package:flutter/material.dart';

class InternetCheckController {
  //getter
  get checkInternetAccess => _checkInternetAccess;
  get errorMsg => _errorMsg;

  Future<bool> _checkInternetAccess(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Connected');
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<Widget> _errorMsg(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('인터넷 연결 오류'),
          content: Text('인터넷 연결 상태를 확인 바랍니다.'),
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

final myInternetCheck = new InternetCheckController();
