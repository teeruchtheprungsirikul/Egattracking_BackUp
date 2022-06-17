import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

class MenuFragment extends StatefulWidget {
  @override
  _MenuFragmentState createState() => _MenuFragmentState();
}

class _MenuFragmentState extends State<MenuFragment> {

  List<String> menuList = [
    "test 1",
    "test 2"
  ];
  List<String> androidIdList = [
    "test 1",
    "test 2"
  ];
  List<String> appleAppIdList = [
    "test 1",
    "test 2"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Menu"),
          backgroundColor: Colors.white,
        ),
        body: ListView.separated(
            itemCount: menuList.length,
            itemBuilder:  (context, index) {
              return ListTile(
                title: Text('${menuList[index]}'),
                onTap: (){
                },
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
        )
    );
  }
 }
