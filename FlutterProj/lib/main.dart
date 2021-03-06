import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recycle/view/MainPage.dart';
import 'package:recycle/view/RootPage.dart';
import 'package:recycle/view/TabPage.dart';
import 'package:recycle/view/TrashListConfirmation.dart';
import 'package:recycle/view/TakingPicture.dart';
import 'package:recycle/view/CustomerForm.dart';

// 2020-06-11(21:01) Master
// adb.exe 경로 -> C:\Users\gjsrl\AppData\Local\Android\Sdk\platform-tools
// 이 경로에서 adb *  커맨드 먹힘.
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '치워',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: RootPage(),
      routes: <String, WidgetBuilder>{
        '/MainPage': (BuildContext context) => new MainPage(),
        TakingPicture.routeName: (context) => TakingPicture(),
        TrashListConfirmation.routeName: (context) => TrashListConfirmation(),
        CustomerForm.routeName: (context) => CustomerForm(),
        TabPage.routeName: (context) => TabPage(),
      },
      onGenerateRoute: (settings) {
        // * 페이지 전환 효과를 주고 싶으면 이 영역에 추가시키면 됩니다.
        switch (settings.name) {
          case TabPage.routeName:
            return PageTransition(
                child: TabPage(), type: PageTransitionType.fade);
            break;
          default:
            return null;
            break;
        }
      },
    );
  }
}
