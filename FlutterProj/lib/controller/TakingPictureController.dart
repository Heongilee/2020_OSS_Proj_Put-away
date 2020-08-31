import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recycle/model/MyHTTPhost.dart';

class TakingPictureController {
  //getter
  get loadMyDeepLearningModule => _loadMyDeepLearningModule;
  get takingpicture_dialogue => _takingpicture_dialogue;

  Future<Widget> _takingpicture_dialogue(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ERROR'),
          content: Text('리스트에 사진이 하나도 없습니다. 사진을 촬영해주세요.'),
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

  // 딥러닝 결과를 받아올 메소드
  Future<Map<int, List<String>>> _loadMyDeepLearningModule(
      BuildContext context, List<File> listViewItem) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '딥러닝 분석 결과가 나올 때 까지\n 잠시만 기다려 주세요...',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          content: CircularProgressIndicator(), // TODO : SizedBox로 감싸면 줄어듦.
        );
      },
    );

    //* 테스트 용도 *
    Map<int, List<String>> _myDeepLearningResults = {
      // 0: ["시계"], // 0번째 사진에서 검출된 객체들은 어항, 이불, 화분, 자전거, 항아리가 있다.
      // 1: ["가방류", "고무통", "러닝머신", "옥매트"], // 1번째 사진에서 검출된 객체들은 다음과 같다.
      // 2: ["유리(거울,판유리)", "재봉틀", "화일캐비넷", "피아노", "환풍기", "카페트"],
      // 3: ["어항", "이불", "화분", "자전거", "항아리"], // 0번째 사진에서 검출된 객체들은 어항, 이불, 화분, 자전거, 항아리가 있다.
      // 4: ["가방류", "고무통", "러닝머신", "옥매트"], // 1번째 사진에서 검출된 객체들은 다음과 같다.
      // 5: ["유리(거울,판유리)", "재봉틀", "화일캐비넷", "피아노", "환풍기", "카페트"]
    };

    // !-------------------- AWS EC2 서버 가동중일때만 가능. ---------------------
    int tmp_idx;
    String tmp; // res.body를 받아올 임시 변수
    for (File element in listViewItem) {
      if (element == null) {
        print("어 파일인식 안됨");
        break;
      }
      String base64Image = base64Encode(element.readAsBytesSync());
      String fileName = element.path.split("/").last;

      print("파일이름 : " + fileName);

      await http.post(API_PREFIX + "/image", body: {
        "image": base64Image,
        "name": fileName,
      }).then((res) {
        print(res.body);
        print("상태코드 : ");
        print(res.statusCode);
        tmp = res.body;

        List<String> response_list = tmp.split(",");
        _myDeepLearningResults
            .addAll({_myDeepLearningResults.length: response_list});
      }).catchError((err) {
        print(err);
      });
    }
    // !------------------------------------------------------------------------

    return _myDeepLearningResults;
  }
}

TakingPictureController takingpictureC = new TakingPictureController();
