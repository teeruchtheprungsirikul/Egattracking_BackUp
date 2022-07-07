import 'package:egattracking/Single.dart';
import 'package:egattracking/service/Interceptor/EgatInterceptor.dart';
import 'package:flutter/material.dart';
import 'package:egattracking/home_page.dart';
import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dao/DataTower.dart';

void main() {
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  
  final appTitle = 'Drawer Demo';
  static Dio dio = Dio();
  late Data tower;
  static SingleFactory mfactory = SingleFactory();

  

  @override
  Widget build(BuildContext context){
    Alice alice = new Alice(showNotification: true, showInspectorOnShake: true);
    if(!kReleaseMode){
      dio.interceptors.add(alice.getDioInterceptor());
    }
    dio.interceptors.add(EgatInterceptor(dio: dio));

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
