import 'package:egattracking/dao/ProfileDao.dart';
import 'package:egattracking/fragment/map_fragment.dart';
import 'package:egattracking/fragment/report_fragment.dart';
import 'package:egattracking/fragment/login_page.dart';
import 'package:egattracking/fragment/history_fragment.dart';
import 'package:egattracking/service/UserService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  bool refresh = false;
  late Future<ProfileDao> profile;

  _refreshAction(bool refresh) {
    setState(() {
      refresh = refresh;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: isLogin(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData || refresh) {
            bool data = snapshot.data;
            return data
                ? ReportFragment(
                    logoutTriggeredAction: _refreshAction,
                  )
                : LoginPage(loginTriggeredAction: _refreshAction);
          }
          return LoginPage(loginTriggeredAction: _refreshAction);
        });
  }

  Future<bool?> isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(LoginPage.keylogin) == null
        ? false
        : prefs.getBool(LoginPage.keylogin);
  }
}
