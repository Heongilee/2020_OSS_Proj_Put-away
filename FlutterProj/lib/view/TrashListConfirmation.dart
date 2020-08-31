import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:recycle/controller/TrashListConfirmationController.dart';
import 'package:recycle/view/TakingPicture.dart';
import 'package:flutter/material.dart';
import 'package:recycle/view/CustomerForm.dart';
import 'package:recycle/model/WasteListAsset.dart';
import 'package:recycle/model/AccountSnapshot.dart';

class TrashListConfirmation extends StatefulWidget {
  static const routeName = '/TrashListComfirmation'; // 외부 모듈 수행 결과를 받아와서 출력할 것.

  @override
  _TrashListConfirmationState createState() => _TrashListConfirmationState();
}

class _TrashListConfirmationState extends State<TrashListConfirmation> {
  File _image;

  @override
  void initState() {
    trashlistconfirmationC.subInitState_flag = false;
    trashlistconfirmationC.waste_obj = new WasteListAsset();

    trashlistconfirmationC.dropDownMenuItems_Detail = new List();
    trashlistconfirmationC.dropDownMenuItems_Detail.add(new DropdownMenuItem(
        value: trashlistconfirmationC.detailProduct[0],
        child: Text(trashlistconfirmationC.detailProduct[0])));
    trashlistconfirmationC.currentDetail =
        trashlistconfirmationC.dropDownMenuItems_Detail[0].value;

    super.initState();
  }

  //제품 목록 변화
  void changedDropDownProductItem(String selectedItem) {
    setState(() {
      //제품 목록이 선택 되면 ...
      trashlistconfirmationC.currentProduct = selectedItem;

      //상세 목록 콤보박스 아이템을 동적 생성 한다.
      trashlistconfirmationC.dropDownMenuItems_Detail =
          trashlistconfirmationC.getDropDownMenuItems_Detail(selectedItem);
      trashlistconfirmationC.currentDetail =
          trashlistconfirmationC.dropDownMenuItems_Detail[0].value;
    });
  }

