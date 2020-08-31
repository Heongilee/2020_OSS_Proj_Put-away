import 'package:flutter/material.dart';
import 'package:recycle/model/AccountSnapshot.dart';
import 'package:recycle/view/HomePage.dart';
import 'package:recycle/view/MyInfo.dart';
import 'package:recycle/view/ReservationList.dart';

class TabPage extends StatefulWidget {
  static const routeName = '/TabPage';

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIdx = 0;
  List _pages;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TabPage_AccountSnapshot args =
        ModalRoute.of(context).settings.arguments;

    _pages = [
      HomePage(args.currentAccount),
      ReservationList(args.currentAccount),
      MyInfo(args.currentAccount)
    ];
    return Scaffold(
      // appBar: AppBar(),
      body: WillPopScope(
        onWillPop: () {
          print('눌렸습니다.');
        },
        child: Center(
          child: _pages[_selectedIdx],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        onTap: _onItemTapped,
        currentIndex: _selectedIdx,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('홈')),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text('예약조회')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text('내정보')),
        ],
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIdx = value;
    });
  }
}
