import 'dart:io' show Platform, exit;
import 'package:egattracking/Single.dart';
import 'package:egattracking/dao/DataTower.dart';
import 'package:egattracking/dao/ProfileDao.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom1.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom10.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom11.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom12.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom13.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom14.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom15.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom16.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom17.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom18.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom19.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom2.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom20.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom23.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom3.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom4.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom5.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom6.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom7.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom8.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom9.dart';
import 'package:egattracking/fragment/history_fragment.dart';
import 'package:egattracking/fragment/map_fragment.dart';
import 'package:egattracking/fragment/profile_fragment.dart';
import 'package:egattracking/main.dart';
import 'package:egattracking/service/UserService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:url_launcher/url_launcher.dart';

import 'add_report/AddReportFrom24.dart';
import 'add_report/AddReportFrom25.dart';

class ReportFragment extends StatefulWidget {
  final ValueChanged<bool> logoutTriggeredAction;

  ReportFragment({Key? key, required this.logoutTriggeredAction})
      : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<ReportFragment> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final childPadding = const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0);
  Future<ProfileDao>? _profile;
  Single? _single = MyApp.mfactory.newInstant();

  @override
  void initState() {
    _profile = UserService.getProfile();
    UserService.refreshToken();
    _single!.nameTower = "โปรดเลือกเสา";
    super.initState();
  }

  @override
  Widget build(BuildContext? context) {
    // Build a Form widget using the _formKey created above.
    var menu = [
      "งานบำรุงรักษาเชิงป้องกัน (PM)",
      "ตรวจสายส่งโดยการเดินตรวจ",
      "ตรวจสายส่งประจำ 5 ปี",
      "ตรวจสายส่งโดยวิธี Cross check",
      "ตรวจสายส่งทางเฮลิคอปเตอร์",
      "งานตรวจสอบฐานรากสายส่ง",
      "ตรวจวัดค่า Ground Resistance",
      "งานจ้างเหมาแรงงานท้องถิ่นตรวจ และบำรุงรักษาสายส่ง",
      "งานบำรุงรักษาเขตเดินสาย",
      "งานตรวจค่า Safety Clearance และ Ground Clearance ของสายส่ง",
      "งานบำรุงรักษาแก้ไข (CM)",
      "งานตรวจหาสาเหตุสายส่งขัดข้อง",
      "งานบำรุงรักษาเสาสายส่ง",
      "งานปรับปรุงระบบ Grounding",
      "งานบำรุงรักษาสาย Conductor & OHGW. &OPGW.",
      "งานบำรุงรักษาพวงลูกถ้วยและอุปกรณ์ประกอบ",
      "งานตรวจสอบบำรุงรักษาระบบไฟสัญญาณทางอากาศ",
      "งานติดตั้งปรับปรุงและเปลี่ยนแปลงอุปกรณ์",
      "งานตรวจสอบและติดตามการรุกล้ำเขตเดินสาย",
      "สรุปการเปิด - ปิด ใบสั่งงาน (Order)",
      "รายงานการใช้รถ",
      "ความก้าวหน้าแผนพิเศษ",
      "การดำเนินงานเพิ่มผลผลิต",
//      "ระบบคุณภาพ ISO 9001 : 2000",
//      "ระบบ LCM",
      "งานด้านสังคม สิ่งแวดล้อม และกิจกรรมอื่นๆ",
      "รูปภาพการปฏิบัติงาน",
      "แบบรายงานผลการตรวจสายขัดข้อง"
    ];
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 0.0),
                        child: Text(
                          "ผู้บันทึก",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      FutureBuilder(
                          future: _profile,
                          builder: (BuildContext? mContext,
                              AsyncSnapshot<ProfileDao> snapshot) {
                            if (snapshot.hasData) {
                              ProfileDao data = snapshot.data!;
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 8.0, 0.0, 0.0),
                                child: Text(data.firstname,
                                    style: TextStyle(color: Colors.grey)),
                              );
                            }
                            if (snapshot.hasError) {
                              UserService.logout();
                              if (mContext != null) {
                                Phoenix.rebirth(mContext);
                              } else if (context != null) {
                                Phoenix.rebirth(context);
                              } else {
                                exit(0);
                              }
                            }
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircularProgressIndicator(
                                    backgroundColor: Colors.blueGrey,
                                    valueColor: AlwaysStoppedAnimation(
                                        Colors.amberAccent),
                                    strokeWidth: 8.0,
                                  ),
                                ],
                              ),
                            );
                          })
                    ],
                  ),
                  Flexible(
                    child: Container(
                        alignment: AlignmentDirectional.centerEnd,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.person),
                                onPressed: () {
                                  Navigator.push(
                                      context!,
                                      MaterialPageRoute(
                                          builder: (context) => ProfileFragment(
                                              logoutTriggeredAction:
                                                  widget.logoutTriggeredAction)));
                                }),
                            IconButton(
                                icon: Icon(Icons.history),
                                onPressed: () {
                                  Navigator.push(
                                      context!,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HistoryFragment()));
                                }),
                            IconButton(
                                icon: ImageIcon(AssetImage("assets/ruler.png")),
                                onPressed: () {
                                  if (Platform.isIOS) {
                                    try {
                                      launchUrl(Uri.parse(
                                          "https://support.apple.com/th-th/HT208924"));
                                    } catch (e) {}
                                  } else {
                                    launchUrl(Uri.parse(
                                        "https://play.google.com/store/apps/details?id=kr.sira.measure"));
                                  }
                                })
                          ],
                        )),
                  )
                ],
              ),
              Divider(color: Colors.grey),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    textStyle: TextStyle(color: Colors.black),
                    side: BorderSide(
                        color: Colors.grey, 
                        width: 2.0, 
                        style: BorderStyle.solid
                      ),
                  ),
                  onPressed: goToMap,
                  child: Text(_single!.nameTower),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: menu.length,
                itemBuilder: (context, position) {
                  switch (position) {
                    case 0:
                    case 10:
                    case 22:
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
                            child: Text(menu[position],
                                style: TextStyle(
                                    fontSize: 18.0,
                                    backgroundColor: Colors.amberAccent)),
                          ),
                          Divider(color: Colors.grey)
                        ],
                      );
                    default:
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              if (_single!.nameTower == "โปรดเลือกเสา")
                                goToMap();
                              else {
                                switch (position) {
                                  case 1:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm1()));
                                    break;
                                  case 2:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm2()));
                                    break;
                                  case 3:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm3()));
                                    break;
                                  case 4:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm4()));
                                    break;
                                  case 5:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm5()));
                                    break;
                                  case 6:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm6()));
                                    break;
                                  case 7:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm7()));
                                    break;
                                  case 8:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm8()));
                                    break;
                                  case 9:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm9()));
                                    break;
                                  case 11:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm10()));
                                    break;
                                  case 12:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm11()));
                                    break;
                                  case 13:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm12()));
                                    break;
                                  case 14:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm13()));
                                    break;
                                  case 15:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm14()));
                                    break;
                                  case 16:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm15()));
                                    break;
                                  case 17:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm16()));
                                    break;
                                  case 18:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm17()));
                                    break;
                                  case 19:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm18()));
                                    break;
                                  case 20:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm19()));
                                    break;
                                  case 21:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm20()));
                                    break;
                                  case 23:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm23()));
                                    break;
                                  case 24:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm24()));
                                    break;
                                  case 25:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddReportForm25()));
                                    break;
                                }
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(40, 8, 20, 0),
                                child: Text(menu[position],
                                    style: TextStyle(fontSize: 14.0)),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                            height: 8,
                          )
                        ],
                      );
                  }
                },
              )),
            ],
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          launchUrl(Uri.parse(
              "https://www.egat.co.th/index.php?option=com_content&view=article&id=80&Itemid=116"));
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            child: Image.asset("mainLogo.png"),
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  void goToMap() async {
    Data result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => MapFragment()));
    MyApp.tower = result;
    setState(() {
      _single!.nameTower = result.name.replaceAll("_", "-") + " " + result.type;
    });
  }
}
