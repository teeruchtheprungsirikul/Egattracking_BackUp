import 'package:egattracking/Topic.dart';
import 'package:egattracking/dao/PostReportDao.dart';
import 'package:egattracking/dao/ProfileDao.dart';
import 'package:egattracking/dao/ReportDao.dart';
import 'package:egattracking/service/UserService.dart';
import 'package:egattracking/view/FormUserSection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';

import '../../main.dart';
import '../BaseStatefulState.dart';
import 'SendReportUseCase.dart';

class AddReportForm16 extends StatefulWidget {
  var reportDao;

  AddReportForm16({ReportDao reportDao = null}) {
    this.reportDao = reportDao;
  }

  @override
  MyCustomAddReportForm16State createState() {
    return MyCustomAddReportForm16State(reportDao: reportDao);
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomAddReportForm16State extends BaseStatefulState<AddReportForm16> {

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  MyCustomAddReportForm16State({ReportDao reportDao = null}) {
    this.reportDao = reportDao;
  }

  Future<ProfileDao> _profile;
  final _formKey = GlobalKey<FormState>();
  final childPadding = const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0);
  List<TextEditingController> mEditingController;

  List<String> topic = Topic.report16;

  @override
  void initState() {
    _profile = UserService.getProfile();
    mEditingController = new List(topic.length);
    for (var i = 0; i < topic.length; i++) {
      mEditingController[i] =
          TextEditingController(text: initialText(topic[i]));
    }
    if(reportDao == null){
      mEditingController[0].text = MyApp.tower.name;
      mEditingController[1].text = MyApp.tower.type;
    }
    super.initState();
  }

  String initialText(String key) {
    if (reportDao == null)
      return "";
    else {
      try {
        return reportDao.values.firstWhere((it) => it.key == key).value;
      } catch (error) {
        return "";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    DateTime now = DateTime.now();
    String today = DateFormat.yMd().format(now);
    String time = DateFormat.Hm().format(now);

    return SafeArea(
        child: Scaffold(
      body: Builder(
          builder: (context) => Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Expanded(child: Text(
                            "การติดตั้งปรับปรุงและเปลี่ยนแปลงอุปกรณ์",
                            style:
                            TextStyle(fontSize: 18, color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 0.0),
                            child: Text("ในหมวด",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black38)),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(5.0, 8.0, 0.0, 0.0),
                            child: Text("งานบำรุงรักษาแบบแก้ไข (cm)",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black)),
                          ),
                        ],
                      ),
                      FutureBuilder(
                          future: _profile,
                          builder: (BuildContext context,
                              AsyncSnapshot<ProfileDao> snapshot) {
                            if (snapshot.hasData) {
                              ProfileDao data = snapshot.data;
                              return FromUserSection(data.firstname, data.team,
                                  snapshot.data.imageUrl);
                            }
                            return Center(
                              child: Loading(
                                  indicator: BallSpinFadeLoaderIndicator(),
                                  size: 40.0,
                                  color: Colors.yellow),
                            );
                          }),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                        child: TextFormField(
                          controller: mEditingController[0],
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: "สายส่ง",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(),
                            ),
                            hintText: "กรอกสายส่ง",
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val.length == 0)
                              return "โปรดกรอกข้อความ";
                            else
                              return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                        child: TextFormField(
                          controller: mEditingController[1],
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: "No เสาที่ส่ง",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(),
                            ),
                            hintText: "กรอกเลขเสา",
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val.length == 0)
                              return "โปรดกรอกข้อความ";
                            else
                              return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                        child: TextFormField(
                          controller: mEditingController[2],
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: "รายละเอียด",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(),
                            ),
                            hintText: "กรอกรายละเอียด",
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                        child: TextFormField(
                          controller: mEditingController[3],
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: "หมายเหตุ",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(),
                            ),
                            hintText: "กรอกรายละเอียด",
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            return null;
                          },
                        ),
                      ),
                      imageSection(),
                      Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                              child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 8.0, 0.0, 8.0),
                                  child: Text("วันที่บันทึก",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black38)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 8.0, 0.0, 8.0),
                                  child: Text(today,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black)),
                                )
                              ],
                            ),
                          )),
                          Flexible(
                              child: Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 8.0, 0.0, 8.0),
                                  child: Text("เวลา",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black38)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 8.0, 0.0, 8.0),
                                  child: Text(time,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black)),
                                )
                              ],
                            ),
                          )),
                          Flexible(
                            child: Padding(
                              padding: childPadding,
                              child: RaisedButton(
                                textColor: Colors.white,
                                color: Colors.amberAccent,
                                onPressed: () {
                                  // Validate returns true if the form is valid, or false
                                  // otherwise.
                                  if (_formKey.currentState.validate()) {
                                    List<Map> body = List();
                                    var towerNo = reportDao != null
                                        ? reportDao.towerId
                                        : MyApp.tower.id;
                                    body.add({
                                      "key": "name",
                                      "type": "string",
                                      "value":
                                          "การติดตั้งปรับปรุงและเปลี่ยนแปลงอุปกรณ์"
                                    });
                                    for (var i = 0; i < topic.length; i++) {
                                      body.add({
                                        "key": topic[i],
                                        "type": "string",
                                        "value": mEditingController[i].text
                                      });
                                    }

                                    var oj = ObjectRequestSendReport(
                                        body, "16", towerNo, reportDao);
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) => Container(
                                              width: 40,
                                              height: 40,
                                              child: Center(
                                                child: Loading(
                                                  indicator:
                                                      BallSpinFadeLoaderIndicator(),
                                                  size: 40.0,
                                                  color: Colors.yellow,
                                                ),
                                              ),
                                            ));
                                    SendReportUseCase.serReport(oj, (response) {
                                      sentAttechment(response);
                                    });
                                  }
                                },
                                child: Text('บันทึก'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
    ));
  }

}
