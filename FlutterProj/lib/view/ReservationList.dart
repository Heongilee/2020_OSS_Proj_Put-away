import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recycle/controller/AccessMyFirestore.dart';
import 'package:recycle/view/Consts.dart';
import 'package:recycle/view/SelectedReservationInfo.dart';

class ReservationList extends StatefulWidget {
  final DocumentSnapshot _currentAccount;
  // 로그인 
  ReservationList(this._currentAccount);

  @override
  _ReservationListState createState() => _ReservationListState();
}

class _ReservationListState extends State<ReservationList> {
  // DataTable
  List<DataColumn> dataColumn;
  List<DataRow> dataRow;

  @override
  void initState() {
    super.initState();
    dataColumn = new List<DataColumn>();
    dataRow = new List<DataRow>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          '예약 조회',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.white,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: myFirestore.db
                .collection('reservation')
                .where("reserveId",
                    isEqualTo: widget._currentAccount.data['id'])
                .getDocuments()
                .asStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return _myCircularProgressIndicator();
              } else {
                final message = snapshot.data.documents;

                return _buildMyBody(message);
              }
            }),
      ),
    );
  }

  Widget _getDataTable(List<DocumentSnapshot> myQ) {
    dataColumn.clear();
    dataRow.clear();

    return DataTable(
      // TODO : https://stackoverflow.com/questions/51434778/flutter-using-datatable-sorting-built-in-function
      // TODO : 스택 오버플로우 사이트 참고해서 Sorting 익히기.
      sortColumnIndex: 0,
      sortAscending: true,
      horizontalMargin: Consts.reservationlist_DataTable_horizontalMargin,
      columnSpacing: Consts.reservationlist_DataTable_columnSpacing,
      columns: _getDataColumns(),
      rows: _getDataRows(myQ),
      showCheckboxColumn: false,
    );
  }

  List<DataColumn> _getDataColumns() {
    dataColumn.add(DataColumn(
        label: Text(
      '방문날짜',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontSize: Consts.reservationlist_dataColumn_fontSize),
      textAlign: TextAlign.center,
    )));
    dataColumn.add(DataColumn(
        label: Text(
      '방문시간',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontSize: Consts.reservationlist_dataColumn_fontSize),
      textAlign: TextAlign.center,
    )));
    dataColumn.add(DataColumn(
        label: Text(
      '상태',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontSize: Consts.reservationlist_dataColumn_fontSize),
      textAlign: TextAlign.center,
    )));

    return dataColumn;
  }

  List<DataRow> _getDataRows(List<DocumentSnapshot> myQ) {
    List<DataCell> myreturnList;

    for (DocumentSnapshot element in myQ) {
      // 인스턴스 생성은 for문에서 해줘야 DataRows 오류가 발생하지 않는다.
      myreturnList = new List<DataCell>();

      myreturnList.add(DataCell(Text('${element['reserveVisitDate']}')));
      myreturnList.add(DataCell(Text('${element['reserveVisitTime']}')));
      myreturnList.add(DataCell(Text('${element['reserveState']}')));
      // print(element['reserveVisitDate']);
      // print(element['reserveVisitTime']);
      // print(element['reserveState']);
      dataRow.add(DataRow(
        cells: myreturnList,
        onSelectChanged: (bool onValue) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SelectedReservationInfo(element)));
        },
      ));
    }

    return dataRow;
  }

  Widget _buildMyBody(List<DocumentSnapshot> myQ) {
    return Container(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: _getDataTable(myQ),
          ),
        ),
      ),
    );
  }

  Widget _myCircularProgressIndicator() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: CircularProgressIndicator(),
    );
  }
}
