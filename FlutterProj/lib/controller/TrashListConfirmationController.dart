import 'package:flutter/material.dart';
import 'package:recycle/model/AccountSnapshot.dart';
import 'package:recycle/model/WasteListAsset.dart';

class TrashListConfirmationController {
  // getter
  List<DropdownMenuItem<String>> get dropDownMenuItems_Product =>
      _dropDownMenuItems_Product;
  List<DropdownMenuItem<String>> get dropDownMenuItems_Detail =>
      _dropDownMenuItems_Detail;
  List<String> get currentResult => _currentResult;
  List<String> get detailProduct => _detailProduct;
  String get currentProduct => _currentProduct;
  Set<Map<String, String>> get selectedListItem => _selectedListItem;
  String get currentDetail => _currentDetail;

  get active_comboboxList => _active_comboboxList;
  get getDropDownMenuItems_Product => _getDropDownMenuItems_Product;
  get getDropDownMenuItems_Detail => _getDropDownMenuItems_Detail;
  get addMyTrashListItem => _addMyTrashListItem;

  // setter
  set dropDownMenuItems_Detail(List<DropdownMenuItem<String>> obj) =>
      _dropDownMenuItems_Detail = obj;
  set currentDetail(String val) => _currentDetail = val;
  set currentProduct(String val) => _currentProduct = val;
  set selectedListItem(Set<Map<String, String>> s) => _selectedListItem = s;
  set dropDownMenuItems_Product(List<DropdownMenuItem<String>> d) =>
      _dropDownMenuItems_Product = d;

  // 사용자가 선택한 _myTrashListSet -> _selectedListItem
  Set<Map<String, String>> _selectedListItem = {};

  // 이전 페이지 인자를 불러오고나서 초기화 하기위한 변수.
  bool subInitState_flag;

  // 강남구청 폐기물 분류 클래스
  WasteListAsset waste_obj;

  // * 딥러닝 분석 결과를 리스트형태로 가져올 것임.
  List<String> _currentResult = ["제품 목록을 선택하세요."]; // 제품 목록
  List<String> _detailProduct = ["상세 목록을 선택하세요."]; // 상세 목록

  // DropdownMenu에 들어갈 아이템들이 DropdownMenuItem<String>타입으로 담긴 리스트.
  List<DropdownMenuItem<String>> _dropDownMenuItems_Product;
  List<DropdownMenuItem<String>> _dropDownMenuItems_Detail;

  // 현재 DropdownMenuItem이 선택된 값.
  String _currentProduct;
  String _currentDetail;
  bool toggleValue = false;

  // 제품 목록, 상세 목록 아이템 리스트에 넣기 위한 메소드
  void _addMyTrashListItem() {
    if (trashlistconfirmationC.currentProduct == "noDetected" ||
        trashlistconfirmationC.currentDetail == "noDetected") {
      // nothing...
    } else {
      trashlistconfirmationC.selectedListItem.add({
        trashlistconfirmationC.currentProduct:
            trashlistconfirmationC.currentDetail
      });
    }

    return;
  }

  // 콤보박스 활성화
  void _active_comboboxList(TrashListConfirmation_AccounSnapshot args) {
    // subInitState : route를 통해 arguments 들이 들어오고 나서 콤보박스 리스트를 활성화 시킬 것임.
    if (trashlistconfirmationC.subInitState_flag == false) {
      trashlistconfirmationC.subInitState_flag = true;

      trashlistconfirmationC.selectedListItem = args.selectedListItem;

      // 현재 인덱스의 딥러닝 분석 결과를(List<String>) 가져오고,
      trashlistconfirmationC.currentResult
          .addAll(args.myDeepLearningResultStr[args.current_Idx]);
      // 제품 목록 콤보박스에 추가시킨다.
      trashlistconfirmationC.dropDownMenuItems_Product =
          getDropDownMenuItems_Product(trashlistconfirmationC.currentResult);
      // 현재 제품목록 인덱스를 0번으로 셋팅한다.
      trashlistconfirmationC.currentProduct =
          trashlistconfirmationC.dropDownMenuItems_Product[0].value;
    }
  }

  //제품 목록
  List<DropdownMenuItem<String>> _getDropDownMenuItems_Product(
      List<String> myDeepLearningResults) {
    //DropdownMenu에 추가시킬 items 리스트 선언. (이를 반환 시킬 것임.)
    List<DropdownMenuItem<String>> items = new List();
    //같은 객체 중복 방지 리스트
    List<String> incheck = new List();

    for (String i in myDeepLearningResults) {
      // TODO : 만약 "noDetected" 결과라면...?
      if (i == "noDetected") {
        items.add(new DropdownMenuItem(value: i, child: Text(i)));
        break;
      }
      // 딥러닝 결과와 매칭된 폐기물 품목 리스트만 items에 add 시킬 것.
      else if (WasteListAsset().trashList.containsKey(i) &&
          !incheck.contains(i)) {
        incheck.add(i);
        items.add(new DropdownMenuItem(
            value: i, child: Text(WasteListAsset().trashList[i].koreaname)));
      }
      // end user가 제품 목록을 선택하기 전에 띄울 콤보박스 아이템
      else if (i == "제품 목록을 선택하세요." && !incheck.contains(i)) {
        incheck.add(i);
        items.add(new DropdownMenuItem(value: i, child: Text(i)));
      }
    }

    return items;
  }

  //상세목록
  List<DropdownMenuItem<String>> _getDropDownMenuItems_Detail(
      String selectedItem) {
    List<DropdownMenuItem<String>> items = [
      new DropdownMenuItem(
          value: "상세 목록을 선택하세요.", child: new Text("상세 목록을 선택하세요."))
    ];

    if (trashlistconfirmationC.currentProduct == "noDetected") {
      items.add(new DropdownMenuItem(
          value: "noDetected", child: new Text("noDetected")));
    } else {
      // selectedItem(제품 목록)의 상세 목록(detailWaste)을 for문으로 순회하면서...
      for (String i in WasteListAsset().trashList[selectedItem].detailWaste) {
        // DropdownMenuItem에 추가시킨다.
        items.add(new DropdownMenuItem(value: i, child: new Text(i)));
      }
    }
    return items;
  }
}

TrashListConfirmationController trashlistconfirmationC =
    new TrashListConfirmationController();
