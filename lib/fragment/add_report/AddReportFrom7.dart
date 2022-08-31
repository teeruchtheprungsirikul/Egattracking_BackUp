import 'package:egattracking/Topic.dart';
import 'package:egattracking/dao/ProfileDao.dart';
import 'package:egattracking/dao/ReportDao.dart';
import 'package:egattracking/service/UserService.dart';
import 'package:egattracking/view/FormUserSection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../main.dart';
import '../BaseStatefulState.dart';
import 'SendReportUseCase.dart';

class AddReportForm7 extends StatefulWidget {
  final ReportDao? reportDao;

  AddReportForm7({Key? key, this.reportDao}) : super (key: key); 
    


  @override
  MyCustomAddReportForm7State createState() {
    return MyCustomAddReportForm7State(reportDao: reportDao);
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomAddReportForm7State extends BaseStatefulState<AddReportForm7> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  MyCustomAddReportForm7State({ReportDao? reportDao}) {
    this.reportDao = ReportDao(id: "", towerId: "", type: "");
  }
  late Future<ProfileDao> _profile;
  final _formKey = GlobalKey<FormState>();
  final childPadding = const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0);
  late List<TextEditingController> mEditingController;

  List<String> topic = Topic.report7;

  @override
  void initState() {
    _profile = UserService.getProfile();
   mEditingController =
        List.generate(topic.length, (i) => TextEditingController());
    for (var i = 0; i < topic.length; i++) {
      mEditingController[i] =
          TextEditingController(text: initialText(topic[i]));
    }
    if (reportDao!.id == "") {
      mEditingController[0].text = MyApp.tower!.type;
    }
    super.initState();
  }

  String? initialText(String key) {
    if (reportDao == null)
      return "";
    else {
      try {
        return reportDao!.values!.firstWhere((it) => it.key == key).value;
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
                          Expanded(
                              child: Text(
                            "งานจ้างเหมาแรงงานท้องถิ่นตรวจ และบำรุงรักษาสายส่ง",
                            style: TextStyle(fontSize: 18, color: Colors.black),
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
                            child: Text("งานบำรุงรักษาเชิงป้องกัน (PM)",
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
                              ProfileDao data = snapshot.data!;
                              return FromUserSection(data.firstname, data.team,
                                  snapshot.data!.imageUrl!);
                            }
                            return Center(
                                child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.yellow),
                            ));
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
                            if (val!.length == 0)
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
                            maxLines: 5,
                            decoration: InputDecoration(
                              labelText: "รายละเอียดงานจ้าง",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(),
                              ),
                              hintText: "รายละเอียด",
                              //fillColor: Colors.green
                            ),
                            validator: (val) {
                              return null;
                            },
                          )),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                        child: TextFormField(
                          controller: mEditingController[2],
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "ขอบเขตงาน",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(),
                            ),
                            hintText: "กรอกขอบเขตงาน",
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val!.length == 0)
                              return "โปรดกรอกข้อความ";
                            else
                              return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                        child: TextFormField(
                          controller: mEditingController[3],
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "ราคา(บาท)",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(),
                            ),
                            hintText: "กรอกราคา",
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val!.length == 0)
                              return "โปรดกรอกข้อความ";
                            else
                              return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                        child: TextFormField(
                          controller: mEditingController[4],
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "% ความก้าวหน้า",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(),
                            ),
                            hintText: "กรอก % ความก้าวหน้า",
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val!.length == 0)
                              return "โปรดกรอกข้อความ";
                            else
                              return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                        child: TextFormField(
                          controller: mEditingController[5],
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: "ปัญหาที่สำคัญที่พบเจอ",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(),
                            ),
                            hintText: "กรอกรายละเอียด",
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val!.length == 0)
                              return "โปรดกรอกข้อความ";
                            else
                              return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                        child: TextFormField(
                          controller: mEditingController[6],
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
                              //mainAxisAlignment: MainAxisAlignment.start,
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
                              //mainAxisAlignment: MainAxisAlignment.start,
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
                              child: ElevatedButton(
                                child: Text('บันทึก'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.amberAccent,
                                  textStyle: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  // Validate returns true if the form is valid, or false
                                  // otherwise.
                                  if (_formKey.currentState!.validate()) {
                                    List<Map> body = [];
                                    var towerNo = this.reportDao!.towerId != ""
                                        ? this.reportDao!.towerId
                                        : MyApp.tower!.id;
                                    body.add({
                                      "key": "name",
                                      "type": "string",
                                      "value":
                                          "งานจ้างเหมาแรงงานท้องถิ่นตรวจ และบำรุงรักษาสายส่ง"
                                    });
                                    for (var i = 0; i < topic.length; i++) {
                                      body.add({
                                        "key": topic[i],
                                        "type": "string",
                                        "value": mEditingController[i].text
                                      });
                                    }

                                    var oj = ObjectRequestSendReport(
                                        body, "7", towerNo!, reportDao!);
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) => Container(
                                              width: 40,
                                              height: 40,
                                              child: Center(
                                                child: CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation(
                                                          Colors.yellow),
                                                ),
                                              ),
                                            ));
                                    SendReportUseCase.serReport(oj, (response) {
                                      sentAttechment(response);
                                    });
                                  }
                                },
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