  //상세목록 변화
  void changedDropDownDetailItem(String selectedItem) {
    if (trashlistconfirmationC.currentProduct == "제품 목록을 선택하세요." ||
        selectedItem == "상세 목록을 선택하세요.") return;

    setState(() {
      trashlistconfirmationC.currentDetail = selectedItem;

      trashlistconfirmationC.addMyTrashListItem();
      trashlistconfirmationC.currentProduct =
          trashlistconfirmationC.dropDownMenuItems_Product[0].value;
      trashlistconfirmationC.currentDetail =
          trashlistconfirmationC.dropDownMenuItems_Detail[0].value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TrashListConfirmation_AccounSnapshot args =
        ModalRoute.of(context).settings.arguments;
    // args 를 받아 콤보박스 초기화
    trashlistconfirmationC.active_comboboxList(args);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(TakingPicture.routeName));
            }),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          '대형 폐기물 수거 신청',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
      ),
      body: _buildBody(args),
    );
  }

  Widget _buildBody(TrashListConfirmation_AccounSnapshot args) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height + 400.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(2.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('전체 리스트 조회'),
                    Padding(padding: EdgeInsets.all(2.0)),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      height: 30.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: trashlistconfirmationC.toggleValue
                              ? Colors.greenAccent[100]
                              : Colors.redAccent[100].withOpacity(0.5)),
                      child: Stack(children: <Widget>[
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          top: 3.0,
                          left: trashlistconfirmationC.toggleValue ? 25.0 : 0.0,
                          right:
                              trashlistconfirmationC.toggleValue ? 0.0 : 25.0,
                          child: InkWell(
                            onTap: () {
                              _toggleButton(args);
                            },
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 500),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return RotationTransition(
                                    child: child, turns: animation);
                              },
                              child: trashlistconfirmationC.toggleValue
                                  ? Icon(Icons.check_circle,
                                      color: Colors.green,
                                      size: 25.0,
                                      key: UniqueKey())
                                  : Icon(Icons.remove_circle_outline,
                                      color: Colors.red,
                                      size: 25.0,
                                      key: UniqueKey()),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Padding(padding: EdgeInsets.only(right: 30.0)),
                  ],
                ),
                Padding(padding: EdgeInsets.all(12.0)),
                Container(
                  width: 300.0,
                  height: 300.0,
                  child: Center(
                    child: Image.file(
                        File(args.listViewItem[args.current_Idx].path)),
                  ),
                ),
                Padding(padding: EdgeInsets.all(2.0)),
                Text(
                  '제품 목록',
                  textScaleFactor: 1.5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    border: Border.all(width: 1, style: BorderStyle.solid),
                    color: Colors.grey[200],
                  ),
                  child: DropdownButton(
                    value: trashlistconfirmationC.currentProduct,
                    items: trashlistconfirmationC.dropDownMenuItems_Product,
                    onChanged: changedDropDownProductItem,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                Text(
                  '상세 목록',
                  textScaleFactor: 1.5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    border: Border.all(width: 1, style: BorderStyle.solid),
                    color: Colors.grey[200],
                  ),
                  child: DropdownButton(
                    value: trashlistconfirmationC.currentDetail,
                    items: trashlistconfirmationC.dropDownMenuItems_Detail,
                    onChanged: changedDropDownDetailItem,
                  ),
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 30.0)),
                    Text('폐기물 신청 목록',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic)),
                  ],
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                Container(
                  width: 300.0,
                  height: 150.0,
                  color: Colors.grey[100],
                  child: _buildListView(args),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('다시찍기',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0)),
                      onPressed: () {
                        _getImage(args);
                      },
                    ),
                    Padding(padding: EdgeInsets.only(left: 40.0, right: 30.0)),
                    RaisedButton(
                        child:
                            (args.current_Idx + 1 == args.listViewItem.length)
                                ? Text(' 신청하기 ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0))
                                : Text(' 다 음 ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0)),
                        onPressed: () {
                          // TODO : 제품목록이나 상세목록을 선택하지 않았을 경우 에러메시지 출력하기.
                          if (trashlistconfirmationC.selectedListItem.length ==
                              0) {
                            // * 제품 목록을 다시 선택하세요.
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('ERROR'),
                                  content: Text('제품 목록이나 상세 목록을 선택하시기 바랍니다.'),
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
                            // * 다음 페이지로...
                            if (args.current_Idx + 1 ==
                                args.listViewItem.length) {
                              // TrashListConfirmation.dart -> CustomerForm.dart
                              args.selectedListItem.addAll(
                                  trashlistconfirmationC.selectedListItem);

                              args.selectedListItem.forEach((Map trashProduct) {
                                int temp_idx = trashlistconfirmationC
                                    .waste_obj
                                    .trashList[trashProduct.keys.first]
                                    .detailWaste
                                    .indexOf(trashProduct.values.first);
                                args.totalPrice += trashlistconfirmationC
                                    .waste_obj
                                    .trashList[trashProduct.keys.first]
                                    .wastePrice
                                    .elementAt(temp_idx);
                              });

                              Navigator.pushNamed(
                                  context, CustomerForm.routeName,
                                  arguments: CustomerForm_AccountSnapshot(
                                      args.currentAccount,
                                      args.listViewItem,
                                      args.selectedListItem,
                                      args.totalPrice));
                            } else {
                              // TrashListConfirmation.dart(현재 인덱스) -> TrashListConfirmation.dart(다음 인덱스)
                              args.selectedListItem.addAll(
                                  trashlistconfirmationC.selectedListItem);

                              Navigator.pushNamed(
                                  context, TrashListConfirmation.routeName,
                                  arguments:
                                      TrashListConfirmation_AccounSnapshot(
                                          args.currentAccount,
                                          args.listViewItem,
                                          args.current_Idx + 1,
                                          args.myDeepLearningResultStr,
                                          args.selectedListItem,
                                          args.totalPrice));
                            }
                          }
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _getImage(TrashListConfirmation_AccounSnapshot args) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          File image;
          return SimpleDialog(
            title: Text(
              '이미지를 불러올 방식을 선택하세요.',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: SimpleDialogOption(
                    child: Text('카메라 어플 실행'),
                    onPressed: () async {
                      Navigator.of(context).pop();

                      // 사진 앱 불러옴
                      image = await ImagePicker.pickImage(
                          source: ImageSource.camera);

                      setState(() {
                        // 중간에 이미지 촬영을 안 하고 바로 넘어갔을 경우... 처리
                        if (image != null)
                          args.listViewItem[args.current_Idx] = image;
                        image = null;
                      });
                    }),
              ),
              Container(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: SimpleDialogOption(
                      child: Text('갤러리에서 사진 선택'),
                      onPressed: () async {
                        Navigator.of(context).pop();

                        // 사진 앱 불러옴
                        image = await ImagePicker.pickImage(
                            source: ImageSource.gallery);

                        setState(() {
                          // 중간에 이미지 촬영을 안 하고 바로 넘어갔을 경우... 처리
                          if (image != null)
                            args.listViewItem[args.current_Idx] = image;
                          image = null;
                        });
                      })),
            ],
          );
        });
  }

  Widget _buildListView(TrashListConfirmation_AccounSnapshot args) {
    return ListView.builder(
      itemCount: trashlistconfirmationC.selectedListItem.length * 2,
      itemBuilder: (context, index) {
        if (index.isOdd) {
          return Divider();
        } else {
          var realIdx = index ~/ 2;

          return _buildListItem(args, realIdx);
        }
      },
    );
  }

  Widget _buildListItem(
      TrashListConfirmation_AccounSnapshot args, int realIdx) {
    Map listItemMap = trashlistconfirmationC.selectedListItem.toList()[realIdx];
    int temp_idx = trashlistconfirmationC
        .waste_obj.trashList[listItemMap.keys.first].detailWaste
        .indexOf(listItemMap.values.first);
    int temp_price = trashlistconfirmationC
        .waste_obj.trashList[listItemMap.keys.first].wastePrice
        .elementAt(temp_idx);

    return Card(
      child: ListTile(
        isThreeLine: true,
        title: Text(
          trashlistconfirmationC
              .waste_obj.trashList[listItemMap.keys.first].koreaname,
          textScaleFactor: 1.5,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(listItemMap.values.first + "원", textScaleFactor: 1.3),
          ],
        ),
        trailing: IconButton(
          color: Colors.pinkAccent,
          icon: Icon(Icons.remove_circle),
          onPressed: () {
            setState(() {
              trashlistconfirmationC.selectedListItem.remove(listItemMap);
            });

            // 신청 목록에서 삭제시키면 가격도 같이 차감.
            int temp_index = trashlistconfirmationC
                .waste_obj.trashList[listItemMap.keys.first].detailWaste
                .indexOf(listItemMap.values.first);
            args.totalPrice -= trashlistconfirmationC
                .waste_obj.trashList[listItemMap.keys.first].wastePrice
                .elementAt(temp_index);
          },
        ),
      ),
    );
  }

  void _toggleButton(TrashListConfirmation_AccounSnapshot args) {
    setState(() {
      trashlistconfirmationC.toggleValue = !trashlistconfirmationC.toggleValue;
      List<String> myWasteKeys = new List();
      trashlistconfirmationC.waste_obj.trashList.keys.forEach((String element) {
        myWasteKeys.add(element);
      });
      if (trashlistconfirmationC.toggleValue) {
        trashlistconfirmationC.currentResult.clear();
        trashlistconfirmationC.currentResult.add("제품 목록을 선택하세요.");
        trashlistconfirmationC.currentResult.addAll(myWasteKeys);

        trashlistconfirmationC.dropDownMenuItems_Product =
            trashlistconfirmationC.getDropDownMenuItems_Product(trashlistconfirmationC.currentResult);
        trashlistconfirmationC.currentProduct =
            trashlistconfirmationC.dropDownMenuItems_Product[0].value;
      } else {
        trashlistconfirmationC.currentResult.clear();
        trashlistconfirmationC.currentResult.add("제품 목록을 선택하세요.");
        trashlistconfirmationC.currentResult
            .addAll(args.myDeepLearningResultStr[args.current_Idx]);

        trashlistconfirmationC.dropDownMenuItems_Product =
            trashlistconfirmationC.getDropDownMenuItems_Product(trashlistconfirmationC.currentResult);
        trashlistconfirmationC.currentProduct =
            trashlistconfirmationC.dropDownMenuItems_Product[0].value;
      }
    });
  }
}
