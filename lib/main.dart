import 'package:egattracking/Single.dart';
import 'package:egattracking/dao/TowerDao.dart';
import 'package:egattracking/service/Interceptor/EgatInterceptor.dart';
import 'package:flutter/material.dart';
import 'package:egattracking/home_page.dart';
import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


void main() {
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  
  final appTitle = 'Drawer Demo';
  static Dio dio = Dio();
  static late Data tower;
  static SingleFactory mfactory = SingleFactory();

  

  @override
  Widget build(BuildContext context){
    Alice alice = new Alice(showNotification: true, showInspectorOnShake: true);
    if(!kReleaseMode){
      dio.interceptors.add(alice.getDioInterceptor());
    }
    dio.interceptors.add(EgatInterceptor());

    return MaterialApp(
      navigatorKey: alice.getNavigatorKey(),
      title: 'NavigationDrawer Demo',
      theme: new ThemeData(
        primaryColor: Color(0xfff2b706),
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}